c_dist_int = (0:1:1999);
dist_tot = 2000;

for k=1:1:length(c_dist_int)
    vlim (k) = 13.8;
end

for k=1:1:length(c_dist_int)
    if c_dist_int(k)<=800
        altitude(k) = 0;
    elseif c_dist_int(k)> 800 && c_dist_int(k)<=1000
        altitude(k)=altitude(k-1)+1;
    elseif c_dist_int(k)> 1000 && c_dist_int(k)<=1200
        altitude(k)=altitude(k-1)-1;
    elseif c_dist_int(k) >1200
        altitude(k)=0;
    end
end

for k=1:1:length(c_dist_int)-1
    pente(k)= (altitude(k+1)-altitude(k))/(c_dist_int(k+1)-c_dist_int(k));
    alphaCorr_int(k)=atan(pente(k));
end

%Filtrage des données Z
size_window=21; %Must be odd
window=1/size_window*ones(1,size_window);
z1_filter=conv(altitude,window,"same");

z1_filter(1:(size_window-1)/2)=altitude(1:(size_window-1)/2);
z1_filter(end-(size_window-1)/2:end)=altitude(end-(size_window-1)/2:end);


%% Détection d'un tunnel ou d'un pont
disp('Détection Tunnel');

%Caractéristiques de détection
penteMontante=0.2;
penteDescendante=-0.2;
diffAltiPos = 0;
diffAltiNeg = 0;

[z1Corr_int, zCorr_int, alphaCorr_int, pente2] = getBuilding(z1_filter, c_dist_int, penteMontante, penteDescendante, diffAltiPos, diffAltiNeg);


figure(1)
plot(c_dist_int, altitude, c_dist_int, z1Corr_int, c_dist_int, z1_filter)

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
