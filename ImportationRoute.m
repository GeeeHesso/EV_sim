clear all;
close all;

%% Importation de l'itinéraire depuis Google
disp('Recherche Itinéraire');

%Clé API donnée par Google
%https://developers.google.com/maps/documentation/directions/get-api-key
keyAPI = 'METTRE SA CLE API ICI';

%Départ et arrivée de l'itinéraire

%Pont Simplon (Ganter)
depart = 'Martigny';
destination = 'Bovernier, Valais';

%Pont de la Poya
% depart = 'Granges-Paccot, Fribourg';
% destination = 'Uebemil, Fribourg';

%Pont Ormont
% depart = 'Ormont-Dessous, Vaud';
% destination = 'Ormont-Dessus, Vaud';

%Pont Gueuroz
%  depart = 'Martigny';
%  destination = 'Salvan';

 %Pont Simplon (Ganter)
% depart = '46.297615, 8.043717';
% destination = '46.294403, 8.063577';

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
precision = 1; %1 = haute précision, 0 = basse précision
[x1,y1,latz, lonz, distance, time] = getDirections(depart,destination,keyAPI,precision);

%Recherche altitude de chaque coordonnée GPS
z1 = getElevation(x1, y1, keyAPI);

% Calcul de la distance et de la pente entre deux coordonnées
[d,c_dist,dist_tot, x, y, z] = getDistance(x1, y1, z1);

distInterp =5 %distance d'interpolation
sizeXYFilter = 5; %taille de la fenêtre de lissage pour XY
sizeZFilter = 21; %taille de la fenêtre de lissage pour Z
[x1_filter, y1_filter, z1_filter, x1_int, y1_int, z1_int] = getTraitementDonnees(distInterp,sizeXYFilter,sizeZFilter,x1,y1,z1,c_dist)

 % Calcul de la distance et de la pente interpolée
[d_int,c_dist_int,dist_tot_int, x_int, y_int, z_int, dvdo, alpha_int, pente] = getDistance(x1_filter, y1_filter, z1_filter);


%% Détection d'un tunnel ou d'un pont
disp('Détection Tunnel');

%Caractéristiques de détection
penteMontante=0.3;
penteDescendante=-0.3;
diffAltiPos = 0;
diffAltiNeg = 0;

[z1Corr_int, zCorr_int, alphaCorr_int, pente2] = getBuilding(z1_filter, c_dist_int, penteMontante, penteDescendante, diffAltiPos, diffAltiNeg);
% alphaCorr_int = alpha_int;
% zCorr_int = z_int;
% z1Corr_int = z1_filter;

% Calcul de la distance et de la pente corrigée
[d_int,c_dist_int,dist_tot_int, x_int, y_int, z_int, dvdo, alpha_int, pente] = getDistance(x1_filter, y1_filter, z1Corr_int);

% Caractéristiques de l'itinéraire (dénivelé, poit culminant, ..)
[dp, dn, denTot, plpb, pc]=getCharacteristics(z1Corr_int);

%% Limitation vitesse
disp('Limitation de vitesse estimée');
accCentriMax = 6;%m/s^2
[vlim, at, atWW, dxdl,d2xdl,dydl,d2ydl,dzdl,d2zdl,phi]=getMaxSpeed(x_int,y_int,z_int,d_int,c_dist_int,latz,lonz,distance,time, accCentriMax);
vlim(1)=0.1;
vlim(length(vlim))=0.1;

%% Anticipation, accélération maximum
disp('Anticipation des virages');

% Freinage et accélération maximum
acc_in = 2;
acc_out = 1;

[vlim, vlimX] = getAnticipation(c_dist_int,vlim, acc_in, acc_out);

%% Limite température
temperature = [-20,-10,0,25,40];
temp = (-20:1:40);
deepOfDischarge = [0.66, 0.85, 0.9, 1, 1.01];
cyLi = [0,100,200,300,400,500];
cycleLife = (0:1:500);
dischargeCapacity = [1, 0.88, 0.8, 0.77, 0.72, 0.67];

dod=interp1(temperature, deepOfDischarge, temp);
dod2=interp1(cyLi, dischargeCapacity, cycleLife);

%% OUTPUT
figure('Name','Caractéristiques de la route','NumberTitle','off');
subplot(3,1,1);
plot(y1,x1,y1_int, x1_int,y1_filter,x1_filter)
title('Plan de la route');
xlabel('Longitude [-]');
ylabel('Latitude [-]');
subplot(3,1,2);
plot(c_dist_int/1000, z1_int, c_dist_int/1000, z1_filter,c_dist_int/1000,z1Corr_int)
title('Profil de la route');
xlabel('Distance [km]');
ylabel('Altitude [m]');
subplot(3,1,3)
plot(c_dist_int,vlimX*3.6,c_dist_int, vlim*3.6);
title('Profil de vitesse');
xlabel('Distance [m]');
ylabel('Vitesse [m/s]');