
function [g,geq] = TSPconstr(x)

nScenarios = 85;
%g=zeros(26,1);
g=[];
%x = zeros(25+(24*nScenarios),1);
geq = zeros(12*nScenarios,1)';
%create release variables
u1 = x(1);
u2 = x(2);
u3 = x(3);
u4 = x(4);
u5 = x(5);
u6 = x(6);
u7 = x(7);
u8 = x(8);
u9 = x(9);
u10 = x(10);
u11 = x(11);
u12 = x(12);
U = [u1 u2 u3 u4 u5 u6 u7 u8 u9 u10 u11 u12];

%create storage variables
s0 = x(13);
s1 = x(14);
s2 = x(15);
s3 = x(16);
s4 = x(17);
s5 = x(18);
s6 = x(19);
s7 = x(20);
s8 = x(21);
s9 = x(22);
s10 = x(23);
s11 = x(24);
s12 = x(25);
S = [s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12];

df = zeros(12, nScenarios);
sp = zeros(12, nScenarios);


%create deficit variables for every scenario in every period
count = 1;
for i = 1:12
    for j = 1:nScenarios
        df(i,j) = x(25 + count);
        count = count + 1;
    end
end

%create spill variables for every scenario in every period
count = 1;
for i = 1:12
    for j=1:nScenarios
        sp(i,j) = x((25 + 12*nScenarios) + count);
        count = count + 1;
    end
end



%create the Inflow variables
load InputData % load [Imean Smax Smin D CVinflow]
%load InputCV

%--- Generate long (Guassian) inflow scenario [nScenarios*12]:
randn('state',71717151)
for ano = 1:nScenarios
    for month = 1:12
        Imatrix(ano,month) = Imean(month);% + randn*CVinflow(month)*Imean(month);
    end
end
Imatrix(Imatrix<0) = 0; % negative becomes zero


%create equality constraints which define the relationship between
%the first and second stage variables
count = 1;
for t=1:12
    for s = 1:nScenarios
       geq(count) = S(t+1) - S(t) - Imatrix(s,t) + U(t) + df(t,s) - sp(t,s);
       count = count + 1;
    end
end

%constraint setting the initial storage to be same as final storage


geq(12*nScenarios + 1) = s0 - s12; 

