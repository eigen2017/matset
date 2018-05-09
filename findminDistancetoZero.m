function [ location ] = findminDistancetoZero( array )
%findminDistancetoZero 
%   此处显示详细说明
%  求数组array中离0点最近的点
[minValue,locations] = min(abs(array));
location = locations(length(locations));
end

