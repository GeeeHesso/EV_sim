r =9.73;
nr=0.9
rr = 0.33

coupleMaxMoteur = 430; %Nm
coupleMaxRoues = coupleMaxMoteur * nr * r; %Nm
puissanceMaxMoteur = 222121; %W
puissanceMaxRoues = puissanceMaxMoteur * nr; %W

vitesseMax = 195/3.6;%m/s
vitesseDecroRadS = puissanceMaxRoues / coupleMaxRoues;
vitesseDecroMS = puissanceMaxRoues / coupleMaxRoues * rr;

vitesseCouple = 0:1:vitesseMax

for k=1:1:vitesseMax+1
    
    if vitesseCouple(k) <= vitesseDecroMS
        seuilCoupleMax(k) = coupleMaxRoues;
    elseif vitesseCouple(k) >= vitesseDecroMS
        seuilCoupleMax(k)= puissanceMaxRoues / (vitesseCouple(k)/rr)
    end
end

vitesseCouple = vitesseCouple *3.6;
seuilCoupleMax = seuilCoupleMax /nr/r;

seuilCoupleMin= (-1)*flipud(seuilCoupleMax);


plot(vitesseCouple, seuilCoupleMax, vitesseCouple, seuilCoupleMin )
grid ON
