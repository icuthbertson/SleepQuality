function [keepRunning] = CheckDateTime(storedDateTime)

    currentTime = ((datenum(clock)-datenum(1970,1,1))*86400); %epoch time
    keepRunning = 1;
    
    if (currentTime > storedDateTime)
        keepRunning = 0;
    end
end