clear all;
close all;
%% Importation de l'itin�raire depuis Google
disp('Recherche Itin�raire');

%Cl� API donn�e par Google
keyAPI = 'AIzaSyC5RUqHWJvBOwrV4rUXYKyNBrzII5Lhc3E';

%D�part et arriv�e de l'itin�raire
depart = 'Martigny, Valais';
destination = 'Bovernier, Valais';

%Recherche itin�raire, coordonn�es GPS
[x1,y1,latz, lonz, distance, time] = getDirections(depart,destination,keyAPI,1);

%Recherche altitude de chaque coordonn�e GPS
z1 = getElevation(x1, y1, keyAPI);

% Calcul de la distance et de la pente entre deux coordonn�es
[d,c_dist,dist_tot, x, y, z] = getDistance(x1, y1, z1);

% Interpolation � interval r�gulier
c=linspace(0,c_dist(length(c_dist)),c_dist(length(c_dist))/5); %interval

x1_int=interp1(c_dist,x1,c);
y1_int=interp1(c_dist,y1,c);
z1_int=interp1(c_dist,z1,c);


%Filtrage des donn�es X,Y
size_window=7; %Must be odd
window=1/size_window*ones(1,size_window);
x1_filter=conv(x1_int,window,"same");
y1_filter=conv(y1_int,window,"same");

%Correction des premiers/derniers points
x1_filter(1:(size_window-1)/2)=x1_int(1:(size_window-1)/2);
x1_filter(end-(size_window-1)/2:end)=x1_int(end-(size_window-1)/2:end);

y1_filter(1:(size_window-1)/2)=y1_int(1:(size_window-1)/2);
y1_filter(end-(size_window-1)/2:end)=y1_int(end-(size_window-1)/2:end);

%Filtrage des donn�es Z
size_window=51; %Must be odd
window=1/size_window*ones(1,size_window);
z1_filter=conv(z1_int,window,"same");

z1_filter(1:(size_window-1)/2)=z1_int(1:(size_window-1)/2);
z1_filter(end-(size_window-1)/2:end)=z1_int(end-(size_window-1)/2:end);

% Calcul de la distance et de la pente interpol�e
[d_int,c_dist_int,dist_tot_int, x_int, y_int, z_int, dvdo, alpha_int] = getDistance(x1_filter, y1_filter, z1_filter);

% Caract�ristiques de l'itin�raire (d�nivel�, poit culminant, ..)
[dp, dn, denTot, plpb, pc]=getCharacteristics(z1_filter);

%% D�tection d'un tunnel ou d'un pont
disp('D�tection Tunnel');

%Caract�ristiques de d�tection
penteMontante=0.2;
penteDescendante=-0.2;
diffAltiPos = 0;
diffAltiNeg = 0;

[z1Corr_int, zCorr_int, pente] = getBuilding(z1_filter, c_dist_int, penteMontante, penteDescendante, diffAltiPos, diffAltiNeg);

%pente2 = interp1(c_dist_int,pente,'pchip');

%% Limitation vitesse
disp('Limitation de vitesse estim�e');
accCentriMax = 6;%m/s^2
[vlim, at, atWW, dxdl,d2xdl,dydl,d2ydl,dzdl,d2zdl,phi]=getMaxSpeed(x_int,y_int,z_int,d_int,c_dist_int,latz,lonz,distance,time, accCentriMax);
vlim(1)=0.5; %n�cessaire pour la g�n�ration du profil de vitesse

%% Anticipation, acc�l�ration maximum
disp('Anticipation des virages');

% Freinage et acc�l�ration maximum
acc_in = 2;
acc_out = 1;

[vlim, vlimX] = getAnticipation(c_dist_int,vlim, acc_in, acc_out);


%% Limites moteur
disp('Caract�ristiques du moteur');

% Caract�ristiques de la chaine de traction
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
figure('Name','Caract�ristiques de la route','NumberTitle','off');
subplot(3,1,1);
%plot(y1,x1,y1_int, x1_int,y1_filter,x1_filter)
plot(c_dist_int(1:1:length(c_dist_int)-1), pente)
title('Plan de la route');
xlabel('Longitude [-]');
ylabel('Latitude [-]');
subplot(3,1,2);
plot(c_dist/1000, z1, c_dist_int/1000, z1_int, c_dist_int/1000, z1_filter,c_dist_int/1000,z1Corr_int)
title('Profil de la route');
xlabel('Distance [km]');
ylabel('Altitude [m]');
subplot(3,1,3)
%plot(c_dist_int/1000, z1_int, c_dist_int/1000, z1Corr_int)
plot(c_dist_int,vlimX*3.6,c_dist_int, vlim*3.6);
title('Profil de vitesse');
xlabel('Distance [m]');
ylabel('Vitesse [m/s]');
% figure(5)
% plot(vitesseCouple*3.6, seuilCoupleMax/nr/r, vitesseCouple*3.6, seuilCoupleMin/nr/r)
% yyaxis right
% plot(vitesseCouple*3.6, puissanceMax/1000,'b--',  vitesseCouple*3.6, puissanceMin/1000,'r--')
% YAxis(2).Color = 'k';