function  outputTwitch(starttime,twitch)

strpath = strcat('data\Twitch',datestr(starttime(1),'mm-dd-yy'),'.txt');

fileID = fopen(strpath,'w');
formatSpec = '%s,%s,';
fprintf(fileID,formatSpec,('SUBMIT'),('twitch'));

formatSpec = '%d,';

if twitch > 10
    fprintf(fileID,formatSpec,1);
else
    fprintf(fileID,formatSpec,0);
end

fclose(fileID);