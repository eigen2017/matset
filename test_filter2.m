cc=textread('E:\jakie.txt','%f');
%cc=sig;
cc=cc';
%cc=cc(1:4096);
% pwelch(cc,[],[],[],512);
b = fir1(20,0.05/256,'high',kaiser(21,4));%高通滤波器去基线漂移
y=filter(b,1,cc);
     
% lpFilt = designfilt('lowpassfir', 'FilterOrder', 30, 'PassbandFrequency', 37, 'StopbandFrequency', 40, 'SampleRate', 250, 'DesignMethod', 'ls');%低通滤波器去除肌电干扰的高频部分 
d  = fdesign.notch('N,F0,Q,Ap',2,50/256,10,1);%陷波滤波器去工频
Hd = design(d);
y_temp = filter(Hd,y);

%y11=filter(b2,a2,y);
% y_final = filter(lpFilt,y);
subplot(211)
%  plot(tm,cc');
plot(cc);
subplot(212)
%  plot(tm,y_temp');
plot(y_temp);
fid = fopen('E:\ECG\数据\temp_data_2.txt','w');
fprintf(fid,'%d\n',y_temp);    % X 为要写入的数组
fclose(fid);
