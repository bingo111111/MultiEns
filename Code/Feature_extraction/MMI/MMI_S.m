clear all
clc
%load('Matine_Data.mat')
load('N_proteinA.mat')
load('N_proteinB.mat')
load('P_proteinA.mat')
load('P_proteinB.mat')
num1=numel(proteinB);
abc=[1,1,1;2,2,2;3,3,3;4,4,4;5,5,5;6,6,6;7,7,7];%三个一样
%三个不一样
for i=1:7
    for j=i+1:7
        for k=j+1:7
            abc=[abc;i,j,k];
        end
    end
end
%两个不一样
for i=1:7
    for j=i+1:7
        for k=i
            abc=[abc;i,j,k];
        end
    end
end
for i=1:7
    for j=i+1:7
        for k=j
            abc=[abc;i,j,k];
        end
    end
end
S_MMI_Pa=[];
S_MMI_Pb=[];
S_MMI_Na=[];
S_MMI_Nb=[];
            
 for i=1:num1
        MMI_Pa=MMI(P_proteinA(i),abc);
        MMI_Pb=MMI(P_proteinB(i),abc);
        MMI_Na=MMI(proteinA(i),abc);
        MMI_Nb=MMI(proteinB(i),abc);
        S_MMI_Pa=[S_MMI_Pa;MMI_Pa];
        S_MMI_Pb=[S_MMI_Pb;MMI_Pb];
        S_MMI_Na=[S_MMI_Na;MMI_Na];
        S_MMI_Nb=[S_MMI_Nb;MMI_Nb];
        
 end
 
 S_MMI=[[S_MMI_Pa,S_MMI_Pb];[S_MMI_Na,S_MMI_Nb]];
 S_MMI=[[ones(5594,1);zeros(5594,1)],S_MMI];

save T_S_MMI.mat S_MMI;
save D_S_MMI.mat S_MMI_Pa S_MMI_Pb S_MMI_Na S_MMI_Nb;
