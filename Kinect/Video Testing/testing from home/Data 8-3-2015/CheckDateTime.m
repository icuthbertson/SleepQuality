function [keepRunning] = CheckDateTime(storedDateTime)

    temp = datenum(storedDateTime);

    keepRunning = 1;

    if (temp<now)
        keepRunning = 0;
    end

end

