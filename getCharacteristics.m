function [denp, denn, dentot, plpb, pc] = getCharacteristics(alt)

%% D�nivel� positif, n�gatif et total
denp=0;
denn=0;
for k=1:1:length(alt)-1
    den = alt(k+1) - alt(k);
    if den >= 0
        denp= denp + den; %Calcul d�nivel� positif
    elseif den < 0
        denn = denn + den*(-1); %Calcul d�nivel� n�gatif
    end
end
dentot = denp - denn; %Calcul d�nivel� total

%% Point culminant et point le plus bas
plpb = min(alt);
pc = max(alt);
end
