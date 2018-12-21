clear all;
close all;
%% Importation de l'itinéraire depuis Google
disp('Recherche Itinéraire');

%Clé API donnée par Google
keyAPI = 'AIzaSyC5RUqHWJvBOwrV4rUXYKyNBrzII5Lhc3E';

%Départ et arrivée de l'itinéraire
depart = 'Martigny, Valais';
destination = 'Sion, Valais';

%Recherche itinéraire, coordonnées GPS
[x1,y1,latz, lonz, distance, time] = getDirections(depart,destination,keyAPI,1);

%Recherche altitude de chaque coordonnée GPS
z1 = getElevation(x1, y1, keyAPI);

% Calcul de la distance et de la pente entre deux coordonnées
[d,c_dist,dist_tot, x, y, z] = getDistance(x1, y1, z1);

% Interpolation à interval régulier
c=linspace(0,c_dist(length(c_dist)),c_dist(length(c_dist))/10); %interval
x1_int=interp1(c_dist,x1,c,'pchip');
y1_int=interp1(c_dist,y1,c,'pchip');
z1_int=interp1(c_dist,z1,c,'pchip');

% Calcul de la distance et de la pente interpolée
[d_int,c_dist_int,dist_tot_int, x_int, y_int, z_int, dvdo, alpha_int] = getDistance(x1_int, y1_int, z1_int);

% Caractéristiques de l'itinéraire (dénivelé, poit culminant, ..)
[dp, dn, denTot, plpb, pc]=getCharacteristics(z1_int);

%% Détection d'un tunnel ou d'un pont
disp('Détection Tunnel');

%Caractéristiques de détection
penteMontante=0.4;
penteDescendante=-1;
diffAltiPos = 0;
diffAltiNeg = 0;

[z1Corr_int, zCorr_int, pente] = getBuilding(z1_int, c_dist_int, penteMontante, penteDescendante, diffAltiPos, diffAltiNeg);

%% Limitation vitesse
disp('Limitation de vitesse estimée');
accCentriMax = 6;%m/s^2
[vlim, at, atWW, dxdl,d2xdl,dydl,d2ydl, phi]=getMaxSpeed(x_int,y_int,z_int,d_int,c_dist_int,latz,lonz,distance,time, accCentriMax);
vlim(1)=0.5; %nécessaire pour la génération du profil de vitesse

%% Anticipation, accélération maximum
disp('Anticipation des virages');

% Freinage et accélération maximum
acc_in = 2;
acc_out = 1;

[vlim, vlimX] = getAnticipation(c_dist_int,vlim, acc_in, acc_out);


%% Limites moteur
disp('Caractéristiques du moteur');

% Caractéristiques de la chaine de traction
r =9.73;
nr=0.9;
rr = 0.33;

coupleMaxMoteur = 660; %Nm
coupleMinMoteur = -660;
coupleMaxRoues = coupleMaxMoteur * nr * r; %Nm
coupleMinRoues = coupleMinMoteur * nr * r; %Nm
puissanceMaxMoteur = 310380; %W
puissanceMaxRoues = puissanceMaxMoteur * nr; %W
puissanceMinMoteur = -310380; %W
puissanceMinRoues = puissanceMinMoteur * nr; %W

vitesseMax = 250/3.6;%m/s
vitesseMinReg = 25/3.6;
vitesseDecroRadS = puissanceMaxRoues / coupleMaxRoues;
vitesseDecroMS_Max = puissanceMaxRoues / coupleMaxRoues * rr;
vitesseDecroMS_Min = puissanceMinRoues / coupleMinRoues * rr;

vitesseCouple = 0:1:vitesseMax;

for k=1:1:vitesseMax+1
    if vitesseCouple(k) <= vitesseDecroMS_Max
        seuilCoupleMax(k) = coupleMaxRoues;
    elseif vitesseCouple(k) >= vitesseDecroMS_Max
        seuilCoupleMax(k)= puissanceMaxRoues / (vitesseCouple(k)/rr);
    end
end

for k=1:1:vitesseMax+1
    if vitesseCouple(k) <= vitesseDecroMS_Min
        seuilCoupleMin(k) = coupleMinRoues;
    elseif vitesseCouple(k) >= vitesseDecroMS_Min
        seuilCoupleMin(k)= puissanceMinRoues / (vitesseCouple(k)/rr);
    end
end

i = 2;
for k=1:1:vitesseMinReg+4
    
    if vitesseCouple(k) <= vitesseMinReg
        seuilCoupleMin(k)=0;
    elseif vitesseCouple(k) > vitesseMinReg
        seuilCoupleMin(k)=coupleMinRoues * (i/4);
        i=i+1;
    end
    
end

for k=1:1:vitesseMax+1
    puissanceMax(k) = (vitesseCouple(k)/rr/nr)*seuilCoupleMax(k);
    puissanceMin(k) = (vitesseCouple(k)/rr/nr)*seuilCoupleMin(k);
end

%% OUTPUT
figure('Name','Caractéristiques de la route','NumberTitle','off');
subplot(2,2,1);
plot(c_dist_int(1:1:length(c_dist_int)-1), pente)
%plot(y1_int, x1_int)
title('Plan de la route');
xlabel('Longitude [-]');
ylabel('Latitude [-]');
subplot(2,2,2);
plot( c_dist_int(1:1:length(c_dist_int)-1), zCorr_int)
%plot(c_dist_int/1000, z1_int, c_dist_int/1000, z1Corr_int)
title('Profil de la route');
xlabel('Distance [km]');
ylabel('Altitude [m]');
subplot(2,2,[3,4])
%plot(c_dist_int/1000, z1_int, c_dist_int/1000, z1Corr_int)
plot(c_dist_int,vlimX*3.6,c_dist_int, vlim*3.6);
title('Profil de vitesse');
xlabel('Distance [m]');
ylabel('Vitesse [m/s]');
figure(5)
plot(vitesseCouple*3.6, seuilCoupleMax/nr/r, vitesseCouple*3.6, seuilCoupleMin/nr/r)
yyaxis right
plot(vitesseCouple*3.6, puissanceMax/1000,'b--',  vitesseCouple*3.6, puissanceMin/1000,'r--')
YAxis(2).Color = 'k';