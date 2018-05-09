close all;
clear;
% load ekg.mat;   %����ecg�ź�
% [map,r,delay]=pan_tompkin(ecg,fs,0);    % ����pan_tomkin�㷨�ҵ�R��
fs=512;
r=[1034,1561,2111,2762,3413,4002,4619,5242,5814,6450,7050,7548,8043,8578,9223,9791,10308,10966,11630,12247,12861,13473];
[a,l]=size(r);
for i=2:l;
    t(i-1)=r(i)-r(i-1);   %���R-R���ʱ��ֵ����ʹHRV
end

x=r(2:end);
y=interp1(x,t,r(2):1:r(end),'spline');  %���ò�ֵ�������ԭecg�źŵĲ�����fs����Ϻ���
plot(y);hold on,
scatter(r(2:end)-r(2),t(1:l-1));

N=length(y);
N1=20;    %ȷ��Ƶ����ķ�Χ ÿһ��ԪΪfs/N=0.06Hz
AF=fft(y);
AF=abs(AF);   %�������Ҷ�任��ķ�Ƶ����
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
