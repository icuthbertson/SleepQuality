function [window_array] = classifySleepCycles2(classifiedMovement, numRows)

classified_sleep = zeros(numRows,1);
window_array = zeros(900/45,1);

count = 0;


for i = 1:(numRows/45) %From background frame + 1 to end
    
    for j = (45*(i-1))+1:(45*i)
        count = count + classifiedMovement(j,1);
    end
    window_array(i) = count;
    
    count = 0;
end