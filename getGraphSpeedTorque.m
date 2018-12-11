r =9.73;
nr=0.9

seuilCoupleMax = 660*r*nr;
seuilCoupleMin = -200*r*nr;
vitesseDecrochage = 80/3.6;
vitesseMax = 200/3.6;
vitesseFreinageReg = 20/3.6;

% x = [0, vitesseDecrochage, vitesseMax, vitesseDecrochage, vitesseFreinageReg, 0];
% y = [seuilCoupleMax, seuilCoupleMax, 0, seuilCoupleMin, seuilCoupleMin, 0];

xp = [0, vitesseDecrochage, vitesseMax];
yp = [seuilCoupleMax, seuilCoupleMax, 0];
xn = [vitesseMax, vitesseDecrochage, vitesseFreinageReg, 0];
yn = [0, seuilCoupleMin, seuilCoupleMin, 0];

v=(1:1:vitesseMax);

yp_int=interp1(xp,yp,v,'pchip');
yn_int=interp1(xn,yn,v,'pchip');

figure(5);
plot(v,yp_int,'b',v,yn_int,'g');