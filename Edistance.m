function [ d ] = Edistance( x,y )
%Edistance 计算两向量之间的欧式距离
%   x ，y 输入向量
%    d  输出欧式距离
x_l = length(x);
%y_l = length(y);
m = 0;
for i = 1:x_l
    m = m + (x(i) - y(i)) * (x(i) - y(i));
end
d = sqrt(m);
end

