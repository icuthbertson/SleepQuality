strpath = strcat('results',datestr(clock,'mm-dd-yy'),'.txt');
fileID = fopen(strpath,'w');
formatSpec = '%f,%f,%d,';

starttime=[0,1,2,3,4,5];
endtime = [1,2,3,4,5,6];
whitePixelCount = [100,500,400,250,700,900];

for i = 1:numel(whitePixelCount)
    fprintf(fileID,formatSpec,starttime(i),endtime(i),whitePixelCount(i));
end

fclose(fileID);