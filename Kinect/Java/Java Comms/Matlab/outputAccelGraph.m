function  outputAccelGraph(starttime,endtime,accel)

strpath = strcat('data\Accel',datestr(starttime(1),'mm-dd-yy'),'.txt');

fileID = fopen(strpath,'w');
formatSpec = '%s,%s,';
fprintf(fileID,formatSpec,('SUBMIT'),('accel'));

formatSpec = '%f,%f,%d,';

for i = 1:numel(accel)
    fprintf(fileID,formatSpec,((starttime(i)-datenum(1970,1,1))*86400),((endtime(i)-datenum(1970,1,1))*86400),accel(i));
end

fclose(fileID);