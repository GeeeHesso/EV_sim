r =9.73;
nr=0.9
rr = 0.33

coupleMaxMoteur = 660; %Nm
coupleMinMoteur = -660;
coupleMaxRoues = coupleMaxMoteur * nr * r; %Nm
coupleMinRoues = coupleMinMoteur * nr * r; %Nm
puissanceMaxMoteur = 310380; %W
puissanceMaxRoues = puissanceMaxMoteur * nr; %W
puissanceMinMoteur = -310380; %W
puissanceMinRoues = puissanceMinMoteur * nr; %W

vitesseMax = 250/3.6;%m/s
vitesseMinReg = 25/3.6;
vitesseDecroRadS = puissanceMaxRoues / coupleMaxRoues;
vitesseDecroMS_Max = puissanceMaxRoues / coupleMaxRoues * rr;
vitesseDecroMS_Min = puissanceMinRoues / coupleMinRoues * rr;

vitesseCouple = 0:1:vitesseMax

for k=1:1:vitesseMax+1
    
    if vitesseCouple(k) <= vitesseDecroMS_Max
        seuilCoupleMax(k) = coupleMaxRoues;
    elseif vitesseCouple(k) >= vitesseDecroMS_Max
        seuilCoupleMax(k)= puissanceMaxRoues / (vitesseCouple(k)/rr)
    end
end

for k=1:1:vitesseMax+1
    if vitesseCouple(k) <= vitesseDecroMS_Min
        seuilCoupleMin(k) = coupleMinRoues;
    elseif vitesseCouple(k) >= vitesseDecroMS_Min
        seuilCoupleMin(k)= puissanceMinRoues / (vitesseCouple(k)/rr)
    end
end

i = 2
for k=1:1:vitesseMinReg+4
   
    if vitesseCouple(k) <= vitesseMinReg
        seuilCoupleMin(k)=0;
    else vitesseCouple(k) > vitesseMinReg
        seuilCoupleMin(k)=coupleMinRoues * (i/4);
        i=i+1;
    end
    
end



plot(vitesseCouple, seuilCoupleMax, vitesseCouple, seuilCoupleMin )
grid ON
