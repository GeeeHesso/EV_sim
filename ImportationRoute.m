%% Itin�raire, altitude

%Cl� API donn�e par Google
keyAPI = 'AIzaSyC5RUqHWJvBOwrV4rUXYKyNBrzII5Lhc3E';

%Recherche itin�raire
disp('Recherche Itin�raire');
%[x1,y1] = getDirections('46.806679, 7.168778','46.802544, 7.172344',keyAPI);
%[x1,y1] = getDirections('46.295183, 8.058002','46.297603, 8.044758',keyAPI);
%[x1,y1] = getDirections('Vissigen, Sion','Murax, Sion',keyAPI);
[x1,y1] = getDirections('Martigny','Sion, Valais',keyAPI);

%Recherche altitude de chaque coordonn�e GPS
disp('Recherche Altitude');
z1 = getElevation(x1, y1, keyAPI);

%% Calcul de la distance et de la pente entre deux coordonn�es
disp('Recherche Distance');
[d,c_dist,dist_tot, x, y, z, dvdo] = getDistance(x1, y1, z1);

%% Caract�ristiques de l'itin�raire
disp('Recherche Caract�ristiques de la route');
[dp, dn, denTot, plpb, pc]=getCharacteristics(z1);

%% D�tection d'un tunnel ou d'un pont
%Caract�ristiques de d�tection
disp('Recherche Infrastructure');
seuilHaut =0.15; %Pente montante
seuilBas = -0.15; %Pente descendante
nivHaut=20; %diff�rence d'altitude positive
nivBas=-20; %diff�rence d'altitude n�gative

z2 = getBuilding(z1, c_dist,d, seuilHaut, seuilBas ,nivHaut ,nivBas);


%% OUTPUT
figure('Name','Caract�ristiques de la route','NumberTitle','off');
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



