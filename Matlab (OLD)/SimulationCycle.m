%% Test NEDC vs NEDC avec pente
te = (1:1:1180);
%ts = [195,390,780,1180];
ts = [1180];
alp = [0.05,0,-0.025,9.25E-04];
qq = [0, 994, 1988,3976,10932];
altqq = [0, 50,50, 0, 6.53] ;

i=1;
for k=1:1:length(te)

    alpha(k) = alp(i);

    if k == ts(i)
        i=i+1;
    end
end
tt = [te; alpha]';
plot(qq,altqq)

%% Test WLTP vs WLTP avec pente
% te = (1:1:1800);
% ts = [110,580,1000,1800];
% alp = [0.0488,-6.3E-03,4.24E-04];
% qq = [0, 614, 3094,7850,23250];
% altqq = [0, 30,30, 0, 6.53] ;
% 
% i=1;
% for k=1:1:length(te)
% 
%     alpha(k) = alp(i);
% 
%     if k == ts(i)
%         i=i+1;
%     end
% end
% tt = [te; alpha]';