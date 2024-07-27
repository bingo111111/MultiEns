clear all
clc
%load('Matine_Data.mat')
load('N_proteinA.mat')
load('N_proteinB.mat')
load('P_proteinA.mat')
load('P_proteinB.mat')
load('SVHEHS.mat')
OriginData=SVHEHS;
OriginData=OriginData';
num1=numel(P_proteinA);

for lag=1:11
   S_AC_Pa=[];
   S_AC_Pb=[];
   S_AC_Na=[];
   S_AC_Nb=[];
   for i=1:num1
        [AC_Pa,AC_Pb]=AC(P_proteinA{i},P_proteinB{i},OriginData,lag);
        [AC_Na,AC_Nb]=AC(proteinA{i},proteinB{i},OriginData,lag);
        S_AC_Pa=[S_AC_Pa;AC_Pa];
        S_AC_Pb=[S_AC_Pb;AC_Pb];
        S_AC_Na=[S_AC_Na;AC_Na];
        S_AC_Nb=[S_AC_Nb;AC_Nb];
   end
   
   S_AC=[[S_AC_Pa,S_AC_Pb];[S_AC_Na,S_AC_Nb]];
   S_AC=[[ones(5594,1);zeros(5594,1)],S_AC];
  
   total = ['T_S_AC_' num2str(lag) '.mat'];%文件名称
   save(total,'S_AC')%保存文件   

   divide = ['D_S_AC_' num2str(lag) '.mat'];%文件名称
   save(divide,'S_AC_Pa','S_AC_Pb','S_AC_Na','S_AC_Nb')%保存文件 
end
