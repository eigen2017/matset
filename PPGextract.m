%% Example Title
xx = nn;
AddF=zeros(200,1);
AddE=zeros(300,1);

x=[AddF', xx',AddE'];

B=1000*ones(1,100);
PE=x-open_operation(x,B,length(x),50);
VE=x-closed_operation(x,B,length(x),50);
PVE=PE+VE;
PE=PVE-open_operation(PVE,B,length(PVE),50);
VE=PVE-closed_operation(PVE,B,length(PVE),50);
PVE=PE+VE;
PE=PVE-open_operation(PVE,B,length(PVE),50);
points=length(x);
swa=zeros(4,points);        %存储概貌信息  
swd=zeros(4,points);        %存储细节信息  
%计算小波系数和尺度系数  
%低通滤波器 1/4 3/4 3/4 1/4  
%高通滤波器 -1/4 -3/4 3/4 1/4  
%二进样条小波  
  signal=x;
  level=4;
for i=1:points-3  
   swa(1,i+3)=1/4*signal(i+3-2^0*0)+3/4*signal(i+3-2^0*1)+3/4*signal(i+3-2^0*2)+1/4*signal(i+3-2^0*3);  
   swd(1,i+3)=-1/4*signal(i+3-2^0*0)-3/4*signal(i+3-2^0*1)+3/4*signal(i+3-2^0*2)+1/4*signal(i+3-2^0*3);  
end  
j=2;  
while j<=level  
   for i=1:points-24  
     swa(j,i+24)=1/4*swa(j-1,i+24-2^(j-1)*0)+3/4*swa(j-1,i+24-2^(j-1)*1)+3/4*swa(j-1,i+24-2^(j-1)*2)+1/4*swa(j-1,i+24-2^(j-1)*3);  
     swd(j,i+24)=-1/4*swa(j-1,i+24-2^(j-1)*0)-3/4*swa(j-1,i+24-2^(j-1)*1)+3/4*swa(j-1,i+24-2^(j-1)*2)+1/4*swa(j-1,i+24-2^(j-1)*3);  
   end  
   j=j+1;  
end 

  
%**************************************求正负极大值对**********************%  
ddw=zeros(size(swd));  
pddw=ddw;  
nddw=ddw;  
%小波系数的大于0的点  
posw=swd.*(swd>0);  
%斜率大于0  
pdw=((posw(:,1:points-1)-posw(:,2:points))<0);  
%正极大值点  
pddw(:,2:points-1)=((pdw(:,1:points-2)-pdw(:,2:points-1))>0);  
%小波系数小于0的点  
negw=swd.*(swd<0);  
ndw=((negw(:,1:points-1)-negw(:,2:points))>0);  
%负极大值点  
nddw(:,2:points-1)=((ndw(:,1:points-2)-ndw(:,2:points-1))>0);  
%或运算  
ddw=pddw|nddw;  
ddw(:,1)=1;  
ddw(:,points)=1;  
%求出极值点的值,其他点置0  
wpeak=ddw.*swd;  
wpeak(:,1)=wpeak(:,1)+1e-10;  
wpeak(:,points)=wpeak(:,points)+1e-10;  
  
interva2=zeros(1,points);  
intervaqs=zeros(1,points);  
Mj1=wpeak(1,:);  
Mj3=wpeak(3,:);  
Mj4=wpeak(4,:);  
  
posi=Mj3.*(Mj3>0);  
%求正极大值的平均  
  
thposi=min([max(posi(1:floor(points/4))),max(posi(floor(points/4):2*floor(points/4))),max(posi(2*floor(points/4):3*floor(points/4))),max(posi(3*floor(points/4):4*floor(points/4)))]);
posi=(posi>thposi/3);  
nega=Mj3.*(Mj3<0);  
%求负极大值的平均
thnega=max([min(nega(1:floor(points/4))),min(nega(floor(points/4):2*floor(points/4))),min(nega(2*floor(points/4):3*floor(points/4))),min(nega(3*floor(points/4):4*floor(points/4)))]);
nega=-1*(nega<thnega/4);  
%找出非0点  
interva=posi+nega;  
loca=find(interva);  
for i=1:length(loca)-1  
    if abs(loca(i)-loca(i+1))<80  
       Diff(i)=interva(loca(i))-interva(loca(i+1));  
    else  
       Diff(i)=0;  
    end  
end  
%找出极值对  
%正向R波检测
loca2=find(Diff==-2);  
%负极大值点  
interva2(loca(loca2(1:length(loca2))))=interva(loca(loca2(1:length(loca2))));  
%正极大值点  
interva2(loca(loca2(1:length(loca2))+1))=interva(loca(loca2(1:length(loca2))+1));  
intervaqs(1:points-10)=interva2(11:points);  
countR=zeros(1,1);  

mark1=0;  
mark2=0;  
mark3=0;  
i=1;  
j=1;  
Rnum=0;  
%*************************求正负极值对过零，即R波峰值，并检测出QRS波起点及终点*******************%  
while i<points  
    if interva2(i)==-1  
       mark1=i;  
       i=i+1;  
       while(i<points&&interva2(i)==0)  
          i=i+1;  
       end  
       mark2=i;  
%求极大值对的过零点  
       mark3= floor((abs(Mj3(mark2))*mark1+mark2*abs(Mj3(mark1)))/(abs(Mj3(mark2))+abs(Mj3(mark1))));  
%R波极大值点  
       R_result(j)=mark1-5;%经验值 
       countR(mark1-5)=1;  
    end
 
  i=i+1;  
end 
  
%************************删除多检点，补偿漏检点**************************%  
num2=1;  
while(num2~=0)  
   num2=0;  
%j=3,过零点  
   R=find(countR);  
%过零点间隔  
   R_R=R(2:length(R))-R(1:length(R)-1);  
   RRmean=mean(R_R);  
%当两个R波间隔小于0.4RRmean时,去掉值小的R波  
for i=2:length(R)  
    if (R(i)-R(i-1))<=0.4*RRmean  
        num2=num2+1;  
        if signal(R(i))>signal(R(i-1))  
            countR(R(i-1))=0;  
        else  
            countR(R(i))=0;  
        end  
    end  
end  
end  
  
num1=2;  
while(num1>0)  
   num1=num1-1;  
   R=find(countR);  
   R_R=R(2:length(R))-R(1:length(R)-1);  
   RRmean=mean(R_R);  
%当发现R波间隔大于1.6RRmean时,减小阈值,在这一段检测R波  
for i=2:length(R)  
    if (R(i)-R(i-1))>1.6*RRmean  
         Mjadjust=Mj3(R(i-1)+80:R(i)-80);  
        points2=(R(i)-80)-(R(i-1)+80)+1;  
%求正极大值点  
        adjustposi=Mjadjust.*(Mjadjust>0);  
        adjustposi=(adjustposi>thposi/4);  
%求负极大值点  
        adjustnega=Mjadjust.*(Mjadjust<0);  
        adjustnega=-1*(adjustnega<thnega/5);  
%或运算  
        interva4=adjustposi+adjustnega;  
%找出非0点  
        loca3=find(interva4);  
        diff2=interva4(loca3(1:length(loca3)-1))-interva4(loca3(2:length(loca3)));  
%如果有极大值对,找出极大值对  
%负向捡漏
        loca4=find(diff2==2);  
        interva3=zeros(points2,1)';  
        for j=1:length(loca4)  
           interva3(loca3(loca4(j)))=interva4(loca3(loca4(j)));  
           interva3(loca3(loca4(j)+1))=interva4(loca3(loca4(j)+1));  
        end  
        mark4=0;  
        mark5=0;   
    while j<points2  
         if interva3(j)==1;  
            mark4=j;  
            j=j+1;  
            while(j<points2&&interva3(j)==0) 
                 j=j+1;  
            end  
            mark5=j;  
            countR(R(i-1)+80+mark4-5)=1;  
            j=j+60;  
         end  
         j=j+1;  
    end  
    %正向捡漏
    loca5=find(diff2==-2);  
        interva5=zeros(points2,1)';  
        for j=1:length(loca5)  
           interva5(loca3(loca5(j)))=interva4(loca3(loca5(j)));  
           interva5(loca3(loca5(j)+1))=interva4(loca3(loca5(j)+1));  
        end  
        mark7=0;   
    while j<points2  
         if interva5(j)==-1;  
            mark7=j;  
            j=j+1;  
            while(j<points2&&interva5(j)==0)  
                 j=j+1;  
            end  
          
            countR(R(i-1)+80+mark7-5)=1;  
            j=j+60;  
         end  
         j=j+1;  
    end  
    end  
 end  
end  
num2=1;  
while(num2~=0)  
   num2=0;  
%j=3,过零点  
   R=find(countR);  
%过零点间隔  
   R_R=R(2:length(R))-R(1:length(R)-1);  
   RRmean=mean(R_R);  
%当两个R波间隔小于0.4RRmean时,去掉值小的R波  
for i=2:length(R)  
    if (R(i)-R(i-1))<=0.4*RRmean  
        num2=num2+1;  
        if signal(R(i))>signal(R(i-1))  
            countR(R(i-1))=0;  
        else  
            countR(R(i))=0;  
        end  
    end  
end  
end
cc=find(countR);
Rpeak(1)=cc(1);
for i=2:length(cc)
    temp=cc(i)-31+find(x(cc(i)-31:cc(i)+17)==max(x(cc(i)-31:cc(i)+17)))-1;
    Rpeak(i)=min(temp);
end