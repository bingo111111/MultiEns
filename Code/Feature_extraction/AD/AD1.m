function [MBA]=AD1(proteinA,OriginData,lag)

AAindex = 'ACDEFGHIKLMNPQRSTVWY';
proteinA= strrep(proteinA,'X','');  % omit 'X' 
L1=length(proteinA); 
AAnum1= [];
for i=1:L1
AAnum1 = [AAnum1,OriginData(:,findstr(AAindex,proteinA(i)))];%findstr(str,sub)str为待查找的字符串，sub为子串。函数的返回值是一个数组，包含了所有子串在主字符串中出现的位置。
end

% Matrix1=[];
% Matrix2=[];
% bsxfun(@times,H(:,data),[H(:,shuju(i,i:end)),zeros(1,i-1)])
%bsxfun（@已有定义的函数名， 数组1，数组2）
%bsxfun（@（数组1，数组2）函数体表达式，数组1，数组2）
for i=1:lag
sum_term=bsxfun(@times,AAnum1(:,1:end-i),AAnum1(:,i+1:end));% times(A,B)=A.*B 
MBA1(:,i)=(1/(L1-i)).*sum(sum_term,2);%S = sum(A,dim) 沿维度 dim 返回总和。例如，如果 A 为矩阵，则 sum(A,2) 是包含每一行总和的列向量。
end
MBA1=MBA1';
MBA=reshape(MBA1,1,lag*13);
