function [ y ] = min6( x )
%min6 �ҳ���������С��6������λ��
%   x  �����һά����
%   y  ��С��6������λ��
xx = x;
min1 = min(x);
x(find(x == min1)) = [];
min2 = min(x);
x(find(x == min2)) = [];
min3 = min(x);
x(find(x == min3)) = [];
min4 = min(x);
x(find(x == min4)) = [];
min5 = min(x);
x(find(x == min5)) = [];
min6 = min(x);
y(1) = find(xx == min1);
y(2) = find(xx == min2);
y(3) = find(xx == min3);
y(4) = find(xx == min4);
y(5) = find(xx == min5);
y(6) = find(xx == min6);
end

