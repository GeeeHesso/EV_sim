faerotot=0;
i=0;
for k=1:1:length(faero.data)
    faerotot = faerotot + faero.data(k)
    i=i+1;
end
faeromoy = faerotot/i;

finertot=0;
i=0;
for k=1:1:length(finer.data)
    finertot = finertot + finer.data(k)
    i=i+1;
end
finermoy = finertot/i;

fpestot=0;
i=0;
for k=1:1:length(fpes.data)
    fpestot = fpestot + fpes.data(k)
    i=i+1;
end
fpesmoy = fpestot/i;

froultot=0;
i=0;
for k=1:1:length(finer.data)
    froultot = froultot + froul.data(k)
    i=i+1;
end
froulmoy = froultot/i;
