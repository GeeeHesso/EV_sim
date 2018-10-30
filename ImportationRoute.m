%clear all;
%% Itinéraire, altitude

%Clé API donnée par Google
keyAPI = 'AIzaSyC5RUqHWJvBOwrV4rUXYKyNBrzII5Lhc3E';

%Recherche itinéraire
disp('Recherche Itinéraire');
depart = 'Martigny';
destination = 'Sion, Valais';
[x1,y1,latz1, lonz1, distance1, time1] = getDirections(depart,destination,keyAPI,0);
[x2,y2, latz2, lonz2, distance2, time2] = getDirections(depart,destination,keyAPI,1);

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
disp('Recherche Distance interpolée');
[d_int,c_dist_int,dist_tot_int, x_int, y_int, z_int, dvdo, alpha_int] = getDistance(x1_int, y1_int, z1_int);
[d2_int,c_dist2_int,dist2_tot_int, x_2_int, y_2_int, z_2_int, dvdo2, alpha2_int] = getDistance(x2_int, y2_int, z2_int);

% 
% %% Caractéristiques de l'itinéraire
% disp('Recherche Caractéristiques de la route');
% [dp, dn, denTot, plpb, pc]=getCharacteristics(z1_int);
% 
% %% Détection d'un tunnel ou d'un pont
% %Caractéristiques de détection
% disp('Recherche Infrastructure');
%  
% penteMontante=0.2; %différence de pente montante
% penteDescendante=-0.2; %différence de pente descendante
% diffAltiPos = 5;
% diffAltiNeg = -5;
% 
% [z1Corr_int, zCorr_int, pente] = getBuilding(z1_int, c_dist_int, penteMontante, penteDescendante, diffAltiPos, diffAltiNeg);
% [z2Corr_int, z_2_Corr_int] = getBuilding(z2_int, c_dist2_int, penteMontante, penteDescendante, diffAltiPos, diffAltiNeg);

% %% Vitesse maximum
disp('Recherche Vitesse max');
accCentriMax = 7;%m/s^2
[vlim, at]=getMaxSpeed(x_int,y_int,z_int,d_int,c_dist_int,latz1,lonz1,distance1,time1, accCentriMax);
[vlim2, at2]=getMaxSpeed(x_2_int,y_2_int,z_2_int,d2_int,c_dist2_int,latz2,lonz2,distance2,time2, accCentriMax);

%% OUTPUT
figure('Name','Caractéristiques de la route','NumberTitle','off');
subplot(2,1,1);
plot(y1_int,x1_int,'b' ,y2_int, x2_int,'r', lonz1,latz1,'x-k');
title('Plan de la route');
xlabel('Longitude [-]');
ylabel('Latitude [-]');
subplot(2,1,2)
plot(c,z1_int,'b');
subplot(2,1,2)
plot(c2,z2_int,'r');
title('Profil de la route');
xlabel('Distance [m]');
ylabel('Altitude [m]');
figure('Name','Vitesse Maximum','NumberTitle','off');
subplot(2,1,1)
plot(c_dist_int,vlim,'b');
subplot(2,1,2)
plot(c_dist2_int,vlim2,'r');

