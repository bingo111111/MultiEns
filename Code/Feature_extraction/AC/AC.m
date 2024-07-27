function [sequence_A,sequence_B]=AC(proteinA,proteinB,OriginData,parameter);
AAindex = 'ACDEFGHIKLMNPQRSTVWY';
proteinA= strrep(proteinA,'X','');  % omit 'X'
proteinB= strrep(proteinB,'X','');  % omit 'X'
L1=length(proteinA); 
L2=length(proteinB);
AAnum1= [];
AAnum2= [];
for i=1:L1
AAnum1 = [AAnum1,OriginData(:,findstr(AAindex,proteinA(i)))];%findstr(str,sub)str为待查找的字符串，sub为子串。函数的返回值是一个数组，包含了所有子串在主字符串中出现的位置。
end
for i=1:L2
AAnum2 = [AAnum2,OriginData(:,findstr(AAindex,proteinB(i)))];
end
Matrix1=[];
Matrix2=[];
for i=1:13
    t1=zeros(1,parameter);
    t2=zeros(1,parameter);
    for j=1:parameter
        for k=1:(L1-j)
           J=(AAnum1(i,k)-sum(AAnum1(i,:)/L1))*(AAnum1(i,(k+j))-sum(AAnum1(i,:)/L1));
            t1(j)=t1(j)+J;
            J=[];
        end
        for k=1:(L2-j)
           J=(AAnum2(i,k)-sum(AAnum2(i,:)/L2))*(AAnum2(i,(k+j))-sum(AAnum2(i,:)/L2));
            t2(j)=t2(j)+J;
            J=[];
        end
        t1(j)=t1(j)/(L1-j);
        t2(j)=t2(j)/(L2-j);
     end
       Matrix1=[Matrix1,t1];
       Matrix2=[Matrix2,t2];
end
sequence_A=Matrix1;
sequence_B=Matrix2;