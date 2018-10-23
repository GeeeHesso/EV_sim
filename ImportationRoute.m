clear all;
%% Itinéraire, altitude

%Clé API donnée par Google
keyAPI = 'AIzaSyC5RUqHWJvBOwrV4rUXYKyNBrzII5Lhc3E';

%Recherche itinéraire
disp('Recherche Itinéraire');
[x1,y1] = getDirections('Saint-Gingolph','Obergoms',keyAPI,0);
[x2,y2] = getDirections('Saint-Gingolph','Obergoms',keyAPI,1);

%Recherche altitude de chaque coordonnée GPS
disp('Recherche Altitude');
z1 = getElevation(x1, y1, keyAPI);
z2 = getElevation(x2, y2, keyAPI);

%% Calcul de la distance et de la pente entre deux coordonnées
disp('Recherche Distance');
[d,c_dist,dist_tot, x, y, z] = getDistance(x1, y1, z1);
[d2,c_dist2,dist_tot2, x_2, y_2, z_2] = getDistance(x2, y2, z2);

%% Interpolation
c=linspace(0,c_dist(length(c_dist)),c_dist(length(c_dist))/10);
c2=linspace(0,c_dist2(length(c_dist2)),c_dist2(length(c_dist2))/10);

x1_int=interp1(c_dist,x1,c,'pchip');%,'extrap');
x2_int=interp1(c_dist2,x2,c2,'pchip');
y1_int=interp1(c_dist,y1,c,'pchip');%,'extrap');
y2_int=interp1(c_dist2,y2,c2,'pchip');
z1_int=interp1(c_dist,z1,c,'pchip');%,'extrap');
z2_int=interp1(c_dist2,z2,c2,'pchip');%,'extrap');

% %% Calcul de la distance et de la pente entre deux coordonnées
% disp('Recherche Distance interpolée');
% [d_int,c_dist_int,dist_tot_int, x_int, y_int, z_int, dvdo] = getDistance(x1_int, y1_int, z1_int);
% 
% 
% %% Caractéristiques de l'itinéraire
% disp('Recherche Caractéristiques de la route');
% [dp, dn, denTot, plpb, pc]=getCharacteristics(z1_int);
% 
% %% Détection d'un tunnel ou d'un pont
% %Caractéristiques de détection
% % disp('Recherche Infrastructure');
% % % 
% % nivHaut=0.1; %différence d'altitude positive
% % nivBas=-0.1; %différence d'altitude négative
% % % 
% %  [z1Corr_int, zCorr_int] = getBuilding(z1_int, c_dist_int, nivHaut, nivBas);
% 
% %% Vitesse maximum
% disp('Recherche Vitesse max');
% speedLimit = 120/3.6;
% accCentriMax = 7;
% [vlim, vlim_ref,at]=getMaxSpeed(x_int,y_int,z_int,d_int,speedLimit,accCentriMax);
% 

%% OUTPUT
figure('Name','Caractéristiques de la route','NumberTitle','off');
subplot(2,1,1);
plot(y1_int,x1_int,'b' ,y2_int, x2_int,'r');
title('Plan de la route');
xlabel('Longitude [-]');
ylabel('Latitude [-]');
subplot(2,1,2)
plot(c,z1_int,'b',c2,z2_int,'r');%,c,z1Corr_int,'g');
title('Profil de la route');
xlabel('Distance [m]');
ylabel('Altitude [m]');
% subplot(4,1,3);
% plot(c_dist_int,vlim_ref,c_dist_int,vlim)
% title('Limitation de vitesse');
% xlabel('Distance [m]');
% ylabel('Vitesse[m/s]');
% subplot(4,1,4);
% plot(c_dist_int(1:1:length(c_dist_int)-2),at)

