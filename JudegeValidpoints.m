function [ Valid ] = JudegeValidpoints( x,y )
%UNTITLED25 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Valid = cell(12,1);
for i = 1:12
    for j = 1:length(x{i})
        if (y(x{i}(j)) >= 9)
            Valid{i}(j) = 1;
        else
            Valid{i}(j) = 0;
        end
    end
end
end

