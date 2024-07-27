clear all
clc
load('N_proteinA.mat')
load('N_proteinB.mat')
load('P_proteinA.mat')
load('P_proteinB.mat')
num1=numel(P_proteinA);

%lambda=1;

for lambda=1:11
result_1=[];
result_11=[];
result_2=[];
result_22=[];
    for i=1:num1
     result1=PseAAC(P_proteinA{i},lambda);
     result11=PseAAC(P_proteinB{i},lambda);
     result_1=[result_1;result1];
     result1=[];
     result_11=[result_11;result11];
     result11=[];
    end
    for i=1:num1
     result2=PseAAC(proteinA{i},lambda);
     result22=PseAAC(proteinB{i},lambda);
     result_2=[result_2;result2];
     result2=[];
     result_22=[result_22;result22];
     result22=[];
    end
    Pa=result_1;
    Pb=result_11;
    Na=result_2;
    Nb=result_22;
    S_PseAAC=[[Pa,Pb];[Nb,Na]];
    S_PseAAC=[[ones(5594,1);zeros(5594,1)],S_PseAAC];
 
  %save data_S_PAAC_1.mat H_PAAC
  %save PAAC_S_1.mat  Pa Pb Na Nb
  total = ['T_S_PseAAC_' num2str(lambda) '.mat'];%文件名称
  save(total,'S_PseAAC')%保存文件   

  divide = ['D_S_PseAAC_' num2str(lambda) '.mat'];%文件名称
  save(divide,'Pa','Pb','Na','Nb')%保存文件 


end

