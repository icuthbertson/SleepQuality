%
%  FallAnalysis.m
%  MATLAB function to test if fall occcured in given image using SVM Classifier
%  Author - Fraser Kernohan
%

function [REM] = SleepAnalysis(SVMData, SVMClassifier) 

REM = 0; %Set to 1 if a fall occurs

REM = svmclassify(SVMClassifier, SVMData); %Identify if fall occured in frame

end