clear all
clc
load('Matine_Data.mat')
%load('N_protein_b.mat')
%load('P_protein_a.mat')
%load('P_protein_b.mat')
num1=numel(P_protein_a);

%lambda=1
for lambda=1:11
result_1=[];
result_11=[];
result_2=[];
result_22=[];
    for i=1:num1
     result1=PseAAC(P_protein_a{i},lambda);
     result11=PseAAC(P_protein_b{i},lambda);
     result_1=[result_1;result1];
     result1=[];
     result_11=[result_11;result11];
     result11=[];
    end
    for i=1:num1
     result2=PseAAC(N_protein_a{i},lambda);
     result22=PseAAC(N_protein_b{i},lambda);
     result_2=[result_2;result2];
     result2=[];
     result_22=[result_22;result22];
     result22=[];
    end
    Pa=result_1;
    Pb=result_11;
    Na=result_2;
    Nb=result_22;
    H_PseAAC=[[Pa,Pb];[Nb,Na]];
    H_PseAAC=[[ones(1458,1);zeros(1458,1)],H_PseAAC];
   
%save data_H_PAAC_1.mat H_PAAC
%save PAAC_H_1.mat  Pa Pb Na Nb
total = ['T_H_PseAAC_' num2str(lambda) '.mat'];%文件名称
save(total,'H_PseAAC')%保存文件   

divide = ['D_H_PseAAC_' num2str(lambda) '.mat'];%文件名称
save(divide,'Pa','Pb','Na','Nb')%保存文件      

end

