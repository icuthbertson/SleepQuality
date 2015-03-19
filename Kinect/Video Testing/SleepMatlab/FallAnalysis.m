%
%  FallAnalysis.m
%  MATLAB function to test if fall occcured in given image using SVM Classifier
%  Author - Fraser Kernohan
%

function [fall] = FallAnalysis(SVMData, SVMClassifier) 

fall = 0; %Set to 1 if a fall occurs

fall = svmclassify(SVMClassifier, SVMData); %Identify if fall occured in frame

end
