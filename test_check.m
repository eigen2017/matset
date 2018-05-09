lpFilt = designfilt('lowpassfir', 'FilterOrder', 50, 'PassbandFrequency', 43, 'StopbandFrequency', 48, 'SampleRate', 512, 'DesignMethod', 'ls','PassbandWeight',50);
d  = fdesign.notch('N,F0,Q,Ap',2,50/256,10,1);%陷波滤波器去工频
Hd = design(d);

% fb=(1/6).*[1,1,1,1,1,1];
% fa=[1,0,0,0,0,0];%阶数待解决
fb=(1/5).*[1,1,1,1,1];
fa=[1,0,0,0,0];%阶数待解决
% xb=[ 0.8652338721254,   -8.652338721254,    38.93552424564,    -103.828064655,   181.6991131463,   -218.0389357756,    181.6991131463,    -103.828064655,    38.93552424564,   -8.652338721254,   0.8652338721254];
% xa=[  1,   -9.940481048271,    44.46662193912,    -117.875615127, 205.0643004928,   -244.6281017909,    202.6596073502,   -115.1273124399,   42.9206248442,   -9.482375961559,   0.9427317412757];
% fs=512;
% N=2000; %总采样长度
% t=0:1/fs:N/fs; %时间的变化范
% 
% %C=0.4484;
% C=1;
% t=t(1:N);
% x1=C*sin(2*pi*10*t);
input_check=c;
% input_check=textread('F:\f1.data','%f');
% input_check=input_check/6990.506667;

aa=filter(haha1,input_check);

%bb=filter(xb,xa,input_check);
%plot(bb-aa);
aa=filter( lpFilt,aa);

aa=filter(Hd,aa);
aa=filter(Hd,aa);
aa=filter(Hd,aa);

% 
%aa=filter(fb,fa,aa);
%aa=filter(fb,fa,aa);
aa=filter( lpFilt,aa);


plot(input_check)
hold on
plot(aa)