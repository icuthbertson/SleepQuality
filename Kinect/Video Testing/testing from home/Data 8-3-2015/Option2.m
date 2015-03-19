function [numWhitePixels] = Option2(whitePixels, numFrames)

numWhitePixels = 0;

for i = 11:numFrames %From background frame + 1 to end
    
    frame = whitePixels(i);
        
    numWhitePixels = numWhitePixels + frame;

end