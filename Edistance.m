function [ d ] = Edistance( x,y )
%Edistance ����������֮���ŷʽ����
%   x ��y ��������
%    d  ���ŷʽ����
x_l = length(x);
%y_l = length(y);
m = 0;
for i = 1:x_l
    m = m + (x(i) - y(i)) * (x(i) - y(i));
end
d = sqrt(m);
end

