function [ value ] = findminDistance( x,y )
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% �ҵ�����y����x�������������������
d = zeros(1,length(y));
for i = 1:length(y)
    d(i) = abs(x - y(i));
end

[mindis,minloc] = min(d);
value = y(minloc);

end

