
figure(10)
subplot(3,2,1);
plot( c_dist_int(1:1:length(c_dist_int)-1), dxdl)
subplot(3,2,2);
plot( c_dist_int(1:1:length(c_dist_int)-1), dydl)
subplot(3,2,3);
plot( c_dist_int(1:1:length(c_dist_int)-2), d2xdl)
subplot(3,2,4);
plot( c_dist_int(1:1:length(c_dist_int)-2), d2ydl)
subplot(3,2,5);
plot( c_dist_int(1:1:length(c_dist_int)-2), atWW,c_dist_int(1:1:length(c_dist_int)-2), at)
subplot(3,2,6);
plot( c_dist_int(1:1:length(c_dist_int)-2), atWW,c_dist_int(1:1:length(c_dist_int)-2), at)
%plot( c_dist_int(1:1:length(c_dist_int)-2), phi)

