function [MovementGraph, REMGraph] = classifySleepCycles(whitePixelCount,starttime)

averageLength = 40;

whitePixelSize = size(whitePixelCount);

numRows = whitePixelSize(1);
numFrames = whitePixelSize(2);

classifiedMovement = classifyMovement(whitePixelCount,numFrames,numRows);

MovementGraph = zeros(numRows,1);
REMGraph  = zeros(numRows,1);

count = 0;

for x = 1:averageLength 
    for y = x:-1:1
        count = count + classifiedMovement(y,1);
    end
    MovementGraph(x) = count;
    
    count = 0;
end

for i = averageLength+1:(numRows) %From background frame + 1 to end
    
    for j = (i):-1:(i-averageLength)
        count = count + classifiedMovement(j,1);
    end
    MovementGraph(i) = count;
    
    count = 0;
end

SVMClassifier = trainSVM();

for g = 1:numRows
    time = starttime(g)-starttime(1);
    SVMData = [MovementGraph(g), time];
    REMGraph(g) = FallAnalysis(SVMData, SVMClassifier);
end

REMGraph = REMGraph*10;
