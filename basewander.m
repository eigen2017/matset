 x=textread('F:\nanyi\1470653911457\ecgfilter.data','%f');
x=x';
 x=x(10000:26000);
 points=15000;
ecgdata=x(1:15000+217);
Rpeak=[431,918,1402,1828,2238,2712,3140,3481,4069,4453,4847,5293,5728,6169,6948,7375,7868,8336,8847,9315,9638,10192,10629,10902,11464,11866,12234,12696,13114,13558,14035,14517];
RRmean=mean(diff(Rpeak));
T=zeros(31,354);
for i=1:31
    T(i,:)=ecgdata(Rpeak(i)-136:Rpeak(i)+217);
end
c=sum(T,2);
temp=0;
sum=0;

%归一化    
for i=1:31
    for j=1:354
        temp=(T(i,j)-c(i)/354);
        sum=0;
        for k=1:354
            sum=sum+(T(i,j)-c(i)/354)^2;
        end
        T(i,j)=temp/sum;
    end
end
order=10;

x=1:1:354;
%系数矩阵
coef=zeros(31,order+1);

for i=1:31
    coef(i,:)=polyfit(x,T(i,:),order);
end
for i=1:31
    coef(i,order+2)=ecgdata(Rpeak(i));
end


S=clusterdata(coef,2);      
            
        
        


