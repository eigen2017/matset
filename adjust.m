function [ output ] = adjust( x,y )
%UNTITLED30 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
for i = 1:length(y)
    s = 1;
    for j = 2:length(x)-2;
        index = findlocations(x(j),y{i});
        if(index(1) > length(y{i})-1)
            break;
        end
        [m,n] = min(abs(x(j)-[y{i}(index(1)-1),y{i}(index(1)),y{i}(index(1)+1)]));
        output(i,s) = y{i}(index(1)+n-2);
        s = s + 1;
    end
end

