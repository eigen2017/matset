function [ a ] = mean_enery( b )
%b��ʾ�����źţ�a��ʾ��ƽ������

N=length(b);
sum=0;
for i=1:N
    sum=sum+b(i)*b(i);
end
a=sum/N;
end

