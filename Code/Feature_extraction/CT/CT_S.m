clear all
clc
load('S_CT_Pa.mat');
load('S_CT_Pb.mat');
load('S_CT_Na.mat');
load('S_CT_Nb.mat');

S_CT=[[S_CT_Pa,S_CT_Pb];[S_CT_Na,S_CT_Nb]];
T_S_CT=[[ones(5594,1);zeros(5594,1)],S_CT];
%save CT_S.mat CT_S

save('T_S_CT.mat','T_S_CT')%保存文件   

save('D_S_CT.mat','S_CT_Pa','S_CT_Pb','S_CT_Na','S_CT_Nb')%保存文件
