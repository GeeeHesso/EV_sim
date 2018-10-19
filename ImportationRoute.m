%% Itinéraire, altitude

%Clé API donnée par Google
keyAPI = 'AIzaSyC5RUqHWJvBOwrV4rUXYKyNBrzII5Lhc3E';

%Recherche itinéraire
disp('Recherche Itinéraire');
%[x1,y1] = getDirections('46.806679, 7.168778','46.802544, 7.172344',keyAPI);
%[x1,y1] = getDirections('46.295183, 8.058002','46.297603, 8.044758',keyAPI);
%[x1,y1] = getDirections('Vissigen, Sion','Murax, Sion',keyAPI);
[x1,y1] = getDirections('Martigny','Sion, Valais',keyAPI);

%Recherche altitude de chaque coordonnée GPS
disp('Recherche Altitude');
z1 = getElevation(x1, y1, keyAPI);

%% Calcul de la distance et de la pente entre deux coordonnées
disp('Recherche Distance');
[d,c_dist,dist_tot, x, y, z, dvdo] = getDistance(x1, y1, z1);

%% Caractéristiques de l'itinéraire
disp('Recherche Caractéristiques de la route');
[dp, dn, denTot, plpb, pc]=getCharacteristics(z1);

%% Détection d'un tunnel ou d'un pont
%Caractéristiques de détection
disp('Recherche Infrastructure');
seuilHaut =0.15; %Pente montante
seuilBas = -0.15; %Pente descendante
nivHaut=20; %différence d'altitude positive
nivBas=-20; %différence d'altitude négative

z2 = getBuilding(z1, c_dist,d, seuilHaut, seuilBas ,nivHaut ,nivBas);


%% OUTPUT
figure('Name','Caractéristiques de la route','NumberTitle','off');
subplot(2,1,1);
plot(y1,x1,'b-x');
title('Plan de la route');
xlabel('Longitude [-]');
ylabel('Latitude [-]');
subplot(2,1,2)
plot(c_dist,z1, c_dist,z2);
title('Profil de la route');
xlabel('Distance [m]');
ylabel('Altitude [m]');



