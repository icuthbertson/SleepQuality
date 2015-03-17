function [classified_movement] = classifyMovement(whitePixelCount, numFrames, numRows)

classified_movement = zeros(numRows,1);

for i = 1:numRows %From background frame + 1 to end
    tempPixelCount = Option5(whitePixelCount(i,:),numFrames);
    
    if tempPixelCount > 10000
        classified_movement(i) = 2;
    elseif tempPixelCount > 4000
        classified_movement(i) = 1;
    else
        classified_movement(i) = 0;
    end 
end
