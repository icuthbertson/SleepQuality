strpath = strcat('move',datestr(starttime(1),'mm-dd-yy'),'.txt');
fileID = fopen(strpath,'w');

formatSpec = '%f,%f,%d,';

for i = 1:numel(Move)
    fprintf(fileID,formatSpec,((starttime(i)-datenum(1970,1,1))*86400),((endtime(i)-datenum(1970,1,1))*86400),Move(i));
end

fclose(fileID);
