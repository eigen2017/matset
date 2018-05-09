function [ loc ] = findlocations( x,Y )
%UNTITLED3 此处显示有关此函数的摘要
%   找到s输入x在顺序数组Y中的位置
newarray = [x,Y];
sortarray = sort(newarray);
loc = find(sortarray==x);


end

