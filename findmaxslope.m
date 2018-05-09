function [ location ] = findmaxslope( Array )
%findmaxslope 此处显示有关此函数的摘要
%   找出斜率绝对值最小的点
  oneOrder = diff(Array);
  %SecondOrder = diff(oneOrder);
  [minvalue,locations] = min(abs(oneOrder));
  location = locations(length(locations)) + 1; 


end

