
position = [0, 1, 2, 3, 4,5,6,7,8,9]
vitesse = [5, 5, 3, 5, 5,5,1,5,5,5]
length = 10;
acc_in = 5;
acc_out = 5;
max_speed = 22;

slope_1_inv=zeros(length);
slope_1 = zeros(length);
slope_2=zeros(length);
slope_3=zeros(length);

for k=1:1:length
    for i=1:1:k

        slope_1_inv(k,i) = sqrt((vitesse(k)^2)+2*acc_in*position(i));
        
    end
    slope_1(k,1:k) = flip(slope_1_inv(k,1:k))
end


for k=1:1:length
    for i=k:1:length
        slope_2(k,i) = sqrt((vitesse(k)^2)+2*acc_out*(position(i)-position(k)));
    end
end

slope_1=slope_1';
slope_2=slope_2';

slope_12 = max(slope_1, slope_2);

figure(2)
plot(position, vitesse, position, slope_12)

vitesseLim = vitesse
 for k=1:1:length
     for i=1:1:length
         vitesse(i) = min(slope_12(i,k), vitesse(i));
     end
 end
 
 plot(position, vitesse, position, vitesseLim)
