%main program to run the small illustartive


clc; clear; close all;

tic
nScenarios = 85;
%create the Inflow variables
load InputData % load [Imean Smax Smin D CVinflow]
%load InputCV

%--- Generate long (Guassian) inflow scenario [nScenarios*12]:
randn('state',71717151)
for ano = 1:nScenarios
    for month = 1:12
        Imatrix(ano,month) = Imean(month) + randn*CVinflow(month)*Imean(month);
    end
end
Imatrix(Imatrix<0) = 0; % negative becomes zero


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

x = fmincon('TSPobj',x,[],[],[],[],vlb,vub,'TSPconstr', options);

[f] = TSPobj(x)
%save values vals
[g,geq] = TSPconstr(x);
U = x(1:12);
save Rel U

toc