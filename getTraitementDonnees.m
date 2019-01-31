function [x1_filter, y1_filter, z1_filter, x1_int, y1_int, z1_int] = getTraitementDonnees(distInterp, sizeXYFilter, sizeZFilter, x1,y1,z1,c_dist)

% Interpolation à interval régulier
c=linspace(0,c_dist(length(c_dist)),c_dist(length(c_dist))/distInterp); %interval

x1_int=interp1(c_dist,x1,c);
y1_int=interp1(c_dist,y1,c);
z1_int=interp1(c_dist,z1,c);

% Rajout de point fictif pour le filtrage
a=1;
w=500;
x1_save = x1_int;
y1_save = y1_int;
z1_save = z1_int;
xf = x1_int(1)
yf = y1_int(1)
zf = z1_int(1);
xl= x1_int(length(x1_int));
yl= y1_int(length(x1_int));
zl = z1_int(length(z1_int));
for k=1:1:2*w+length(z1_int)
    if k<w
        x1_intx(k)=xf;
        y1_intx(k)=yf;
        z1_intx(k)=zf;     
    elseif k >= w && k< w+length(z1_int)
        x1_intx(k)=x1_int(a);
        y1_intx(k)=y1_int(a);
        z1_intx(k)=z1_int(a);
        a=a+1;
    elseif k>=w+length(z1_int)
        x1_intx(k)=xl;
        y1_intx(k)=yl;
        z1_intx(k)=zl;
    end
end
x1_int=x1_intx;
y1_int=y1_intx;
z1_int=z1_intx;

%Filtrage des données X,Y
size_window=sizeXYFilter; %Must be odd
window=1/size_window*ones(1,size_window);
x1_filter=conv(x1_int,window,"same");
y1_filter=conv(y1_int,window,"same");

%Correction des premiers/derniers points
x1_filter(1:(size_window-1)/2)=x1_int(1:(size_window-1)/2);
x1_filter(end-(size_window-1)/2:end)=x1_int(end-(size_window-1)/2:end);

y1_filter(1:(size_window-1)/2)=y1_int(1:(size_window-1)/2);
y1_filter(end-(size_window-1)/2:end)=y1_int(end-(size_window-1)/2:end);

%Filtrage des données Z
size_window=sizeZFilter; %Must be odd
window=1/size_window*ones(1,size_window);
z1_filter=conv(z1_int,window,"same");

z1_filter(1:(size_window-1)/2)=z1_int(1:(size_window-1)/2);
z1_filter(end-(size_window-1)/2:end)=z1_int(end-(size_window-1)/2:end);

%On renlève les points fictifs
a=1;
w=500;
for k=1:1:length(z1_filter)
    if k>=w && k<length(z1_filter)-w
        x1_filterx(a)=x1_filter(k);
        y1_filterx(a)=y1_filter(k);
        z1_filterx(a)=z1_filter(k);
        a=a+1;
    end
end
x1_filter=x1_filterx
y1_filter=y1_filterx
z1_filter=z1_filterx
x1_int=x1_save;
y1_int=y1_save;
z1_int=z1_save;


end