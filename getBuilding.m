function [z1Corr_int, zCorr_int, pente] = getBuilding(z1_int, c_dist_int, penteMontante, penteDescendante,diffAltiPos, diffAltiNeg)

a=0;
b=0;
c=1;
stepIn=0;
stepOut=0;
tunnel_start = [];
tunnel_stop = [];

%Calcul de la pente, de la différence d'altitude et de l'angle de la pente
for k=1:1:length(z1_int)-1
    pente(k) = (z1_int(k+1)-z1_int(k))/(c_dist_int(k+1)-c_dist_int(k));
    diffAlti(k)= z1_int(k+1)-z1_int(k);
end

for k=1:1:length(pente)-2
    deltaPente(k) = pente(k+2)-pente(k);
end
disp(max(deltaPente))
disp(min(deltaPente))
disp(max(diffAlti))
disp(min(diffAlti))

for k=1:1:length(deltaPente)
%     disp(deltaPente(k))
%     disp(diffAlti(k))
    %Détection de l'entrée d'un pont ou d'un tunnel
    if  a==0 && deltaPente(k)>=penteMontante && diffAlti(k) >=diffAltiPos %Détection de l'entrée d'un tunnel diff(k)>=seuilHaut &&
        stepIn = max(k-2,0);
        a=1;
        disp('Entrée tunnel détectée')
    elseif   a==0 && deltaPente(k)<=penteDescendante && diffAlti(k) <= diffAltiNeg %Détection de l'entrée d'un pont diff(k)<=seuilBas &&
        stepIn = k;
        a=2;
        disp('Entrée pont détectée')
    end
    %Détection de la sortie d'un pont ou d'un tunnel
    if  a==1 && deltaPente(k)<=penteDescendante && diffAlti(k) <= diffAltiNeg %Détection de la sortie d'un tunnel diff(k)<=seuilBas &&
        stepOut = min(k+7,length(deltaPente)-1);
        b=1;
        disp('Sortie tunnel détectée')
    elseif  a==2 && deltaPente(k)>=penteMontante && diffAlti(k) >=diffAltiPos %Détection de la sortie d'un pont diff(k)>=seuilHaut &&
        stepOut = k;
        b=1;
        disp('Sortie pont détectée')
    end
    
    %Sauvegarde de l'entrée et de la sortie du tunnel
    if a==1 && b==1 || a==2 && b==1
        tunnel_start(c) = stepIn;
        tunnel_stop(c) = stepOut+20;
        stepIn=0;
        stepOut=0;
        a=0;
        b=0;
        c=c+1;
    end
end

%% Correction d'un tunnel ou d'un pont
z1Corr_int=z1_int;
distance =0;
distanceAvant=0;
%Lisser les tunnels
if length(tunnel_start)>0
    isTunnel =true;
else
    isTunnel =false;
end

%Correction des valeurs de la pente
if isTunnel==true
    for k=1:1:length(tunnel_start)
        hauteur = z1Corr_int(tunnel_stop(k))-z1Corr_int(tunnel_start(k));
        longeur = c_dist_int(tunnel_stop(k))-c_dist_int(tunnel_start(k));
        pente = hauteur / longeur;
        
        for i=tunnel_start(k):1:tunnel_stop(k)-1
            z1Corr_int(i)= pente*(c_dist_int(i)-c_dist_int(tunnel_start(k)))+z1Corr_int(tunnel_start(k));
        end
    end
end
% Différence de hauteur corrigée (z)
for k=1:1:length(z1Corr_int)-1
    zCorr_int(k) = z1Corr_int(k+1)-z1Corr_int(k);
end
end
