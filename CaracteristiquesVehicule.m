rho = 1.225;
g=9.81;
id=6
switch id
    case 1
        m= 2250;
        s = 1;%2.341157;
        cx = 0.5;%0.24;
        crr=0.015;
        rr= 0.32995;%19pouce de rayon de jante
        r=9.73;
        nr=0.95;
        nm=0.9;
        nc=0.93;
        cb=98;
        mlimit=660;
    case 2
        m= 1800;
        s = 1;%2.341157;
        cx = 0.5;%0.24;
        crr=0.015;
        rr= 0.32995;%19pouce de rayon de jante
        r=9.73;
        nr=0.9;
        nm=0.89;
        nc=0.89;
        cb=75;
        mlimit=410;
    case 3
        m= 1468;
        s = 1.5;%2.341157;
        cx = 0.5;%0.24;
        crr=0.015;
        rr= 0.29;%19pouce de rayon de jante
        r=9.73;
        nr=0.9;
        nm=0.89;
        nc=0.89;
        cb=22;
        mlimit=220;
    case 4
        m= 2208;
        s = 2.675;%2.341157;
        cx = 0.29;%0.24;
        crr=0.015;
        rr= 0.3765;%19pouce de rayon de jante
        r=9.73;
        nr=0.91;
        nm=0.89;
        nc=0.91;
        cb=90;
        mlimit=696;
    case 5
        m= 0;
        s = 0;%2.341157;
        cx = 0;%0.24;
        crr=0;
        rr= 0;%19pouce de rayon de jante
        r=0;
        nr=0;
        nm=0;
        nc=0;
        cb=0;
    otherwise
        m= 2250;
        s = 1;%2.341157;
        cx = 0.5;%0.24;
        crr=0.015;
        rr= 0.32995;%19pouce de rayon de jante
        r=9.73;
        nr=0.9;
        nm=0.89;
        nc=0.89;
        cb=98;
        mlimit=660;
end

lissTunnel = false;
%t=[0:0.5:10];



