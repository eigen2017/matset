function [ x,sl ] = shortestValid ( R,T,P )
%UNTITLED28 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
allcell = [R,T,P];
for i = 1:length(allcell)
    long(i)=length(allcell{i});
end
[m,n] = min(long);
x = allcell{n};
if (1<=n&&n<=length(R))
    sl = 'R';
elseif (length(R)<n&&n<=length(R)+length(T))
    sl = 'T';
else
    sl = 'P';


end

