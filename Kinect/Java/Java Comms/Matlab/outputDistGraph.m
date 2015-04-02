function  outputDistGraph(starttime,endtime,dist)

strpath = strcat('data\dist',datestr(starttime(1),'mm-dd-yy'),'.txt');

fileID = fopen(strpath,'w');
formatSpec = '%s,%s,';
fprintf(fileID,formatSpec,('SUBMIT'),('kinect_dist'));

formatSpec = '%f,%f,%d,';

for i = 1:numel(dist)
    fprintf(fileID,formatSpec,((starttime(i)-datenum(1970,1,1))*86400),((endtime(i)-datenum(1970,1,1))*86400),dist(i));
end

fclose(fileID);