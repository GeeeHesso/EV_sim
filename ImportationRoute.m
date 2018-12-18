clear all;

%% Importation de l'itin�raire depuis Google
disp('Recherche Itin�raire');

%Cl� API donn�e par Google
keyAPI = 'AIzaSyC5RUqHWJvBOwrV4rUXYKyNBrzII5Lhc3E';

%D�part et arriv�e de l'itin�raire
depart = 'Martigny, Valais';
destination = 'Lausanne, Valais';

%Recherche itin�raire, coordonn�es GPS
[x1,y1,latz, lonz, distance, time] = getDirections(depart,destination,keyAPI,1);

%Recherche altitude de chaque coordonn�e GPS
z1 = getElevation(x1, y1, keyAPI);

% Calcul de la distance et de la pente entre deux coordonn�es
[d,c_dist,dist_tot, x, y, z] = getDistance(x1, y1, z1);

% Interpolation � interval r�gulier
c=linspace(0,c_dist(length(c_dist)),c_dist(length(c_dist))/10); %interval 
x1_int=interp1(c_dist,x1,c,'pchip');
y1_int=interp1(c_dist,y1,c,'pchip');
z1_int=interp1(c_dist,z1,c,'spline');

% Calcul de la distance et de la pente interpol�e
[d_int,c_dist_int,dist_tot_int, x_int, y_int, z_int, dvdo, alpha_int] = getDistance(x1_int, y1_int, z1_int);

% Caract�ristiques de l'itin�raire (d�nivel�, poit culminant, ..)
[dp, dn, denTot, plpb, pc]=getCharacteristics(z1_int);

%% D�tection d'un tunnel ou d'un pont
disp('D�tection Tunnel');

%Caract�ristiques de d�tection
penteMontante=0.2; 
penteDescendante=-0.2; 
diffAltiPos = 0.2;
diffAltiNeg = -0.2;

[z1Corr_int, zCorr_int, pente] = getBuilding(z1_int, c_dist_int, penteMontante, penteDescendante, diffAltiPos, diffAltiNeg);

%% Limitation vitesse
disp('Limitation de vitesse estim�e');
accCentriMax = 6;%m/s^2
[vlim, at]=getMaxSpeed(x_int,y_int,z_int,d_int,c_dist_int,latz,lonz,distance,time, accCentriMax);
vlim(1)=0.5; %n�cessaire pour la g�n�ration du profil de vitesse

%% Anticipation, acc�l�ration maximum
disp('Anticipation des virages');

% Freinage et acc�l�ration maximum
acc_in = 2;
acc_out = 1;

% longueur maximum
tailleMax = length(c_dist_int);

% Cr�ation des matrices vides
slope_1_inv=zeros(tailleMax);
slope_1 = zeros(tailleMax);
slope_2=zeros(tailleMax);
slope_3=zeros(tailleMax);

% Cr�ation du freinage maximum de chaque point
for k=1:1:tailleMax
    for i=1:1:k
        slope_1_inv(k,i) = sqrt((vlim(k)^2)+2*acc_in*c_dist_int(i));
    end
    slope_1(k,1:k) = flip(slope_1_inv(k,1:k));
end

% Cr�ation de l'acc�l�ration maximum de chaque point
for k=1:1:tailleMax
    for i=k:1:tailleMax
        slope_2(k,i) = sqrt((vlim(k)^2)+2*acc_out*(c_dist_int(i)-c_dist_int(k)));
    end
end

% Transposition matrice pour les graphes
slope_1=slope_1';
slope_2=slope_2';

% Le maximum des courbes
slope_12 = max(slope_1, slope_2);

% G�n�ration du profil complet
vlimX = vlim;
for k=1:1:tailleMax
    for i=1:1:tailleMax
        vlim(i) = min(slope_12(i,k), vlim(i));
    end
end


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

%% OUTPUT
figure('Name','Caract�ristiques de la route','NumberTitle','off');
subplot(2,2,1);
plot(y1_int, x1_int)
title('Plan de la route');
xlabel('Longitude [-]');
ylabel('Latitude [-]');
subplot(2,2,2);
plot(c_dist_int, z1_int, c_dist_int, z1Corr_int)
title('Profil de la route');
xlabel('Distance [m]');
ylabel('Altitude [m]');
subplot(2,2,[3,4])
plot(c_dist_int,vlimX*3.6,c_dist_int, vlim*3.6);
title('Profil de vitesse');
xlabel('Distance [m]');
ylabel('Vitesse [m/s]'); 
figure(5)
plot(vitesseCouple*3.6, seuilCoupleMax/nr/r, vitesseCouple*3.6, seuilCoupleMin/nr/r)