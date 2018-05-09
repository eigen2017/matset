% open and close operation
clear;  
x=textread('E:\ECG\数据\temp_data.txt','%f');
x=x';
x0=x; 
 
k=[0,2/3,4/3,2,4/3,2/3,0]; 
k=k*2000;
n=length(x); 
 
y1=zeros(1,n); 
y2=zeros(1,n); 
% Open,Close 
y3=zeros(1,n); 
y4=zeros(1,n); 
 
y5=zeros(1,n); 
y6=zeros(1,n); 
 
yy3=zeros(1,n); 
yy4=zeros(1,n); 
 
y=zeros(1,7); 
max=0; 
min=0; 
j=1; 
%膨胀 
for i=7:n-0     
    max=-10000; 
    for kl=1:7 
        %y(kl)=x(j+kl-1)+k(kl); 
        y(kl)=x(j+kl-1)+k(kl); 
        if(y(kl)>max) 
            max=y(kl); 
        end 
    end 
    y1(j)=max; 
    j=j+1; 
    %j=j+5; 
end 
%腐蚀 
j=1; 
for i=7:n-0     
    min=100000; 
    for kl=1:7 
        y(kl)=x(j+kl-1)-k(kl); 
        if(y(kl)<min) 
            min=y(kl); 
        end 
    end 
    y2(j)=min; 
    j=j+1; 
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%开运算 ,先腐蚀，再膨胀 
x=y2; 
j=1; 
for i=7:n-0      
    max=-10000; 
    for kl=1:7 
        y(kl)=x(j+kl-1)+k(kl); 
        if(y(kl)>max) 
            max=y(kl); 
        end 
    end 
    y3(j)=max; 
    j=j+1; 
end 
 
%闭运算：先膨胀，再腐蚀 
x=y1; 
j=1; 
for i=7:n-0         
    min=10000; 
    for kl=1:7 
        y(kl)=x(j+kl-1)-k(kl); 
        if(y(kl)<min) 
            min=y(kl); 
        end 
    end 
    y4(j)=min; 
    j=j+1; 
end 
 
% (x open s) Close s 
 
x=y3; 
j=1; 
for i=7:n-0      
    max=-10000; 
    for kl=1:7 
        y(kl)=x(j+kl-1)+k(kl); 
        if(y(kl)>max) 
            max=y(kl); 
        end 
    end 
    yy3(j)=max; 
    j=j+1; 
end 
 
x=yy3; 
j=1; 
for i=7:n-0          
    min=10000; 
    for kl=1:7 
        y(kl)=x(j+kl-1)-k(kl); 
        if(y(kl)<min) 
            min=y(kl); 
        end 
    end 
    y5(j)=min; 
    j=j+1; 
end 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% (x close s) open s 
x=y4; 
j=1; 
for i=7:n-0      
    min=10000; 
    for kl=1:7 
        y(kl)=x(j+kl-1)-k(kl); 
        if(y(kl)<min) 
            min=y(kl); 
        end 
    end 
    yy4(j)=min; 
    j=j+1; 
end 
 
x=yy4; 
j=1; 
for i=7:n-0      
    max=-10000; 
    for kl=1:7 
        y(kl)=x(j+kl-1)+k(kl); 
        if(y(kl)>max) 
            max=y(kl); 
        end 
    end 
    y6(j)=max; 
    j=j+1; 
end 
 
 
y7=(y5+y6)/2; 
 
% PVE(A) = A-(A o B) . B 
y8=x0-y5; 
 
subplot(2,1,1); 
plot(x0); 
title('initial signal');
 
%subplot(3,1,2); 
%plot(y7); 

subplot(212)
plot(y8)
title('denoised signal')

fid = fopen('E:\ECG\数据\temp_data_2.txt','w');
fprintf(fid,'%d\n',y8);    % X 为要写入的数组
 fclose(fid);
