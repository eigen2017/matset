function [flag ] = xifiny( x, y)
%xifiny �˴���ʾ�йش˺�����ժҪ
%   �ж���x�Ƿ�������y�У����x������y�У��򷵻�1�����򣬷���0
flag = 0;
for i = 1:length(y)
    if x==y(i)
        flag = 1;
        break;
    end
end

