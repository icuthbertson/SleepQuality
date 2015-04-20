strpath = strcat('Dist',datestr(starttime(1),'mm-dd-yy'),'.txt');

fileID = fopen(strpath,'w');
formatSpec = '%s,%s,';
fprintf(fileID,formatSpec,('SUBMIT'),('kinect_dist'));
fclose(fileID);

fileID = fopen(strpath,'w');
formatSpec = '%f,%f,%d,';

for i = 1:numel(Dist)
    fprintf(fileID,formatSpec,((starttime(i)-datenum(1970,1,1))*86400),((endtime(i)-datenum(1970,1,1))*86400),Dist(i));
end

fclose(fileID);
