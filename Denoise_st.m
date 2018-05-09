function [ cleanData ] = denoise_st( noiseData )
%UNTITLED10 此处显示有关此函数的摘要
%   对输入的数据noiseData进行去噪，得到输出数据cleanData
floor=10;
[swa,swd]=swt(noiseData, floor,'coif2');

for i=1:floor
    t_s(i)=median(abs(swd(i,:)))/0.6745;
end
for i=1:floor
    if i>5
        factor=0.25;
    else  
        factor=1;
    end
    r(i)=factor*t_s(i)*sqrt(2*log(8192))/log(i+1);
end

for i=1:floor
    for j=1:4096
        if abs(swd(i,j))>=r(i)
            swd_temp=swd(i,j);
            temp_s=swd_temp^2;
            tem_minus=abs(swd_temp)-r(i);
            minus_sq=tem_minus^2;
            r_s=r(i)^2;                              %Intermediate variables
            swd(i,j)=sign(swd_temp)*sqrt(temp_s-r_s/2.5^minus_sq);
        else
            swd(i,j)=0;
        end
    end
end



cleanData = iswt(swa,swd,'coif2');

end

