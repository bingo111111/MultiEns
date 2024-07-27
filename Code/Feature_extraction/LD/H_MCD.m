clear all
clc
load Matine_Data.mat 
%load N_protein_a.mat 
%load N_protein_b.mat
%load P_protein_a.mat
%load P_proteinB_b.mat
num1=numel(P_protein_a);
LD_Pa=[];
LD_Pb=[];
LD_Na=[];
LD_Nb=[];
for i=1:num1
[M1]=MCDZD(P_protein_a{i});
M=[M1];
LD_Pa=[LD_Pa;M];
clear M;clear M1;
end
for i=1:num1
[M1]=MCDZD(P_protein_b{i});
M=[M1];
LD_Pb=[LD_Pb;M];
clear M;clear M1;
end
for i=1:num1
[M1]=MCDZD(N_protein_a{i});
M=[M1];
LD_Na=[LD_Na;M];
clear M;clear M1;
end
for i=1:num1
[M1]=MCDZD(N_protein_b{i});
M=[M1];
LD_Nb=[LD_Nb;M];
clear M;clear M1;
end
H_LD=[[LD_Pa,LD_Pb];[LD_Nb,LD_Na]];
H_LD=[[ones(1458,1);zeros(1458,1)],H_LD];
save T_H_LD.mat H_LD
save D_H_LD.mat LD_Pa LD_Pb LD_Na LD_Nb
  