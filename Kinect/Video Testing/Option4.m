function [yesNo] = Option4(whitePixels, numFrames)

averageWhitePixels = whitePixels(11);
runningTotal = 1;

yesNo = 0;
for i = 11:numFrames %From background frame + 1 to end
    
    frame = whitePixels(i);

    if (frame > 5000)
        yesNo = 1;
        return;
    end
    
end