function [ flsg ] = findjizhidianfangxiang( x )
%UNTITLED17 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
flsg = 1;
jidazhi=x(find(diff(sign(diff(x)))==-2)+1);
jixiaozhi = x(find(diff(sign(diff(x)))==2)+1);
sorted = super_sort([jidazhi jixiaozhi],@abs);
cnt = 0;
if length(sorted)<3
    flsg = sign(sorted(end));
else
    for i = 0:2
        cnt = cnt + sign(sorted(end-i));
    end
    if cnt == 1
        flsg = -1;
    end
end



end

