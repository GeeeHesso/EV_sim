enerC = 0;
enerR = 0;
for k=1:1:length(energie.data)-1
    diff = energie.data(k+1)- energie.data(k);
    if diff >= 0
        enerC = enerC + diff;
    elseif diff < 0
        enerR = enerR + diff*(-1);
    end
end