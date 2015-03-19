storedDateTime = clock;

storedDateTime(5) = storedDateTime(5)+1;

display(storedDateTime)

counter = 0;

keepRunning = 1;

while keepRunning > 0
    counter = counter + 1;
    
    keepRunning = CheckDateTime(storedDateTime);
end

display(counter)