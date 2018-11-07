
for k=1:1:length(x1)-1
    
    startLat = num2str(x1(k),6);
    startLon = num2str(y1(k),6);
    destLat = num2str(x1(k+1),6);
    destLon = num2str(y1(k+1),6);
    
    dep = sprintf('%s',startLat,',',startLon)
    dest = sprintf('%s',destLat,',',destLon)
    
    [x9,y9,latz9, lonz9, distance9, time9] = getDirections(dep,dest,keyAPI,0);
    
    vitesseLimit(k) = distance9/time9
end