function [ fmg ] = enrosin( s,mp )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%mp:�����ź�,fmg:����ź�

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

