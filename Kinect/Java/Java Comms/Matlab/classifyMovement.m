function [classified_movement, twitch] = classifyMovement(whitePixelCount, numFrames, numRows)

classified_movement = zeros(numRows,1);
twitch = 0;

for i = 1:numRows %From background frame + 1 to end
    tempPixelCount = Option5(whitePixelCount(i,:),numFrames);
    
    if tempPixelCount > 10000
        classified_movement(i) = 2;
    elseif tempPixelCount > 4000
        classified_movement(i) = 1;
        twitch = twitch + 1;
    else
        classified_movement(i) = 0;
    end 
end