function [ loc ] = locationyes( x,y )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
for i = 1:length(y)
    if (x ==y(i))
        loc = i;
        break;
    end
end


end

