function [x1,y1,z1] = readCSV(filename,rowStart)

file = csvread(filename);
disp(length(file));

for k=1:1:length(file)
    x1(k)=file(k,rowStart);
    y1(k)=file(k,rowStart+1);
    z1(k)=file(k,rowStart+2);
end

end
