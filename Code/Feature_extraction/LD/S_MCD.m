clear all
clc
load N_proteinA.mat 
load N_proteinB.mat
load P_proteinA.mat
load P_proteinB.mat
num1=numel(P_proteinA);
LD_Pa=[];
LD_Pb=[];
LD_Na=[];
LD_Nb=[];
for i=1:num1
[M1]=MCDZD(P_proteinA{i});
M=[M1];
LD_Pa=[LD_Pa;M];
clear M;clear M1;
end
for i=1:num1
[M1]=MCDZD(P_proteinB{i});
M=[M1];
LD_Pb=[LD_Pb;M];
clear M;clear M1;
end
for i=1:num1
[M1]=MCDZD(proteinA{i});
M=[M1];
LD_Na=[LD_Na;M];
clear M;clear M1;
end
for i=1:num1
[M1]=MCDZD(proteinB{i});
M=[M1];
LD_Nb=[LD_Nb;M];
clear M;clear M1;
end
S_LD=[[LD_Pa,LD_Pb];[LD_Nb,LD_Na]];
S_LD=[[ones(5594,1);zeros(5594,1)],S_LD];
save T_S_LD.mat S_LD
save D_S_LD.mat LD_Pa LD_Pb LD_Na LD_Nb
