function [ location ] = findminDistancetoZero( array )
%findminDistancetoZero 
%   �˴���ʾ��ϸ˵��
%  ������array����0������ĵ�
[minValue,locations] = min(abs(array));
location = locations(length(locations));
end

