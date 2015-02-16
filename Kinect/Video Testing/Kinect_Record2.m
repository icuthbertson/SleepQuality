%This version of the file would record 200 frames and then save them.
%Issues with this are possbile lack of memory.
utilpath = fullfile(matlabroot, 'toolbox', 'imaq', 'imaqdemos', ...
    'html', 'KinectForWindows');
addpath(utilpath);

vid2 = videoinput('kinect',2,'Depth_640x480'); % Depth camera
srcDepth = getselectedsource(vid2);

fnum = 200;

vid2.FramesPerTrigger = 1;
vid2.TriggerRepeat = 2200;
triggerconfig(vid2,'manual');
start(vid2);

vidHeight = 480;
vidWidth = 640;

s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);
t = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);
u = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);

full_record = [];
starttime = [];
endtime = [];

for x = 1:10
    starttime = [starttime; clock];
    for i = 1:fnum+1
        % Trigger both objects.
        trigger(vid2)
    
        [imgDepthAll, ts_depthAll, metaData_DepthAll] = getdata(vid2);
    
        s(i).cdata = imgDepthAll;
        %  t(i).cdata = ts_depthAll;
        %  u(i).cdata = metaData_DepthAll;
        
    end
    endtime = [endtime; clock];
    full_record = [full_record; s];
    
    %s = ApproximateMedian(s);

    %whitePixelCount = countWhitePixels(s, fnum);
end

stop(vid2);

%[x, pewpdi] = VideoAnalysis(s(1).cdata);
% If you don't stop you can't start video acquisition again. it will give
% error when you try to start again. in this case call fnc below

%close(vidObj);