function [averageWhitePixels] = Option3(whitePixels, numFrames)

averageWhitePixels = whitePixels(11);
runningTotal = 1;

for i = 12:numFrames %From background frame + 1 to end
    
    runningTotal = runningTotal + 1;
    
    averageWhitePixels = ((averageWhitePixels + whitePixels(i))/runningTotal);
    display(averageWhitePixels)
    
end