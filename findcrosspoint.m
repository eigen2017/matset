function [ loc ] = findcrosspoint( x,y )
%findcrosspoint �˴���ʾ�йش˺�����ժҪ
%   �ҵ������
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

