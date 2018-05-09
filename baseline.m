lenlen=3600;
% X=textread('F:\\ECG\\ecgnotfilter.data','%f');

%X=x;
% X=X';
 %X=X(17000:17000+8191);
%X=a;
X =ecgdata(1:3600);
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

% for i=1:1024
%     for j=1:1024
%         xxx(i,j)=roundn(xx(i,j),-7);
%     end
% end

yy=xx*(X(1:lenlen)).';

% yyy=xx*(X(1:1024)).';
% nn=xx*X(1025:1025+1023).';
% uu=[yy.',nn.'];
