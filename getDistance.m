function [dstep, d, dtot, dlat, dlon, dvdo] = getDistance(lat, lon)

%% Calcul de la distance entre deux coordonnées GPS
dtot=0;
for k = 1:1:length(lat)-1
    %Conversion coordonnées GPS de degré à radian
    lat1 = lat(k)*pi/180;
    lat2 = lat(k+1)*pi/180;
    lon1 = lon(k)*pi/180;
    lon2 = lon(k+1)*pi/180;
    
    %Distance entre deux coordonnées GPS
    dstep(k) = 6371008*acos(cos(lat1)*cos(lat2)*cos(lon2-lon1)+sin(lat1)*sin(lat2)); %Distance entre 2 points GPS
    
    %Distance entre deux latitudes ou longitudes
    dlat(k) = 6371008*acos(cos(lat1)*cos(lat2)*cos(lon1-lon1)+sin(lat1)*sin(lat2));%distance entre 2 latitudes
    dlon(k)=6371008*acos(cos(lat1)*cos(lat1)*cos(lon2-lon1)*cos(0)+sin(lat1)*sin(lat1));%distance entre 2 longitudes
    
    %Calcul de la distance totale
    d(1)=0;
    d(k+1) = dtot + dstep(k);%Addition de la distance entre chaque point GPS
    dtot = dtot + dstep(k);%Distance parcourue totale
end
%% Distance à vol d'oiseau
%Conversion coordonnées GPS de degré à radian
lat1 = lat(1)*pi/180;
lat2 = lat(length(lat))*pi/180;
lon1 = lon(1)*pi/180;
lon2 = lon(length(lon))*pi/180;
%Calcul distance vol d'oiseau
dvdo = 6371008*acos(cos(lat1)*cos(lat2)*cos(lon2-lon1)+sin(lat1)*sin(lat2));
end
