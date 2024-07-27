clear all
clc
load('Matine_Data.mat')
%load('N_proteinA.mat')
%load('N_proteinB.mat')
%load('P_proteinA.mat')
%load('P_proteinB.mat')
load('SVHEHS.mat')
OriginData=SVHEHS;
OriginData=OriginData';
num1=numel(P_protein_a);

for lag=1:11
   H_AC_Pa=[];
   H_AC_Pb=[];
   H_AC_Na=[];
   H_AC_Nb=[];
   for i=1:num1
        [AC_Pa,AC_Pb]=AC(P_protein_a{i},P_protein_b{i},OriginData,lag);
        [AC_Na,AC_Nb]=AC(N_protein_a{i},N_protein_b{i},OriginData,lag);
        H_AC_Pa=[H_AC_Pa;AC_Pa];
        H_AC_Pb=[H_AC_Pb;AC_Pb];
        H_AC_Na=[H_AC_Na;AC_Na];
        H_AC_Nb=[H_AC_Nb;AC_Nb];
   end
   
   H_AC=[[H_AC_Pa,H_AC_Pb];[H_AC_Na,H_AC_Nb]];
   H_AC=[[ones(1458,1);zeros(1458,1)],H_AC];
  
   total = ['T_H_AC_' num2str(lag) '.mat'];%文件名称
   save(total,'H_AC')%保存文件   

   divide = ['D_H_AC_' num2str(lag) '.mat'];%文件名称
   save(divide,'H_AC_Pa','H_AC_Pb','H_AC_Na','H_AC_Nb')%保存文件 
end
