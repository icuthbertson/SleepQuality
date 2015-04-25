%This version of the file would record 400 frames and then analyse them.
%Issues with this are that something could be missed when not recording
%And other methods will need to be changed to take into account what
%happened before.
utilpath = fullfile(matlabroot, 'toolbox', 'imaq', 'imaqdemos', ...
    'html', 'KinectForWindows');
addpath(utilpath);

vid2 = videoinput('kinect',2,'Depth_640x480'); % Depth camera
srcDepth = getselectedsource(vid2);

fnum = 400;

vid2.FramesPerTrigger = 1;
vid2.TriggerRepeat = intmax;
triggerconfig(vid2,'manual');
start(vid2);

vidHeight = 480;
vidWidth = 640;

s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);

%yesNo = 0;
starttime = [];
endtime= [];
whitePixelCount = [];

keepRunning = 1;

fileID = fopen('data\date.txt','r'); %change text file name
formatSpec = '%f,%f,%f,%f,%f,%f';
tempDate = fscanf(fileID,formatSpec);
fclose(fileID);

tempDate = tempDate';

current = ((datenum(clock)-datenum(1970,1,1))*86400);
dateUntil = ((datenum(tempDate)-datenum(1970,1,1))*86400);

start = now;

while keepRunning > 0
    starttime = [starttime; now];
    for i = 1:fnum+1
        trigger(vid2)
    
        [imgDepthAll, ts_depthAll, metaData_DepthAll] = getdata(vid2);
    
        s(i).cdata = imgDepthAll;
        
    end
    endtime = [endtime; now];
    s = ApproximateMedian(s);

    tempWhitePixels = countWhitePixels(s, fnum);
    
    whitePixelCount = [whitePixelCount; tempWhitePixels];
    
    %yesNo = Option4(tempWhitePixels, fnum);
    
    %if (yesNo == 1)
    %    str = strcat('Data\output',num2str(counter),'.mat');
    %    save(str,'s','starttime','endtime');
    %end
    %counter = counter + 1;
    %yesNo = 0;
    
    keepRunning = CheckDateTime(dateUntil);
end

stop(vid2);
finish = now;

%save('Data\whitepixels.mat','whitePixelCount','starttime','endtime','start','finish');

[move,rem,dist,twitch] = classifySleepCycles(whitePixelCount,starttime);

outputMovementGraph(starttime,endtime,move);
outputREMGraph(starttime,endtime,rem);
outputDistGraph(starttime,endtime,dist);
outputTwitch(starttime,twitch);
outputRestless(starttime,dist);

system('java -jar ..\Jars\sendKinectDataToServer.jar')