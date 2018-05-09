cc=textread('E:\ECG_DATA\ecgraw4_28_newDevice\num_7_device\eshine.data','%f');
cc=cc(2000:10000);
cc=cc';
% pwelch(cc,[],[],[],512);
cc=cc/6.990506667;
% cc=cc*5;
subplot(211)
plot(cc);


[b,a]=cheby1(2,1,0.8/256,'high');%高通滤波器去基线漂移
lpFilt = designfilt('lowpassfir', 'FilterOrder', 30, 'PassbandFrequency', 37, 'StopbandFrequency', 40, 'SampleRate', 512, 'DesignMethod', 'ls');%低通滤波器去除肌电干扰的高频部分 

uu=filter(b,a,cc);
tt= filter(lpFilt,uu);
%tt=tt(1+500:160+500);
tt=tt/max(tt);
subplot(212);

 plot(tt)
 N=200;%窗口宽度为180个点，约为350ms
 Nwindow=N;
 L=zeros(Nwindow,1);
 M=zeros(Nwindow,1);
 S=zeros(Nwindow,1);
%  flag=zeros(Nwindow,1);
 for j=402:N+400
     L(1)=L(1)+(tt(j)-tt(j-2))^2;
 end
 for i=402:N+400
     L(i-400)=L(i-401)+(tt(i+N/2)-tt(i+N/2-2))^2-(tt(i-N/2)-tt(i-N/2+2))^2;
 end
 kk=1;
 for i=401:N+400
     M(i-400)=mean(tt(i-N/2:i+N/2-1));
%      S(i-400)=std(tt(i-N/2:i+N/2-1),1,2);
      S(i-400)=std(tt(i-N/2:i+N/2-1));
     if (L(i-400)-M(i-400)>S(i-400))
         flag(kk)=i;
         ggg(kk)=tt(i);
         kk=kk+1;
     end
 end
 yyyyy=L-M;
 [ma,ax]=max(ggg);
 fin=flag(ax);
 
 
     
     
     
 