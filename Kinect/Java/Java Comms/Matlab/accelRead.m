%start and end time can be the same value if needed.
%if alan does the dot product.
frameLength = 400;

fileID = fopen('move03-06-15.txt','r'); %change text file name
formatSpec = '%f,%f,';
accelFromFile = fscanf(fileID,formatSpec);
fclose(fileID);

accel = zeros((numel(accelFromFile)/2),1);
accelStart = zeros((numel(accelFromFile)/2),1);
accelEnd = zeros((numel(accelFromFile)/2),1);

counter = 1;
for i=1:2:numel(accelFromFile)
    accel(counter,1) = accelFromFile(i);
    accelStart(counter,1) = accelFromFile(i+1);
    accelEnd(counter,1) = accelFromFile(i+1);
    counter = counter+1;
end

%put values in a 2d array like the whitepixel counts
twoDArrayLength = floor(numel(accel)/frameLength);

accelForAnalysing = zeros(twoDArrayLength,frameLength);
accelStartForAnalysing = zeros(twoDArrayLength);
accelEndForAnalysing = zeros(twoDArrayLength);

for j=1:1:twoDArrayLength
    for k=1:frameLength
        accelForAnalysing(j,k) = accel(j*k);
    end
    accelStartForAnalysing(j) = accelStart(j);
    accelEndForAnalysing(j) = accelEnd(j*frameLength);
end
%might being missing some values off the end of the array cause taking floor as length?

%if we does the dot product.
%fileID = fopen('move03-06-15.txt','r'); %change text file name
%formatSpec = '%f,%f,%f,%f,';
%accelFromFile = fscanf(fileID,formatSpec);
%fclose(fileID);

%accelX = zeros((numel(accelFromFile)/4),1);
%accelY = zeros((numel(accelFromFile)/4),1);
%accelZ = zeros((numel(accelFromFile)/4),1);
%accelStart = zeros((numel(accelFromFile)/4),1);
%accelEnd = zeros((numel(accelFromFile)/4),1);

%counter = 1;
%for i=1:4:numel(accelFromFile)
%    accelX(counter,1) = accelFromFile(i);
%    accelY(counter,1) = accelFromFile(i+1);
%    accelZ(counter,1) = accelFromFile(i+2);
%    accelStart(counter,1) = accelFromFile(i+3);
%    accelEnd(counter,1) = accelFromFile(i+3);
%    counter = counter+1;
%end

%twoDArrayLength = floor(numel(accel)/frameLength);

%accelForAnalysing = zeros(twoDArrayLength,frameLength);

%for j=1:1:twoDArrayLength
%    for k=1:frameLength
%        valueThing = some calc on accelX, accelY and accelZ to give a total vlaue
%        cross product or dot product or something like that.
%        accelForAnalysing(j,k) = valueThing;
%    end
%    accelStartForAnalysing(j) = accelStart(j);
%    accelEndForAnalysing(j) = accelEnd(j*frameLength);
%end