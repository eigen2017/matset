function [ y ] = erasezerospoints( ValidR,x ,invalidleads)
%UNTITLED27 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
j = 1;
for i = 1:12
   if(xifiny(i,invalidleads))
       continue;
   end
    a = ValidR{i};
    b = x{i};
    y{j} = b(a~=0);
    j = j + 1;
end

end

