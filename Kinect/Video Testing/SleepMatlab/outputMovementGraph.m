strpath = strcat('average_movement',datestr(starttime(1),'mm-dd-yy'),'.txt');
fileID = fopen(strpath,'w');

formatSpec = '%f,%f,%d,';

for i = 1:numel(cycleGraph)
    fprintf(fileID,formatSpec,starttime(i),endtime(i),cycleGraph(i));
end

fclose(fileID);
