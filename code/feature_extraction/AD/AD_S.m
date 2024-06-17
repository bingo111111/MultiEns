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


total = ['T_S_AD_' num2str(lag) '.mat'];
save(total,'S_AD')

divide = ['D_S_AD_' num2str(lag) '.mat'];
save(divide,'AD_Pa','AD_Pb','AD_Na','AD_Nb')

end