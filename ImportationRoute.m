clear all;
%% Itin�raire, altitude

%Cl� API donn�e par Google
keyAPI = 'AIzaSyC5RUqHWJvBOwrV4rUXYKyNBrzII5Lhc3E';

%Recherche itin�raire
disp('Recherche Itin�raire');
[x1,y1] = getDirections('46.088227,7.055239','46.098406, 7.055982',keyAPI, 0);

%Recherche altitude de chaque coordonn�e GPS
disp('Recherche Altitude');
z1 = getElevation(x1, y1, keyAPI);

%% Calcul de la distance et de la pente entre deux coordonn�es
disp('Recherche Distance');
[d,c_dist,dist_tot, x, y, z, dvdo] = getDistance(x1, y1, z1);

%% Interpolation
c=linspace(0,c_dist(length(c_dist)),c_dist(length(c_dist))/2);
x1_int=interp1(c_dist,x1,c,'spline');
y1_int=interp1(c_dist,y1,c,'spline');
z1_int=interp1(c_dist,z1,c,'spline ');

%% Calcul de la distance et de la pente entre deux coordonn�es
disp('Recherche Distance interpol�e');
[d_int,c_dist_int,dist_tot_int, x_int, y_int, z_int, dvdo_int] = getDistance(x1_int, y1_int, z1_int);


%% Caract�ristiques de l'itin�raire
disp('Recherche Caract�ristiques de la route');
[dp, dn, denTot, plpb, pc]=getCharacteristics(z1_int);

%% D�tection d'un tunnel ou d'un pont
%Caract�ristiques de d�tection
% disp('Recherche Infrastructure');
% seuilHaut =0.5; %Pente montante
% seuilBas = -0.4; %Pente descendante
% nivHaut=6; %diff�rence d'altitude positive
% nivBas=-6; %diff�rence d'altitude n�gative
% 
% z2 = getBuilding(z9, c, seuilHaut, seuilBas ,nivHaut ,nivBas);

%% Vitesse maximum
disp('Recherche Vitesse max');
speedLimit = 80/3.6;
accCentriMax = 7;
[vlim, vlim_ref,at]=getMaxSpeed(x_int,y_int,z_int,d_int,speedLimit,accCentriMax);


%% OUTPUT
figure('Name','Caract�ristiques de la route','NumberTitle','off');
subplot(4,1,1);
plot(y1,x1,y1_int,x1_int);
title('Plan de la route');
xlabel('Longitude [-]');
ylabel('Latitude [-]');
subplot(4,1,2)
plot(c,z1_int);
title('Profil de la route');
xlabel('Distance [m]');
ylabel('Altitude [m]');
subplot(4,1,3);
plot(c_dist_int,vlim_ref,c_dist_int,vlim)
title('Limitation de vitesse');
xlabel('Distance [m]');
ylabel('Vitesse[m/s]');
subplot(4,1,4);
plot(c_dist_int(1:1:length(c_dist_int)-2),at)

