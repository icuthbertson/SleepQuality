function [MovementGraph, REMGraph, DisturbedGraph, twitch] = classifySleepCycles(whitePixelCount,starttime)

averageLength = 40;

whitePixelSize = size(whitePixelCount);

numRows = whitePixelSize(1);
numFrames = whitePixelSize(2);

[classifiedMovement, twitch] = classifyMovement(whitePixelCount,numFrames,numRows);

MovementGraph = zeros(numRows,1);
REMGraph = zeros(numRows,1);
DisturbedGraph = zeros(numRows,1);

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

[SVMClassifierREM, SVMClassifierDisturbed] = trainSVM();

for g = 1:numRows
    time = starttime(g)-starttime(1);
    SVMDataREM = [MovementGraph(g), time];
    REMGraph(g) = SleepAnalysis(SVMDataREM, SVMClassifierREM);
    SVMDataDisturbed = [MovementGraph(g), time];
    DisturbedGraph(g) = SleepAnalysis(SVMDataDisturbed, SVMClassifierDisturbed);
end

REMGraph = REMGraph*10;
DisturbedGraph = DisturbedGraph*10;