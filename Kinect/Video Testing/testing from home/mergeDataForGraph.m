y = [];
x2 = [];
fnum = 200;
counter = 0;

for x = 1:490
    
    for i = 1:fnum
        
        x2 = [x2, counter];
        y = [y; whitePixelCount(x,i)];
        counter = counter +1;
        
    end

end