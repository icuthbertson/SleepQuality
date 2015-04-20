function  outputRestless(starttime,dist)

strpath = strcat('data\Restless',datestr(starttime(1),'mm-dd-yy'),'.txt');

fileID = fopen(strpath,'w');
formatSpec = '%s,%s,';
fprintf(fileID,formatSpec,('SUBMIT'),('restless'));

formatSpec = '%d,';

restless = 0;
previous = 0;

for i = 1:numel(dist)
    if previous ~= dist(i)
        restless = restless + 1;
        previous = dist(i);
    end
end

if restless > 2
    
    fprintf(fileID,formatSpec,1);
else
    fprintf(fileID,formatSpec,0);
end

fclose(fileID);