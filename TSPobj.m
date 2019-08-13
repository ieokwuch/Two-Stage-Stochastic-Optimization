function [f] = TSPobj(x)

nScenarios = 85;
theta = 0.0000;

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

p = 1/nScenarios;
load InputData % load [Imean MAF NSM SKL Smax Smin D VAReta CVinflow]
%load InputCV

df = zeros(12, nScenarios);
sp = zeros(12, nScenarios);
count = 1;

for i = 1:12
    for j = 1:nScenarios
        df(i,j) = x(25 + count);
        count = count + 1;
    end
end

count = 1;
for i = 1:12
    for j=1:nScenarios
        sp(i,j) = x((25 + 12*nScenarios) + count);
        count = count + 1;
    end
end

D = reshape(D, [1,12]);
D = repmat(D, nScenarios,1);
U = reshape(U, [1,12]);
U = repmat(U, nScenarios, 1);


EC = p*(df + sp);
EC2 = p*(df.^2 + sp.^2);
VarK = EC2 - EC.^2;
VarK = sum(VarK(:));
stdK = VarK.^0.5;



f = p*sum(sum((U - D - sp.' + df.').^2)) + theta*stdK;
%std_dev = stdK;
%vals = [];
%load values
%vals = [vals; f-(theta*stdK), stdK] ;
%vals = [vals; f-(theta*stdK), stdK, 0] ;

