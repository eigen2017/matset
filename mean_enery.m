function [ a ] = mean_enery( b )
%b表示输入信号，a表示其平均能量

N=length(b);
sum=0;
for i=1:N
    sum=sum+b(i)*b(i);
end
a=sum/N;
end

