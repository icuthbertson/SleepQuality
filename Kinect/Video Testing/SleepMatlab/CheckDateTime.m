function [keepRunning] = CheckDateTime(storedDateTime)

    temp = clock;

    keepRunning = 1;

    if (temp(1)>storedDateTime(1))
        keepRunning = 0;
    end
    if (temp(2)>storedDateTime(2))
        keepRunning = 0;
    end
    if (temp(3)>storedDateTime(3))
        keepRunning = 0;
    end
    if (temp(4)>storedDateTime(4))
        keepRunning = 0;
    end
    if (temp(5)>storedDateTime(5))
        keepRunning = 0;
    end

end

