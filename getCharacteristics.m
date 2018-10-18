function [denp, denn, dentot, plpb, pc] = getCharacteristics(alt)

%% Dénivelé positif, négatif et total
denp=0;
denn=0;
for k=1:1:length(alt)-1
    den = alt(k+1) - alt(k);
    if den >= 0
        denp= denp + den; %Calcul dénivelé positif
    elseif den < 0
        denn = denn + den*(-1); %Calcul dénivelé négatif
    end
end
dentot = denp - denn; %Calcul dénivelé total

%% Point culminant et point le plus bas
plpb = min(alt);
pc = max(alt);
end
