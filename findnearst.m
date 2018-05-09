function [ flag ] = findnearst( x,y )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
index = findlocations(x,y);
if index >length(y)
    flag = length(y);
elseif (index==1)
    flag = 1;
else
    [value,loc] = min(abs(y(index-1)-x),abs(y(index)-x));
    flag = index-2+loc;
end

end

