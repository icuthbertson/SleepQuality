%
% trainSVM.m
% Function to create SVM Classifier using training data obtained from example videos              
% Author - Fraser Kernohan
%

function [SVMClassifierREM,SVMClassifierDisturbed] = trainSVM()

%Testing Data was manually extracted from previous videos taken using 
%the VideoAnalysis function. This will simply return a trained SVM
%Classifier

%0 = NREM / 1 = REM / 2 = awake

%Training groups     0    1      1      0     0      0      0     
TestingDataREM = [0 0; 0 0.1 ; 1 0.2; 4 0; 1 0.1; 3 0.2; 4 0.3 ;
      %0       0         1      1        1      1       1    1
    5 0.3 ; 2 0.15 ; 0 0.15 ; 2 0.2 ; 3 0.3; 0 0.05; 3 0.4; 3 0.25;  
      %1      1      1       0     0      0      0       0     0
    0 0.1; 3 0.2; 2 0.3; 2 0.01; 5 0.3 ; 4 0.2; 2 0.1; 4 0.3; 4 0.25; 
      %0
    3 0.15];
TestingClassesREM = [0;1;1;0;0;0;0;0;0;1;1;1;1;1;1;1;1;1;0;0;0;0;0;0;0];

%Training groups         0    1         1       0      1        1
TestingDataDisturbed = [9 0; 10 0.1 ; 10 0.2; 9 0.3; 8 0.2; 8 0.1];
TestingClassesDisturbed = [0;1;1;0;0;0];

SVMClassifierREM = svmtrain(TestingDataREM,TestingClassesREM);
SVMClassifierDisturbed = svmtrain(TestingDataDisturbed,TestingClassesDisturbed,'ShowPlot',true);
end

