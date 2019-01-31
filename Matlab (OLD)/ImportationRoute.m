%Initialisation des variables
d=[];
dist_tot=0;
lat1=0;
lat2=0;
lon1=0;
lon2=0;
alt=0;
id=1;
c_dist=0;
x=0;
y=0;
c_alpha=0;
diff=0;
diffAlti=0;


%% Itinéraire, altitude et limitations de vitesse

%Clé API donnée par Google
keyAPI = 'AIzaSyC5RUqHWJvBOwrV4rUXYKyNBrzII5Lhc3E';

%Recherche itinéraire
%[x1,y1] = getItinerary(depart,destination,keyAPI);
%[x1,y1] = getItinerary('Martigny','Sion, Valais',keyAPI);
%[x1,y1] = getItinerary('46.087061, 7.206681','46.092917, 7.218937',keyAPI);%Le Châble - Verbier
%[x1,y1] = getItinerary('46.241889, 7.360878','46.245990, 7.370934',keyAPI);%Sion - Champlan
[x1,y1] = getItinerary('46.088227, 7.055239','46.098406, 7.055982',keyAPI)%Martigny-Croix - Sommet des vignes
%[x1,y1] = getItinerary('46.098406, 7.055982','46.088158, 7.055094',keyAPI)%Sommet des vignes - Martigny-Croix
%[x1,y1] = getItinerary('46.088607, 7.060938','46.092479, 7.079791',keyAPI);%Martigny-Bourg - Chemin-Dessous
%[x1,y1] = getItinerary('46.224901, 7.275373', '46.224475, 7.306879',keyAPI);%Vetroz - Conthey
%[x1,y1] = getItinerary('46.224475, 7.306879', '46.224901, 7.275373',keyAPI);%Conthey - Vetroz
%[x1,y1] = getItinerary('46.235061, 7.341785', '46.241477, 7.344949',keyAPI);% Mont d'Orge - Ormône
%[x1,y1] = getItinerary('46.241477, 7.344949', '46.235061, 7.341785',keyAPI);% Ormône - Mont d'Orge
%[x1,y1] = getItinerary('46.221898, 7.348840', '46.226060, 7.351906',keyAPI);% Sion - Sion
%[x1,y1] = getItinerary('46.226060, 7.351906', '46.221898, 7.348840',keyAPI);% Sion - Sion
%Recherche altitude de chaque coordonnée GPS
z1 = getElevations(x1, y1, keyAPI);

% trace = '38.75807927603043,-9.03741754643809|38.6896537,-9.1770515|41.1399289,-8.6094075';
% %Recherche limitation vitesse
% vlim_ref = getSpeedLimits(trace ,keyAPI);

%% Calcul de la distance et de la pentre entre deux coordonnées

for k = 1:1:length(x1)-1

    %Conversion coordonnées GPS de degré à radian
    lat1 = x1(k)*pi/180;
    lat2 = x1(k+1)*pi/180;
    lon1 = y1(k)*pi/180;
    lon2 = y1(k+1)*pi/180;
    %
    %Distance entre deux coordonnées GPS
    d(k) = 6371008*acos(cos(lat1)*cos(lat2)*cos(lon2-lon1)+sin(lat1)*sin(lat2)); %Distance entre 2 points GPS
    
    %Distance entre deux latitudes ou longitudes
%     x(1)=0;
%     y(1)=0;
    x(k) = 6371008*acos(cos(lat1)*cos(lat2)+sin(lat1)*sin(lat2));%distance entre 2 latitudes
    y(k) = 6371008*acos(cos(lon2-lon1));%distance entre 2 longitudes
    
    %Calcul de la distance totale
    c_dist(1)=0;
    c_dist(k+1) = dist_tot + d(k);%Addition de la distance entre chaque point GPS
    dist_tot = dist_tot + d(k);%Distance parcourue totale
end

%Calcul de la pente entre deux coordonnées GPS
for k=1:1:length(z1)-1
    c_alpha(k) = atan((z1(k+1)-z1(k))/d(k));
end

if(length(c_alpha)<length(c_dist))
    c_alpha(length(c_alpha)+1) = c_alpha(length(c_alpha));
end


%Recherche d'un tunnel
seuil =0.15;
niv=25;
niv2=-25;
seuil2 = -0.15;
a=0;
b=0;
c=1;
step=0;
step2=0;
tunnel_start = [];
tunnel_stop = [];

for k=1:1:length(z1)-1
    diffAlti(k) = z1(k+1)-z1(k);
    diff(k) = (z1(k+1)-z1(k))/d(k);
    if diff(k)>=seuil && a==0 && diffAlti(k)>=niv
        step = max(k-2,0);
        disp(step)
        a=1;
    end
    if diff(k)<=seuil2 && a==1 && diffAlti(k)<=niv2
        step2 = min(k+7, length(z1)-1);
        disp(step2)
        b=1;
    end
    if a==1 && b==1
        tunnel_start(c) = step;
        tunnel_end(c) = step2;
        step=0;
        step2=0;
        a=0;
        b=0;
        c=c+1;
    end
end
distance =0;
z3=z1;
distanceAvant=0;
%Lisser les tunnels
if length(tunnel_start)>0
    isTunnel =true;
    lissTunnel=true;
elseif length(tunnel_start)==0
    isTunnel =false;
    lissTunnel=false;
end

if length(tunnel_start)>0 && lissTunnel==true
    z1 = z3
    for k=1:1:length(tunnel_start)
        alt = z3(tunnel_end(k))-z3(tunnel_start(k));
        for i=tunnel_start(k):1:tunnel_end(k)
            distance = distance + d(i);
        end
        
        for j=1:1:tunnel_start(k)
            distanceAvant = distanceAvant + d(j);
        end
        
        pente = alt / distance;
        
        for i=tunnel_start(k):1:tunnel_end(k)
            z3(i)= pente* (c_dist(i)-c_dist(tunnel_start(k)))+z3(tunnel_start(k));
        end
    end
    %Correction de la pente
    for k=1:1:length(z3)-1
        c_alpha(k) = atan((z3(k+1)-z3(k))/d(k));
    end
    
    if(length(c_alpha)<length(c_dist))
        c_alpha(length(c_alpha)+1) = c_alpha(length(c_alpha));
    end
end

%Calcul de dénivelé et point
dn=0;
dn2=0;
dp=0;
dp2=0;
den=0;
den2=0;
for k=1:1:length(z1)-1
    den = z1(k+1) - z1(k);
    den2 = z3(k+1) - z3(k);
    
    %Tracé avec tunnel
    if den >= 0
        dp= dp + den;
    elseif den < 0
        dn = dn + den*(-1);
    end
    
    %Tracé sans tunnel
    if den2 >= 0
        dp2= dp2 + den2;
    elseif den2 < 0
        dn2 = dn2 + den2*(-1);
    end
end

denTot = dp - dn;
denTot2 = dp2 - dn2;

pc =0;
plpb = 10000;
pc2 =0;
plpb2 = 10000;

%Calcul du point le plus haut et le plus bas
for k=1:1:length(z1)
    
    %Tracé avec tunnel
    if (z1(k) >pc)
        pc = z1(k);
    end
    if z1(k) < plpb
        plpb = z1(k);
    end
    
    %Tracé sans tunnel
    if (z3(k) >pc2)
        pc2 = z3(k);
    end
    if z3(k) < plpb2
        plpb2 = z3(k);
    end
    
end

%Calcul distance entre les points min et max
dl=0;
dl2=0;
dc=10000;
dc2=10000;
for k=1:1:length(d)
    %Tracé avec tunnel
    if (d(k) >dl)
        dl = d(k);
    end
    if d(k) < dc
        dc = d(k);
    end
    
    %Tracé sans tunnel
    if (d(k) >dl2)
        dl2 = d(k);
    end
    if d(k) < dc2
        dc2 = d(k);
    end
end


%% OUTPUT
figure('Name','Caractéristiques de la route','NumberTitle','off');
subplot(2,1,1);
plot(y1,x1,'b');
title('Plan de la route');
xlabel('Longitude [-]');
ylabel('Latitude [-]');
subplot(2,1,2)
plot(c_dist,z1,c_dist,z3);
 title('Profil de la route');
 xlabel('Distance [m]');
 ylabel('Altitude [m]');



