strpath = strcat('Accel',datestr(starttime(1),'mm-dd-yy'),'.txt');

fileID = fopen(strpath,'w');
formatSpec = '%s,%s,';
fprintf(fileID,formatSpec,('SUBMIT'),('kinect_accel'));
fclose(fileID);

fileID = fopen(strpath,'w');
formatSpec = '%f,%f,%d,';

for i = 1:numel(REM)
    fprintf(fileID,formatSpec,((starttime(i)-datenum(1970,1,1))*86400),((endtime(i)-datenum(1970,1,1))*86400),accel(i));
end

fclose(fileID);
