function [dstep, d, dtot, dlat, dlon, dalt, dvdo, alpha, pente] = getDistance(lat, lon, alt)

%% Calcul de la distance entre deux coordonn�es GPS
dtot=0;
d(1)=0;
for k = 1:1:length(lat)-1
    %Conversion coordonn�es GPS de degr� � radian
    lat1 = lat(k)*pi/180;
    lat2 = lat(k+1)*pi/180;
    lon1 = lon(k)*pi/180;
    lon2 = lon(k+1)*pi/180;

    %Distance entre deux coordonn�es GPS
    dstep(k) = 6371008*acos(cos(lat1)*cos(lat2)*cos(lon2-lon1)+sin(lat1)*sin(lat2)); %Distance entre 2 points GPS
    
    %Distance entre deux latitudes ou longitudes
%     dlat(k) = 6371008*acos(cos(lat1)*cos(lat2)*cos(lon1-lon1)+sin(lat1)*sin(lat2));%distance entre 2 latitudes
    dlat(k) = real(6371008*acos(cos(lat1)*cos(lat2)+sin(lat1)*sin(lat2)));%distance entre 2 latitudes
    dlon(k)= real(6371008*acos(cos(lat1)*cos(lat1)*cos(lon2-lon1)+sin(lat1)*sin(lat1)));%distance entre 2 longitudes
    dalt(k)= alt(k+1)-alt(k);%Distance entre 2 altitudes
    
    dl(k) = sqrt(dstep(k)^2+dalt(k)^2);
    
    %Calcul de la distance totale
    d(k+1) = dtot + dl(k);%Addition de la distance entre chaque point GPS
    dtot = dtot + dl(k);%Distance parcourue totale
end

for k=1:1:length(dstep)
    alpha(k) = atan(dalt(k)/dstep(k));
    pente(k) = dalt(k)/dstep(k);
end

%% Distance � vol d'oiseau
%Conversion coordonn�es GPS de degr� � radian
lat1 = lat(1)*pi/180;
lat2 = lat(length(lat))*pi/180;
lon1 = lon(1)*pi/180;
lon2 = lon(length(lon))*pi/180;
%Calcul distance vol d'oiseau
dvdo = 6371008*acos(cos(lat1)*cos(lat2)*cos(lon2-lon1)+sin(lat1)*sin(lat2));
end
