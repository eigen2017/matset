function [ fmg ] = enrosin( s,mp )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
%mp:输入信号,fmg:输出信号

for i=1:length(mp)
    for j=1:length(s)
        if i+j<=length(mp)+1
            fg(j)=mp(i+j-1)-s(j);
        end
    end
    
   fmg(i)=max(fg);
   fg=[];
end
end

