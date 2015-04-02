format long;

fileID = fopen('data\date.txt','r'); %change text file name
formatSpec = '%f,%f,%f,%f,%f,%f';
tempDate = fscanf(fileID,formatSpec);
fclose(fileID);

load('whitepixels.mat')

tempDate = tempDate';

[move, rem, dist] = classifySleepCycles(whitePixelCount, starttime);

outputMovementGraph(starttime,endtime,move);
outputREMGraph(starttime,endtime,rem);
outputDistGraph(starttime,endtime,dist);

keepRunning = 1;
current = ((datenum(clock)-datenum(1970,1,1))*86400);
dateUntil = ((datenum(tempDate)-datenum(1970,1,1))*86400);

display(dateUntil)
display(current)

display(dateUntil-current)

while keepRunning > 0
    keepRunning = CheckDateTime(dateUntil);
end

display(dateUntil)
display(((datenum(clock)-datenum(1970,1,1))*86400)-3600);

system('java -jar ..\Jars\test.jar')