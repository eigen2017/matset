x=textread('E:\ECG\Êý¾Ý\temp_data_2.txt','%f');
x=x';
[swa,swd]=swt(x,12,'db2');
enery=zeros(1,12);
for i=1:12
    enery(i)=mean_enery(swd(i,:));
end

%y=fft(swd(1,:),4096);


M_corr=zeros(1,12);
for i=1:12
    aa=xcorr(x,swd(i,:));
    M_corr(i)=mean(abs(aa));
end
plot(M_corr);


    