function [ value ] = findminDistance( x,y )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
% 找到数组y中离x最近的数，并输出这个数
d = zeros(1,length(y));
for i = 1:length(y)
    d(i) = abs(x - y(i));
end

[mindis,minloc] = min(d);
value = y(minloc);

end

