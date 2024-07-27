clear all
clc
load('N_proteinA.mat')
load('N_proteinB.mat')
load('P_proteinA.mat')
load('P_proteinB.mat')
load('SVHEHS.mat')
OriginData=SVHEHS;
OriginData=OriginData';
num1=numel(proteinB);
%lag=1;
for lag=1:11
AD_Pa=[];
AD_Pb=[];
AD_Na=[];
AD_Nb=[];
    for i=1:num1
        [M1]=AD1(P_proteinA{i},OriginData,lag);
        [M2]=AD2(P_proteinA{i},OriginData,lag);
        [M3]=AD3(P_proteinA{i},OriginData,lag);
        M=[M1,M2,M3];
        AD_Pa=[AD_Pa;M];
        clear M;clear M1 M2 M3;
    end
    for i=1:num1
        [M1]=AD1(P_proteinB{i},OriginData,lag);
        [M2]=AD2(P_proteinB{i},OriginData,lag);
        [M3]=AD3(P_proteinB{i},OriginData,lag);
        M=[M1,M2,M3];
        AD_Pb=[AD_Pb;M];
        clear M;clear M1 M2 M3;
    end
    for i=1:num1
        [M1]=AD1(proteinA{i},OriginData,lag);
        [M2]=AD2(proteinA{i},OriginData,lag);
        [M3]=AD3(proteinA{i},OriginData,lag);
        M=[M1,M2,M3];
        AD_Na=[AD_Na;M];
        clear M;clear M1 M2 M3;
    end
    for i=1:num1
        [M1]=AD1(proteinB{i},OriginData,lag);
        [M2]=AD2(proteinB{i},OriginData,lag);
        [M3]=AD3(proteinB{i},OriginData,lag);
        M=[M1,M2,M3];
        AD_Nb=[AD_Nb;M];
        clear M;clear M1 M2 M3;
    end
    S_AD=[[AD_Pa,AD_Pb];[AD_Nb,AD_Na]];
    S_AD=[[ones(5594,1);zeros(5594,1)],S_AD];
    
%save data_Yeast_Auto_9_exchange.mat data_Auto
%save Auto_Yeast_9.mat Auto_Pa Auto_Pb Auto_Na Auto_Nb

total = ['T_S_AD_' num2str(lag) '.mat'];%文件名称
save(total,'S_AD')%保存文件   

divide = ['D_S_AD_' num2str(lag) '.mat'];%文件名称
save(divide,'AD_Pa','AD_Pb','AD_Na','AD_Nb')%保存文件 

end