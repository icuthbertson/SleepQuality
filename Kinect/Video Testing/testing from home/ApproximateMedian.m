% This m-file implements the approximate median algorithm for background
% subtraction.  It may be used free of charge for any purpose (commercial
% or otherwise), as long as the author (Seth Benton) is acknowledged.
% 
% Adapted to make use of VideoReader and filter foreground noise 
% for Fall-Event Detection System by Fraser Kernohan 
% 
function [input] = ApproximateMedian(input)


thresh = 50;           

bg = input(10).cdata;           % read in 10th frame as background to remove camera start up error
%bg_bw = double(rgb2gray(bg));    % convert background to greyscale


% ----------------------- set frame size variables -----------------------

foreground = zeros(480, 640);

% --------------------- process frames -----------------------------------

for i = 11:200 %From background frame + 1 to end
    
    fr = input(i).cdata;
    %fr_bw = rgb2gray(fr);       % convert frame to grayscale
    fr_diff = abs(double(fr) - double(bg));  % cast operands as double to avoid negative overflow
    for k=1:480                 
         for j=1:640

             if ((fr_diff(k,j) > thresh))  % if fr_diff > thresh pixel in foreground
                 foreground(k,j) = fr(k,j); %Set foreground pixel to frame value
             else
                 foreground(k,j) = 0; %If difference isnt greater than threshold set pixel black
             end

                 if (fr(k,j) > bg(k,j))   %       
                 bg(k,j) = bg(k,j) + 1;   %Update background model
             elseif (fr(k,j) < bg(k,j))   %based on previous frame
                 bg(k,j) = bg(k,j) - 1;   % 
                 end
         end    
    end
    
        foreground = medfilt2(foreground); %Filter image using Median filter to 
                                           %remove salt and pepper noise
                                           
        figure(1),imshow(foreground);      %Display resulting foreground
             % save output as movie
   input(i).cdata = foreground; %Store foreground in video strucr

end
