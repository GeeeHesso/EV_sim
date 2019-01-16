clear all;
close all;

%% Importation de l'itinéraire depuis Google
disp('Recherche Itinéraire');

%Clé API donnée par Google
keyAPI = 'AIzaSyC5RUqHWJvBOwrV4rUXYKyNBrzII5Lhc3E';

%Départ et arrivée de l'itinéraire

%Martigny - Bovernier
depart = 'Martigny, Valais';
destination = 'Aigle, Valais';

%Martigny - Bovernier
% depart = '46.096471, 7.080190';
% destination = '46.088813, 7.059937';

%Gampel - Stalden
% depart = '46.297426, 7.861801';
% destination = '46.269543, 7.880508';

%Tunnel de Sierre
% depart = '46.280220, 7.516294';
% destination = '46.285172, 7.548255';

%Tunnel de Bagnes
% depart = '46.036921, 7.289219';
% destination = '46.032096, 7.297328';

%Tunnel Platta
% depart = '46.240660, 7.373995';
% destination = '46.241642, 7.360205';

%Tunnel Saint Maurice (oscillations sans correction du tunnel)
% depart = '46.208984, 7.010082';
% destination = '46.226929, 7.003779';


%Recherche itinéraire, coordonnées GPS
[x1,y1,latz, lonz, distance, time] = getDirections(depart,destination,keyAPI,1);

%Recherche altitude de chaque coordonnée GPS
z1 = getElevation(x1, y1, keyAPI);

% Calcul de la distance et de la pente entre deux coordonnées
[d,c_dist,dist_tot, x, y, z] = getDistance(x1, y1, z1);

% Interpolation à interval régulier
c=linspace(0,c_dist(length(c_dist)),c_dist(length(c_dist))/10); %interval

x1_int=interp1(c_dist,x1,c);
y1_int=interp1(c_dist,y1,c);
z1_int=interp1(c_dist,z1,c);

% Rajout de point fictif pour le filtrage
a=1;
w=500;
x1_save = x1_int;
y1_save = y1_int;
z1_save = z1_int;
xf = x1_int(1)
yf = y1_int(1)
zf = z1_int(1);
xl= x1_int(length(x1_int));
yl= y1_int(length(x1_int));
zl = z1_int(length(z1_int));
for k=1:1:2*w+length(z1_int)
    if k<w
        x1_intx(k)=xf;
        y1_intx(k)=yf;
        z1_intx(k)=zf;     
    elseif k >= w && k< w+length(z1_int)
        x1_intx(k)=x1_int(a);
        y1_intx(k)=y1_int(a);
        z1_intx(k)=z1_int(a);
        a=a+1;
    elseif k>=w+length(z1_int)
        x1_intx(k)=xl;
        y1_intx(k)=yl;
        z1_intx(k)=zl;
    end
end
x1_int=x1_intx;
y1_int=y1_intx;
z1_int=z1_intx;

%Filtrage des données X,Y
size_window=5; %Must be odd
window=1/size_window*ones(1,size_window);
x1_filter=conv(x1_int,window,"same");
y1_filter=conv(y1_int,window,"same");

%Correction des premiers/derniers points
x1_filter(1:(size_window-1)/2)=x1_int(1:(size_window-1)/2);
x1_filter(end-(size_window-1)/2:end)=x1_int(end-(size_window-1)/2:end);

y1_filter(1:(size_window-1)/2)=y1_int(1:(size_window-1)/2);
y1_filter(end-(size_window-1)/2:end)=y1_int(end-(size_window-1)/2:end);

%Filtrage des données Z
size_window=21; %Must be odd
window=1/size_window*ones(1,size_window);
z1_filter=conv(z1_int,window,"same");

z1_filter(1:(size_window-1)/2)=z1_int(1:(size_window-1)/2);
z1_filter(end-(size_window-1)/2:end)=z1_int(end-(size_window-1)/2:end);

%On renlève les points fictifs
a=1;
w=500;
for k=1:1:length(z1_filter)
    if k>=w && k<length(z1_filter)-w
        x1_filterx(a)=x1_filter(k);
        y1_filterx(a)=y1_filter(k);
        z1_filterx(a)=z1_filter(k);
        a=a+1;
    end
end
x1_filter=x1_filterx
y1_filter=y1_filterx
z1_filter=z1_filterx
x1_int=x1_save;
y1_int=y1_save;
z1_int=z1_save;

% Calcul de la distance et de la pente interpolée
[d_int,c_dist_int,dist_tot_int, x_int, y_int, z_int, dvdo, alpha_int, pente] = getDistance(x1_filter, y1_filter, z1_filter);

% Caractéristiques de l'itinéraire (dénivelé, poit culminant, ..)
[dp, dn, denTot, plpb, pc]=getCharacteristics(z1_filter);

%% Détection d'un tunnel ou d'un pont
disp('Détection Tunnel');

%Caractéristiques de détection
penteMontante=0.1;
penteDescendante=-0.1;
diffAltiPos = 0;
diffAltiNeg = 0;

 [z1Corr_int, zCorr_int, alphaCorr_int, pente2] = getBuilding(z1_filter, c_dist_int, penteMontante, penteDescendante, diffAltiPos, diffAltiNeg);
% alphaCorr_int = alpha_int;
% zCorr_int = z_int;
% z1Corr_int = z1_filter;


% Calcul de la distance et de la pente interpolée
[d_int,c_dist_int,dist_tot_int, x_int, y_int, z_int, dvdo, alpha_int, pente] = getDistance(x1_filter, y1_filter, z1Corr_int);

% Caractéristiques de l'itinéraire (dénivelé, poit culminant, ..)
[dp, dn, denTot, plpb, pc]=getCharacteristics(z1Corr_int);
%% Limitation vitesse
disp('Limitation de vitesse estimée');
accCentriMax = 6;%m/s^2
[vlim, at, atWW, dxdl,d2xdl,dydl,d2ydl,dzdl,d2zdl,phi]=getMaxSpeed(x_int,y_int,z_int,d_int,c_dist_int,latz,lonz,distance,time, accCentriMax);
%vlim(1)=0.5; %nécessaire pour la génération du profil de vitesse

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
subplot(3,1,1);
%plot(y1,x1,y1_int, x1_int,y1_filter,x1_filter)
%plot(c_dist_int(1:1:length(c_dist_int)-1), pente)
plot(c_dist_int(1:1:length(c_dist_int)-1), alpha_int,c_dist_int(1:1:length(c_dist_int)-1), alphaCorr_int)
%plot(c_dist_int(1:1:length(c_dist_int)-1), pente, c_dist_int(1:1:length(c_dist_int)-1), pente2)
title('Plan de la route');
xlabel('Longitude [-]');
ylabel('Latitude [-]');
subplot(3,1,2);
plot(c_dist_int/1000, z1_int, c_dist_int/1000, z1_filter,c_dist_int/1000,z1Corr_int)
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