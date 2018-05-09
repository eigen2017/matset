function [ flag ] = newsign( x )
%newsign ÅĞ¶Ïx µÄÕı¸º
for i = 1:length(x)
    if x(i)>=0
        flag(i) =1;
    else
        flag(i) = -1;
    end
end

