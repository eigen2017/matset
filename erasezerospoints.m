function [ y ] = erasezerospoints( ValidR,x ,invalidleads)
%UNTITLED27 此处显示有关此函数的摘要
%   此处显示详细说明
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

