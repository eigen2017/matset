function [ flag ] = findnearst( x,y )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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

