%main program to optimization for EVPI calculations


clc; clear; close all;

tic
nScenarios = 55;
%create the Inflow variables
load InputData % load [Imean Smax Smin D CVinflow]
%load InputCV



x = zeros(25+(24*nScenarios),1);
vlb=zeros(25+(24*nScenarios),1);
vub=+Inf*ones(25+(24*nScenarios),1);
%vub =[];
for i = 13:25
    vlb(i) = Smin(1);
    vub(i) = Smax(1);
end


options=optimoptions('fmincon','disp','iter','TolFun',.001,'MaxIter',100000,'MaxFunEvals',100000);
options.Algorithm = 'sqp';

x = fmincon('TSPobjlin',x,[],[],[],[],vlb,vub,'TSPconstrEVPI', options);

[f] = TSPobjlin(x)
%save values vals
[g,geq] = TSPconstrEVPI(x);

toc