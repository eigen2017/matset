% function [result ] = fitness(x,D)
% 
%   sum=0;
%   for i=1:D
%       sum=sum+x(i)^2;
%   end
% result=sum;
% end

%���������ʵ������ľ������
function [result] = fitness(x,y)
 lengthData = length(x);
 sum=0;
 for i = 1:lengthData
     sum = sum + (x(i)-y(i)) * (x(i)-y(i));
 end
 result = sum/lengthData;
end