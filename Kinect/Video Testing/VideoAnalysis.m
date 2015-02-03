%
%  VideoAnalysis.m
%  Function to perform EdgeDetection and Feature Extraction on foreground
%  Author - Fraser Kernohan
%


function [SVMData, edgeImage] = VideoAnalysis(foregroundImage)


    edgeImage = edge(foregroundImage,'canny'); %Detect edges in image 
    edgeImage = bwmorph(edgeImage, 'close'); %Perform morphological operations to improve quality of image
    edgeImage = bwmorph(edgeImage, 'fill');  %Tidies blobs and closes pixel sized gaps
    figure(1), imshow(edgeImage); %Display edge image
    
    heightSouth = 0;
    heightNorth = 4000; %default values for height and width incase no
    rightWidth = 0;     %white pixels are contained in frame. These values
    leftWidth = 4000;   %when passed back will identify to main not to classify. 
    
    personPixels = regionprops(edgeImage, 'pixellist'); %Obtain a list of pixels remaining 
    blobs = size(personPixels); %Number of white pixel segments in image 
     for p = 1:blobs(1) %From blob 1 until end of segments
        currentMax = max(personPixels(p).PixelList(:,2)); %Largest y co-ord
        currentMin = min(personPixels(p).PixelList(:,2)); %Smallest y co-ord
        
        if currentMax > heightSouth %If the current largest vertical pixel is largest in image
            heightSouth = currentMax; %Set largest vertical pixel to this value
        end
        if currentMin < heightNorth %If the current smallest vertical pixel is smallest in image
            heightNorth = currentMin; %Set smallest vertical pixel to this value
        end
     end
        
        %This segment does the same thing for the width of the pixels 
        %via x co-ordinates

     for q = 1:blobs(1)
        currentMax = max(personPixels(q).PixelList(:,1));
        currentMin = min(personPixels(q).PixelList(:,1));
        if currentMax > rightWidth
             rightWidth = currentMax;
        end
        if currentMin < leftWidth
             leftWidth = currentMin;
        end
     end
    
    
    personHeight = heightSouth-heightNorth; %Obtain height differrence of person
    personPixels = rightWidth - leftWidth; %Obtain width difference of person
    
    SVMData = [personHeight personPixels]; %Set SVM data to these values for classification
end


 