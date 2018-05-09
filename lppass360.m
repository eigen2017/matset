%% Example Title
% 对信号去除基线漂移的操作
%思路

x=b;
 x=x(10000:end)';
%cc=-x;
% pwelch(cc,[],[],[],512);
% cc=cc/6.990506667;
%cc=cc(5000:end);
%x=cc;
%x=x(1:153218);
x_max=max(x);
x_min=min(x);
x_am=0.5*(x_max-x_min);
%x_am=100;
k1=[0,2/3,4/3,2,4/3,2/3,0];
k1=k1*x_am;
for i=1:35
   % k2(i)=2*(i-1)/38;
   k2(i)=2*x_am;
end
for i=36:70
  %  k2(i)=2-2*(i-39)/38;
  k2(i)=2*x_am;
end 
k2=k2;
ll=length(x);
x1=open_operation(x,k1,ll,7);
x2=closed_operation(x1,k1,ll,7);
x3=closed_operation(x,k1,ll,7);
x4=open_operation(x3,k1,ll,7);
x_1=0.5*(x2+x4);

x5=open_operation(x_1,k2,ll,70);
x6=closed_operation(x5,k2,ll,70);
x7=closed_operation(x_1,k2,ll,70);
x8=open_operation(x7,k2,ll,70);
x_2=0.5*(x6+x8);

x_3=x_1-x_2;


%subplot(211);
%hold on
%plot(x-1500)
%title('data');
%subplot(212);
% hold on
plot(x_3);
%title('filtered data');

