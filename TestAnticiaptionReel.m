

tailleMax = length(c_dist_int);
acc_in = 2;
acc_out = 1;
max_speed = 22;

slope_1_inv=zeros(tailleMax);
slope_1 = zeros(tailleMax);
slope_2=zeros(tailleMax);
slope_3=zeros(tailleMax);

for k=1:1:tailleMax
    for i=1:1:k
        slope_1_inv(k,i) = sqrt((vlim(k)^2)+2*acc_in*c_dist_int(i));
    end
    slope_1(k,1:k) = flip(slope_1_inv(k,1:k));
end

for k=1:1:tailleMax
    for i=k:1:tailleMax
        slope_2(k,i) = sqrt((vlim(k)^2)+2*acc_out*(c_dist_int(i)-c_dist_int(k)));
    end
end

slope_1=slope_1';
slope_2=slope_2';

slope_12 = max(slope_1, slope_2);

vlimX = vlim
for k=1:1:tailleMax
    for i=1:1:tailleMax
        vlim(i) = min(slope_12(i,k), vlim(i));
    end
end

figure(3);
plot(c_dist_int, vlim, c_dist_int, vlimX)
