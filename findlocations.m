function [ loc ] = findlocations( x,Y )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �ҵ�s����x��˳������Y�е�λ��
newarray = [x,Y];
sortarray = sort(newarray);
loc = find(sortarray==x);


end

