function [whitePixels] = countWhitePixels(foregroundImage, numFrames)
    
    
    whitePixels = zeros(1, numFrames);
    
for i = 11:numFrames %From background frame + 1 to end
    
    frame = foregroundImage(i).cdata;

    for k=1:480                 
         for j=1:640

             if ((frame(k,j) > 0))  % if fr_diff > thresh pixel in foreground
                whitePixels(i) = whitePixels(i) + 1;
             end
         end    
    end
end