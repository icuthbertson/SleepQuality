temp = zeros(1,6);
tempDateNum = 0;
starttimeArray = zeros(900,1);
for i=1:900
    temp = starttime(i,1:6);
    tempDateNum = todatenum(cdfepoch(datestr(temp)));
    starttimeArray(i) = tempDateNum;
end
