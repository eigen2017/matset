function [flag ] = xifiny( x, y)
%xifiny 此处显示有关此函数的摘要
%   判断数x是否在数组y中，如果x在数组y中，则返回1，否则，返回0
flag = 0;
for i = 1:length(y)
    if x==y(i)
        flag = 1;
        break;
    end
end

