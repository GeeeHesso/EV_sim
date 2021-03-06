
alim=1;
vlim=[];
vlim_c=[];
w_time=[];
w_vit=[];
uuc=0;
uu=0;
check=0;
dxdl=0;
dydl=0;
dzdl=0;
d2xdl=0;
d2ydl=0;
d2zdl=0;
amod2=0;
amod3=0;
at=0;
av2=0;
av3=0;
az=0;
vlim=0;
vlim_ref=0;
vmod2=0;
vmod3=0;
phi=0;
w_alpha=0;
w_dist=0;
w_vit=0;
tiss=0;
vlim_c50=0;
vlim_c100=0;
vlim_c150=0;
vlim_c200=0;

%% Simulation de limitation de vitesse (� remplacer par l'api)

for k=1:1:length(z3)
    vlim(k)=80/3.6;
    vlim_ref(k)=vlim(k);
end


%% Limitation de vitesse due � l'acc�l�ration centrip�te
while(check==0)
    
    %Vecteur Vitesse
    %     for k=1:1:length(x)-1
    %         dxdl(k) = (x(k+1)-x(k))/(c_dist(k+1)-c_dist(k));
    %         dydl(k) = (y(k+1)-y(k))/(c_dist(k+1)-c_dist(k));
    %         dzdl(k) = (z1(k+1)-z1(k))/(c_dist(k+1)-c_dist(k));
    %         vmod2 (k) = sqrt(dxdl(k)^2+dydl(k)^2)*vlim(k);
    %         vmod3 (k) = sqrt(dxdl(k)^2 +dydl(k)^2 +dzdl(k)^2 )*vlim(k);
    %     end
    
    for k=1:1:length(z3)-1
        dxdl(k) = x(k)/d(k);
        dydl(k) = y(k)/d(k);
        dzdl(k) = (z3(k+1)-z3(k))/d(k);
        vmod2 (k) = sqrt(dxdl(k)^2+dydl(k)^2)*vlim(k);
        vmod3 (k) = sqrt(dxdl(k)^2 +dydl(k)^2 +dzdl(k)^2)*vlim(k);
    end
    
    %Vecteur Acc�l�ration
    %     for k=1:1:length(x)-2
    %         d2xdl(k) = (x(k+2)+x(k)-2*x(k+1))/((c_dist(k+1)-c_dist(k))*(c_dist(k+2)-c_dist(k+1)));
    %         d2ydl(k) = (y(k+2)+y(k)-2*y(k+1))/((c_dist(k+1)-c_dist(k))*(c_dist(k+2)-c_dist(k+1)));
    %         d2zdl(k) = (z1(k+2)+z1(k)-2*z1(k+1))/((c_dist(k+1)-c_dist(k))*(c_dist(k+2)-c_dist(k+1)));
    %         amod2(k) = sqrt(d2xdl(k)^2+d2ydl(k)^2)*vlim(k)^2;
    %         amod3(k) = sqrt(d2xdl(k)^2+d2ydl(k)^2+d2zdl(k)^2)*vlim(k)^2;
    %         az(k) = sqrt(amod3(k)^2-amod2(k)^2);
    %     end
    
    for k=1:1:length(z3)-2
        d2xdl(k) = (2*x(k)+x(k+1))/((c_dist(k+1)-c_dist(k))*(c_dist(k+2)-c_dist(k+1)));
        d2ydl(k) = (2*y(k)+y(k+1))/((c_dist(k+1)-c_dist(k))*(c_dist(k+2)-c_dist(k+1)));
        %d2zdl(k) = (z1(k+2)+z1(k)-2*z1(k+1))/((c_dist(k+1)-c_dist(k))*(c_dist(k+2)-c_dist(k+1)));
        d2zdl(k) = (z3(k+2)+z3(k)-2*z3(k+1))/((c_dist(k+1)-c_dist(k))*(c_dist(k+2)-c_dist(k+1)));
        amod2(k) = sqrt(d2xdl(k)^2+d2ydl(k)^2)*vlim(k)^2;
        amod3(k) = sqrt(d2xdl(k)^2+d2ydl(k)^2+d2zdl(k)^2)*vlim(k)^2;
        az(k) = sqrt(amod3(k)^2-amod2(k)^2);
    end
    
    azmax =0;
    for k=1:1:length(az)
        if az(k) >azmax
            azmax=az(k);
            azpos=k;
        end
    end
    %Angle entre le vecteur vitesse et le vecteur acc�l�ration
    for k=1:1:length(dxdl)-2
        av2(k) = (d2xdl(k)*dxdl(k)+d2ydl(k)*dydl(k))*vlim(k)^3;
        av3(k) = (d2xdl(k)*dxdl(k)+d2ydl(k)*dydl(k)+d2zdl(k)*dzdl(k))*vlim(k)^3;
        phi(k) = acos(av3(k)/(vmod3(k)*amod3(k)));
        at(k) = sin(phi(k))*amod3(k);
    end
    
    %Diminution de la vitesse max en fonction de l'acc�l�ration centrip�te
    for k=1:1:length(at)
        if at(k) > 8.59 && at(k) < 15
            vlim(k) = vlim(k)-(0.1/3.6);
        elseif at(k) > 15
            vlim(k) = vlim(k)-(0.2/3.6);
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
% for k=1:1:length(vlim)
%     if vlim_ref(k) == (120/3.6)
%         vlim(k)=120/3.6;
%     end
% end
%Limitation max de vitesse en fonction de la longueur du trajet
uuc = timeseries(vlim',c_dist');


%% D�finition de la vitesse en fonction de la route

%Echantillonage de Vlim par 10cm
n=2;
w_dist(1)=0;
%w_vit(1)=0;
for k=1:1:length(vlim)-1
    pente = (vlim(k+1)-vlim(k))/(c_dist(k+1)-c_dist(k));
    pente2 = (c_alpha(k+1)-c_alpha(k))/(c_dist(k+1)-c_dist(k));
    while w_dist(n-1) <= c_dist(k+1)
        w_dist(n)=w_dist(n-1)+0.1;
        w_vit(n)= pente*(w_dist(n)-c_dist(k))+vlim(k);
        w_alpha(n) = c_alpha(k);%pente2*(w_dist(n)-c_dist(k))+c_alpha(k);
        n=n+1;
    end
end
w_vit(1)=w_vit(2);


i=1;
%Lissage sur 100m de la valeur la plus faible
for k=1:1:length(w_vit)-500
    while i<=500
        b(i)=w_vit(k+i-1);
        i=i+1;
    end
    i=1;
    vlim_c50(k)=min(b);
end

%D�finition des derniers points
for k=length(vlim_c50):1:length(w_vit)
    vlim_c50(k)=w_vit(k);
end

i=1;
%Lissage sur 100m de la valeur la plus faible
for k=1:1:length(w_vit)-1000
    while i<=1000
        b(i)=w_vit(k+i-1);
        i=i+1;
    end
    i=1;
    vlim_c100(k)=min(b);
end

%D�finition des derniers points
for k=length(vlim_c100):1:length(w_vit)
    vlim_c100(k)=w_vit(k);
end

i=1;
%Lissage sur 100m de la valeur la plus faible
for k=1:1:length(w_vit)-1500
    while i<=1500
        b(i)=w_vit(k+i-1);
        i=i+1;
    end
    i=1;
    vlim_c150(k)=min(b);
end

%D�finition des derniers points
for k=length(vlim_c150):1:length(w_vit)
    vlim_c150(k)=w_vit(k);
end

i=1;
%Lissage sur 100m de la valeur la plus faible
for k=1:1:length(w_vit)-2000
    while i<=2000
        b(i)=w_vit(k+i-1);
        i=i+1;
    end
    i=1;
    vlim_c200(k)=min(b);
end

%D�finition des derniers points
for k=length(vlim_c200):1:length(w_vit)
    vlim_c200(k)=w_vit(k);
end

i=1;
%Lissage de la valeur la plus faible
for k=1:1:length(w_vit)-1000
    while i<=1000
        b(i)=w_vit(k+i-1);
        i=i+1;
    end
    i=1;
    vlim_c(k)=min(b);
end

%D�finition des derniers points
for k=length(vlim_c):1:length(w_vit)
    vlim_c(k)=w_vit(k);
end

%Limitation max liss�e en fonction de la distance
% vlim=vlim';
% vlim_c=vlim_c';
% w_dist=w_dist'
% c_dist=c_dist';
uu = timeseries(vlim_c',w_dist');

for k=1:1:length(c_dist)
    tiss(k) = 80/3.6;
end
uud = timeseries(tiss',c_dist')
%% Output
figure(3);
subplot(2,1,1);
plot(c_dist,vlim_ref,c_dist,vlim)% uuc,udd);%w_dist,w_alpha)%uucvlim',c_dist
title('Limitation de vitesse');
xlabel('Distance [m]');
ylabel('Limitation de vitesse [m/s]');
subplot(2,1,2);
plot(uu),%c_dist, c_alpha)%uu
title('Limitation de vitesse optimis�e');
xlabel('Distance [m]');
ylabel('Limitation de vitesse [m/s]');
figure(4)
plot(w_dist,vlim_c50,w_dist,vlim_c100,w_dist,vlim_c150,w_dist,vlim_c200)
