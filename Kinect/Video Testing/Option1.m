function [numFramesAbove] = Option1(whitePixels, numFrames)

numFramesAbove = 0;

for i = 11:numFrames %From background frame + 1 to end
    
    frame = whitePixels(i);

    if (frame > 40000)
        numFramesAbove = numFramesAbove + 1;
    end
end