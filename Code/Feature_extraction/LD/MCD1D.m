function [mcd1po]=MCD1D(xulie)
% load MCDNE
% load MCDPO;
% xulie=numberpo;
% xulie=numberpo;
num=numel(xulie);
out=[];
for j=1:num
    set=xulie{j};
    N=length(set);
for i=1:7
    a{i}=length(find(set==i));
end
M=cell2mat(a);%cell2mat()把一个由多个矩阵构成的元胞数组转换成一个矩阵。
%意即把元胞数组中的多个矩阵合并成一个矩阵。
%需要注意的是并非任何情况下都能得到正确的结果。要得到正确的结果，
%一个基本要求是，在元胞数组中，处于同行的矩阵要有相等的行数，处于同列的矩阵要有相等的列数。
MC1{j}=M/N;
a=[];
set=[];
end
% mcd1ne=MC1;
% NUM=numel(MC1);
for k=1:num
    out=[out,[MC1{k}]];
end
mcd1po=out;
% save MCD1PO.mat mcd1po
