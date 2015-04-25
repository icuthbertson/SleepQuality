[move, rem, dist, twitch] = classifySleepCycles(whitePixelCount,starttime);
outputMovementGraph(starttime,endtime,move);
outputREMGraph(starttime,endtime,rem);
outputDistGraph(starttime,endtime,dist);
outputTwitch(starttime,twitch);
outputRestless(starttime,dist);