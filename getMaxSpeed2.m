function [vlim, at, atWW, dxdl,d2xdl,dydl,d2ydl,dzdl,d2zdl,phi] = getMaxSpeed(x,y,z,d,c_dist,latz, lonz, distance, time, accCentriMax)

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

%% Simulation de limitation de vitesse (à remplacer par l'api)

c_distance(1)=0;
for k=1:1:length(distance)
    c_distance(k+1) = c_distance(k)+distance(k);
end
a=1;
for k=1:1:length(c_dist)
    speedAverage(a) = distance(a)/time(a);
    
    if speedAverage(a) < (30/3.6)
        vlim(k) = 30/3.6;
    elseif speedAverage(a) >= (30/3.6) && speedAverage(a)<(50/3.6)
        vlim(k) = 50/3.6;
    elseif speedAverage(a) >= (50/3.6) && speedAverage(a)<(80/3.6)
        vlim(k) = 80/3.6;
    elseif speedAverage(a) >= (80/3.6)
        vlim(k) = 120/3.6;
    end
    
    if c_dist(k) >= c_distance(a+1)
        if a<length(distance)
            a=a+1;
        end
    end
    
end

% for k=1:1:length(z)+1
%     vlim(k)=speedLimit;
%     vlim_ref(k)=vlim(k);
% end

%% Limitation de vitesse due à l'accélération centripète
ww=1
while(check==0)
    % Vecteur Vitesse
    for k=1:1:length(x)
        dxdl_x(k) = x(k)/d(k);
        dydl_x(k) = y(k)/d(k);
        dzdl_x(k) = z(k)/d(k);
    end
    
    dxdl = interp1(c_dist,dxdl_x,'spline');
    dydl = interp1(c_dist,dydl_x,'spline');
    dzdl = interp1(c_dist,dzdl_x,'spline');
    
    for k=1:1:length(x)
        vmod (k) = sqrt(dxdl(k)^2 +dydl(k)^2 +dzdl(k)^2)*vlim(k);
    end
    
    
    % Vecteur Accélération
    for k=1:1:length(z)-1
        d2xdl(k) = (x(k+1)-x(k))/(d(k)*d(k+1));
        d2ydl(k) = (y(k+1)-y(k))/(d(k)*d(k+1));
        d2zdl(k) = (z(k+1)-z(k))/(d(k)*d(k+1));
        amod(k) = sqrt(d2xdl(k)^2+d2ydl(k)^2+d2zdl(k)^2)*vlim(k)^2;
    end

    
    for k=1:1:length(z)-1
       
    end
    %Angle entre le vecteur vitesse et le vecteur accélération
    for k=1:1:length(d2xdl)
        av(k) = (d2xdl(k)*dxdl(k)+d2ydl(k)*dydl(k)+d2zdl(k)*dzdl(k))*vlim(k)^3;
        phi(k) = acos(av(k)/(vmod(k)*amod(k)));
        at(k) = sin(phi(k))*amod(k);
    end
    
    if ww ==1
        atWW = at
        ww=0;
    end
    
    %Diminution de la vitesse max en fonction de l'accélération centripète
    for k=1:1:length(at)
        if at(k) > accCentriMax && at(k) < 15
            vlim(k) = vlim(k)-(1/3.6);
        elseif at(k) > 15
            vlim(k) = vlim(k)-(2/3.6);
        end
    end
    
    %Vérification qu'il n'y a pas d'accélération trop forte
    u=0;
    for k=1:1:length(at)
        if at(k)>accCentriMax
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