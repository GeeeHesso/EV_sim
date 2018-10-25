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

for k=1:1:length(z1)
    vlim(k)=120/3.6;
    vlim_ref(k)=vlim(k);
end

%% Limitation de vitesse due à l'accélération centripète
while(check==0)
    
    % Vecteur Vitesse
    for k=1:1:length(x)
        dxdl(k) = x(k)/d(k); %x1(k+1)-x1(k)/c_dist(k+1)-c_dist(k)
        dydl(k) = y(k)/d(k);
        dzdl(k) = z(k)/d(k);
        vmod (k) = sqrt(dxdl(k)^2 +dydl(k)^2 +dzdl(k)^2)*vlim(k);
    end
    
    % Vecteur Accélération
    for k=1:1:length(z)-1
        d2xdl(k) = (x(k+1)-x(k))/(d(k)*d(k+1));
        d2ydl(k) = (y(k+1)-y(k))/(d(k)*d(k+1));
        d2zdl(k) = (z(k+1)-z(k))/(d(k)*d(k+1));
        amod(k) = sqrt(d2xdl(k)^2+d2ydl(k)^2+d2zdl(k)^2)*vlim(k)^2;
    end
    
    %Angle entre le vecteur vitesse et le vecteur accélération
    for k=1:1:length(d2xdl)
        av(k) = (d2xdl(k)*dxdl(k)+d2ydl(k)*dydl(k)+d2zdl(k)*dzdl(k))*vlim(k)^3;
        phi(k) = acos(av(k)/(vmod(k)*amod(k)));
        at(k) = sin(phi(k))*amod(k);
    end
    
    %Diminution de la vitesse max en fonction de l'accélération centripète
    for k=1:1:length(at)
        if at(k) > 6 && at(k) < 15
            vlim(k) = vlim(k)-(0.1/3.6);
        elseif at(k) > 15
            vlim(k) = vlim(k)-(0.2/3.6);
        end
    end
    
    %Vérification qu'il n'y a pas d'accélération trop forte
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

% %% Output
 figure(3);
 subplot(2,1,1);
 plot(c_dist,vlim_ref,c_dist,vlim)% uuc,udd);%w_dist,w_alpha)%uucvlim',c_dist
% title('Limitation de vitesse');
% xlabel('Distance [m]');
% ylabel('Limitation de vitesse [m/s]');
% subplot(2,1,2);
% plot(uu),%c_dist, c_alpha)%uu
% title('Limitation de vitesse optimisée');
% xlabel('Distance [m]');
% ylabel('Limitation de vitesse [m/s]');
% figure(4)
% plot(w_dist,vlim_c50,w_dist,vlim_c100,w_dist,vlim_c150,w_dist,vlim_c200)
