function  outputAudioGraph(starttime,endtime,audio)

strpath = strcat('data\Audio',datestr(starttime(1),'mm-dd-yy'),'.txt');

fileID = fopen(strpath,'w');
formatSpec = '%s,%s,';
fprintf(fileID,formatSpec,('SUBMIT'),('audio'));

formatSpec = '%f,%f,%d,';

for i = 1:numel(audio)
    fprintf(fileID,formatSpec,((starttime(i)-datenum(1970,1,1))*86400),((endtime(i)-datenum(1970,1,1))*86400),audio(i));
end

fclose(fileID);