temp = zeros(1,6);
tempDateNum = 0;
starttimeArray = zeros(900,1);
for i=1:900
    temp = starttime(((6*(i-1))+1):6*i);
    tempDateNum = todatenum(cdfepoch(datestr(temp)));
    starttimeArray(i) = tempDateNum;
end
