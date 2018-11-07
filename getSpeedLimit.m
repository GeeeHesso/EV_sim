function [speedLimit, speedAverage] = getSpeedLimit(dist, time)
speedLimit=[];
for k=1:1:length(dist)
    speedAverage(k) = dist(k)/time(k);
    
    if speedAverage(k) < (30/3.6)
        speedLimit(k) = 30;
    elseif speedAverage(k) >= (30/3.6) && speedAverage(k)<(50/3.6)
        speedLimit(k) = 50;
    elseif speedAverage(k) >= (50/3.6) && speedAverage(k)<(80/3.6)
        speedLimit(k) = 80;
    elseif speedAverage(k) >= (80/3.6)
        speedLimit(k) = 120;
    end
    
end
end