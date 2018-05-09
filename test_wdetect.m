clear all


global sePos;
global amPos;


% [tm,sig]=rdsamp('D:\201m',1);
% sig=-sig;
% 
% sig=sig(1:10000);
% sig=filter(lppass360,sig);  %40HZ 低通滤波
%sig=textread('F:\心电数据\ecgnotfilter.data','%f');

% sig=x_3;
%sig=filter(haha,sig);
%sig=textread('F:\print\pitt\1473402026747\ecgfilter.data','%f');
sig=textread('F:\nanyi4\1024\刘燕南\ecgfilter.data','%f');
%sig=textread('F:\ecgfilter.data','%f');
 sig=sig(5000:end);
%sig=sig(1:4096);
%A=max(sig(1:512))-1000;
A=500;
B=min(sig(1:512));
C=max(sig(1:512));

%sePos=[1,12,23,34,45];
sePos=[1,10,30,70,80];
%amPos=[0,B,A,B,0];
amPos=[0,A,B,0,C];

j=1;

for i=1:length(sig)
    [ q1,s1,P,Q,R,S,T,suc] = Wdetect( sig(i) );
    
    if(suc == 1)
    aP(j)= P;
    aQ(j)= Q;
    aR(j)= R;
    aS(j)= S;
    aT(j)= T;
    aQ1(j)=q1;
    aS1(j)=s1;
    j =j+1; 
    
    end
end

% 
plot(sig);
hold on;
% 
% plot(aP,sig(aP),'o');
% hold on
%plot(aQ1,sig(aQ1),'*');
% hold on
plot(aR,sig(aR),'o');
%hold on
%plot(aS1,sig(aS1),'*');
% hold on
% plot(aT,sig(aT),'b+');


