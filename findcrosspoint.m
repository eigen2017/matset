function [ loc ] = findcrosspoint( x,y )
%findcrosspoint 此处显示有关此函数的摘要
%   找到交叉点
loc = length(x);
for i = 1:length(x)
    if y(i)>x(i)
        continue
    else
        loc = i;
        break;
    end
end


end

