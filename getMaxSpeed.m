function [vlim, vlim_ref,at] = getMaxSpeed(x,y,z,d,speedLimit, accCentriMax)

%Initialisation des variables
vlim=[];
check=0;
dxdl=0;
dydl=0;
dzdl=0;
d2xdl=0;
d2ydl=0;
d2zdl=0;
amod=0;
at=0;
av=0;
vlim=0;
vlim_ref=0;
vmod=0;
phi=0;

%% Simulation de limitation de vitesse (� remplacer par l'api)

for k=1:1:length(z)+1
    vlim(k)=speedLimit;
    vlim_ref(k)=vlim(k);
end

%% Limitation de vitesse due � l'acc�l�ration centrip�te

while(check==0)
    % Vecteur Vitesse
    for k=1:1:length(x)
        dxdl(k) = x(k)/d(k);
        dydl(k) = y(k)/d(k);
        dzdl(k) = z(k)/d(k);
        vmod (k) = sqrt(dxdl(k)^2 +dydl(k)^2 +dzdl(k)^2)*vlim(k);
    end
    
    % Vecteur Acc�l�ration
    for k=1:1:length(z)-1
        d2xdl(k) = (x(k+1)-x(k))/(d(k)*d(k+1));
        d2ydl(k) = (y(k+1)-y(k))/(d(k)*d(k+1));
        d2zdl(k) = (z(k+1)-z(k))/(d(k)*d(k+1));
        amod(k) = sqrt(d2xdl(k)^2+d2ydl(k)^2+d2zdl(k)^2)*vlim(k)^2;
    end
    
    %Angle entre le vecteur vitesse et le vecteur acc�l�ration
    for k=1:1:length(d2xdl)
        av(k) = (d2xdl(k)*dxdl(k)+d2ydl(k)*dydl(k)+d2zdl(k)*dzdl(k))*vlim(k)^3;
        phi(k) = acos(av(k)/(vmod(k)*amod(k)));
        at(k) = sin(phi(k))*amod(k);
    end
    %Diminution de la vitesse max en fonction de l'acc�l�ration centrip�te
    for k=1:1:length(at)
        if at(k) > accCentriMax && at(k) < 15
            vlim(k) = vlim(k)-(1/3.6);
        elseif at(k) > 15
            vlim(k) = vlim(k)-(2/3.6);
        end
    end
    
    %V�rification qu'il n'y a pas d'acc�l�ration trop forte
    u=0;
    for k=1:1:length(at)
        if at(k)>10
            u=u+1;
        end
    end
    if u>0
        check=0;
    elseif u==0
        check=1;
    end
end

end