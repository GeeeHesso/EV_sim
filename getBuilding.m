function [z2] = getBuilding(z1, c_dist, d, seuilHaut,seuilBas,nivHaut,nivBas)

a=0;
b=0;
c=1;
stepIn=0;
stepOut=0;
tunnel_start = [];
tunnel_stop = [];
diff=0;
diffAlti=0;

%Calcul de la pente, de la différence d'altitude et de l'angle de la pente
for k=1:1:length(z1)-1
    diffAlti(k) = z1(k+1)-z1(k);

    diff(k) = (z1(k+1)-z1(k))/d(k);
end

for k=1:1:length(diff)
    %Détection de l'entrée d'un pont ou d'un tunnel
    if diff(k)>=seuilHaut && a==0 && diffAlti(k)>=nivHaut %Détection de l'entrée d'un tunnel
        stepIn = k;
        a=1;
        disp('Entrée tunnel détectée')
    elseif diff(k)<=seuilBas && a==0 && diffAlti(k)<=nivBas %Détection de l'entrée d'un pont
        stepIn = k;
        a=2;
        disp('Entrée pont détectée')
    end
    %Détection de la sortie d'un pont ou d'un tunnel
    if diff(k)<=seuilBas && a==1 && diffAlti(k)<=nivBas %Détection de la sortie d'un tunnel
        stepOut = k;
        b=1;
        disp('Sortie tunnel détectée')
    elseif diff(k)>=seuilHaut && a==2 && diffAlti(k)>=nivHaut %Détection de la sortie d'un pont
        stepOut = k;
        b=1;
        disp('Sortie pont détectée')
    end
    
    %Sauvegarde de l'entrée et de la sortie du tunnel
    if a==1 && b==1 || a==2 && b==1
        tunnel_start(c) = stepIn-5;
        tunnel_stop(c) = stepOut+1;
        stepIn=0;
        stepOut=0;
        a=0;
        b=0;
        c=c+1;
    end
end

%% Correction d'un tunnel ou d'un pont
z2=z1;
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
        hauteur = z2(tunnel_stop(k))-z2(tunnel_start(k));
        longeur = c_dist(tunnel_stop(k))-c_dist(tunnel_start(k));
        pente = hauteur / longeur;
        
        for i=tunnel_start(k):1:tunnel_stop(k)-1
            z2(i)= pente* (c_dist(i)-c_dist(tunnel_start(k)))+z2(tunnel_start(k));
        end
    end
end
end
