clear all
clc
load A.mat 
load B.mat 
num1=numel(A);
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
Wnt_MMI_a=[];
Wnt_MMI_b=[];
            
 for i=1:num1
        MMI_a=MMI(A(i),abc);
        MMI_b=MMI(B(i),abc);
        Wnt_MMI_a=[Wnt_MMI_a;MMI_a];
        Wnt_MMI_b=[Wnt_MMI_b;MMI_b];   
 end
 
 Wnt_MMI=[Wnt_MMI_a,Wnt_MMI_b];

save T_Wnt_MMI.mat Wnt_MMI;
save D_Wnt_MMI.mat Wnt_MMI_a Wnt_MMI_b;
