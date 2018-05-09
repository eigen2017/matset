%% Example Title
% Summary of example objective

%% Example Title
% denoise via swt
a=textread('C:\Users\pc20150817\Desktop\data1451456141261raw.txt','%f');
a=a';
a=a(1:4096);
[swa,swd]=swt(a,5,'db4');
for i=1:5
    t_s(i)=median(abs(swd(i,:)))/0.6745;
end
for i=1:5
    r(i)=t_s(i)*sqrt(2*log(4096))/log(i+1);
end
for i=1:5
    for j=1:4096
        if abs(swd(i,j))>=r(i)
                                 %Intermediate variables
            swd(i,j)=sign(swd(i,j))*(abs(swd(i,j)-r(i)));
        else
            swd(i,j)=0;
        end
    end
end
X = iswt(swa,swd,'db4');
subplot(211);
plot(a);
title('initial data');
subplot(212)
plot(X);
title('denoised data');
sum=0;
for i=1:4096
    temp=(a(i)-X(i))^2;
    sum=sum+temp;
end
mse=sum/4096;
temp_1=0;
temp_2=0;
temp_3=0;
for i=1:4096
    aa=a(i)^2;
    temp_1=temp_1+aa;
end
snr=10*log10(temp_1/sum);
    
    
