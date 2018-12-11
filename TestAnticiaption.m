
position = [0, 1, 2, 3, 4,5,6,7,8,9]
vitesse = [5, 5, 1, 5, 5,2,3,1,5,5]
length = 10
acc_in = 1
acc_out = 1
max_speed = 22

% slope_1 = zeros(length,1);
% slope_1_inv = zeros(length,1);
slope_2=zeros(length);
slope_3=zeros(length);
for k=1:1:length
    for i=k:1:length
        slope_2(k,i) = sqrt((vitesse(k)^2)+2*acc_out*(position(i)-position(k)));
        slope_3(k,i) = sqrt((vitesse(k)^2)+2*acc_in*(position(i)-position(k)));
    end
end

slope_2=slope_2'
slope_3=rot90(rot90(slope_3'))
plot(position, vitesse, position, slope_2, position, slope_3)

slope_23 = max(slope_2, slope_3);

vitesse2 = vitesse;
for k=1:1:length
    for i=1:1:length
        vitesse(i) = min(slope_23(i,k), vitesse(i));
    end
end
plot(position, vitesse, position, vitesse2)

