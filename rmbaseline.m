function [yy ] = rmbaseline( x )
%rmbaseline 此处显示有关此函数的摘要
%   x :input signal
%   yy : output signal 
lenlen=4096;
% X=textread('F:\\ECG\\ecgnotfilter.data','%f');

%X=x;
% X=X';
 %X=X(17000:17000+8191);
%X=a;
X =x(1:4096);
a=zeros(lenlen-1,lenlen);
for i=1:lenlen-1
    a(i,i)=1;
    a(i,i+1)=-1;
end
b=a*a.';
I=eye(lenlen-1);
c=I/20000+b;
d=inv(c);
xx=a.'* d *a;



yy=xx*(X(1:lenlen)).';





end

