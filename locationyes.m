function [ loc ] = locationyes( x,y )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
for i = 1:length(y)
    if (x ==y(i))
        loc = i;
        break;
    end
end


end

