cc=textread('E:\jakie.txt','%f');
%cc=sig;
cc=cc';
%cc=cc(1:4096);
% pwelch(cc,[],[],[],512);
b = fir1(20,0.05/256,'high',kaiser(21,4));%��ͨ�˲���ȥ����Ư��
y=filter(b,1,cc);
     
% lpFilt = designfilt('lowpassfir', 'FilterOrder', 30, 'PassbandFrequency', 37, 'StopbandFrequency', 40, 'SampleRate', 250, 'DesignMethod', 'ls');%��ͨ�˲���ȥ��������ŵĸ�Ƶ���� 
d  = fdesign.notch('N,F0,Q,Ap',2,50/256,10,1);%�ݲ��˲���ȥ��Ƶ
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
fid = fopen('E:\ECG\����\temp_data_2.txt','w');
fprintf(fid,'%d\n',y_temp);    % X ΪҪд�������
fclose(fid);
