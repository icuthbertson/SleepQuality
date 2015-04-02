function [maxWhitePixel] = Option5(whitePixels, numFrames)

maxWhitePixel = 0;

for i = 11:numFrames %From background frame + 1 to end
    
    frame = whitePixels(i);

    if (frame > maxWhitePixel)
        maxWhitePixel = frame;
    end
end