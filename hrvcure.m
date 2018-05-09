close all;
clear;
% load ekg.mat;   %读入ecg信号
% [map,r,delay]=pan_tompkin(ecg,fs,0);    % 利用pan_tomkin算法找到R点
fs=512;
r=[1034,1561,2111,2762,3413,4002,4619,5242,5814,6450,7050,7548,8043,8578,9223,9791,10308,10966,11630,12247,12861,13473];
[a,l]=size(r);
for i=2:l;
    t(i-1)=r(i)-r(i-1);   %求出R-R间的时间值，即使HRV
end

x=r(2:end);
y=interp1(x,t,r(2):1:r(end),'spline');  %利用插值法求出以原ecg信号的采样率fs的拟合函数
plot(y);hold on,
scatter(r(2:end)-r(2),t(1:l-1));

N=length(y);
N1=20;    %确定频率轴的范围 每一单元为fs/N=0.06Hz
AF=fft(y);
AF=abs(AF);   %求出傅里叶变换后的幅频特性
f=(0:N1-1)*fs/N; 
figure,plot(f,AF(1:N1));  

% for i=1:79
%     noise(i,:)=part80(i,1:321)+randi([-5,5],1,321);
% end
% for i=1:79
%     for j=1:321
%         if noise(i,j)<=5
%             noise(i,j)=0;
%         end
%     end
% end
% noise(:,322)=ones(1,79);
