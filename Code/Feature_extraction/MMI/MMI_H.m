clear all
clc
load('Matine_Data.mat')
num1=numel(P_protein_a);
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
H_MMI_Pa=[];
H_MMI_Pb=[];
H_MMI_Na=[];
H_MMI_Nb=[];
            
 for i=1:num1
        MMI_Pa=MMI(P_protein_a(i),abc);
        MMI_Pb=MMI(P_protein_b(i),abc);
        MMI_Na=MMI(N_protein_a(i),abc);
        MMI_Nb=MMI(N_protein_b(i),abc);
        H_MMI_Pa=[H_MMI_Pa;MMI_Pa];
        H_MMI_Pb=[H_MMI_Pb;MMI_Pb];
        H_MMI_Na=[H_MMI_Na;MMI_Na];
        H_MMI_Nb=[H_MMI_Nb;MMI_Nb];
        
 end
 
 H_MMI=[[H_MMI_Pa,H_MMI_Pb];[H_MMI_Na,H_MMI_Nb]];
 H_MMI=[[ones(1458,1);zeros(1458,1)],H_MMI];

save T_H_MMI.mat H_MMI;
save D_H_MMI.mat H_MMI_Pa H_MMI_Pb H_MMI_Na H_MMI_Nb;
