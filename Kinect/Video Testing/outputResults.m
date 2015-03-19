function outputResults
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
fileID = fopen('results.txt','w');

formatSpec = '%f,%f,%d,';

epochStart = todatenum(cdfepoch(starttime));

fprintf(fileID,formatSpec,starttime,endtime,whitePixelCount);

end

