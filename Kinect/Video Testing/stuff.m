counter = 0;
loop = 0;
classGraph = zeros(98000,1);
point = 1;
classValue = class(point);

for i = 1:98000
    classGraph(i) = class(point);
    if loop == 200
        point = point + 1;
        loop = 0;
    end
    loop = loop + 1;
end