% x=textread('F:\ecgfilter.data','%f');
%  %x=textread('F:\nanyi\1470653911457\ecgfilter.data','%f');
% x=x';
%  x=x(10000:26000);
% points=15000;
% ecgdata=x(1:15000);
clear all
clc

%x=textread('F:\ecgfilter.data','%f');d
%mypath = 'F:\房颤\1477557426215\';
mypath = 'F:\AF\13\';
x=textread([mypath 'ecgfilter.data'],'%f');
y=textread([mypath 'ecgnotfilter.data'],'%f');
AddF=zeros(200,1);
AddE=zeros(300,1);
%c test
%x=x(1:4096);
x=[AddF', x',AddE'];

% x=x';
%x=x/6990.506666;
%x=textread('F:\ecgfilter.data','%f');
atr=textread([mypath 'ecgatr.data']);
ann=textread([mypath 'ecgatrann.data']);
% b=x(5000:end);
% figure
% plot(x);
% hold on;
% 
% for i=1:length(ann)
% if ann(i) == 30
%     plot(atr(i)+1,x(atr(i)+1), 'r^');    
%    ylabel(strcat('a   ',num2str(i)));  
%    subplot(level+1,2,2*(i)+2);  
%    plot(swd(i,:)); axis tight;grid on;  
%    ylabel(strcat('d   ',num2str(i)));  
%end  
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
  signal=PVE;
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
%画出原图及小波系数  
%figure(12);  
%subplot(level,1,1); plot(real(ecgdata(1:points)),'b'); grid on;axis tight;  
%title('ECG信号及其在j=1,2,3,4尺度下的小波系数');  
%for i=1:level  
%    subplot(level+1,1,i+1);  
%    plot(swd(i,:),'b'); axis tight;grid on;  
%    ylabel(strcat('d   ',num2str(i)));  
%end  
  
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
  
%画出各尺度下极值点  
%figure(13);  
%for i=1:level  
%    subplot(level,1,i);  
%    plot(wpeak(i,:)); axis tight;grid on;  
%ylabel(strcat('j=   ',num2str(i)));  
%end  
%subplot(4,1,1);  
%title('ECG信号在j=1,2,3,4尺度下的小波系数的模极大值点');  
  
interva2=zeros(1,points);  
intervaqs=zeros(1,points);  
Mj1=wpeak(1,:);  
Mj3=wpeak(3,:);  
Mj4=wpeak(4,:);  
%画出尺度3极值点  
%figure(14);  
%plot (Mj3);  
%title('尺度3下小波系数的模极大值点');  
  
posi=Mj3.*(Mj3>0);  
%求正极大值的平均  
%thposi=(max(posi(1:floor(points/4)))+max(posi(floor(points/4):2*floor(points/4)))+max(posi(2*floor(points/4):3*floor(points/4)))+max(posi(3*floor(points/4):4*floor(points/4))))/4;  
thposi=min([max(posi(1:floor(points/4))),max(posi(floor(points/4):2*floor(points/4))),max(posi(2*floor(points/4):3*floor(points/4))),max(posi(3*floor(points/4):4*floor(points/4)))]);
posi=(posi>thposi/3);  
nega=Mj3.*(Mj3<0);  
%求负极大值的平均
%thnega=(min(nega(1:floor(points/4)))+min(nega(floor(points/4):2*floor(points/4)))+min(nega(2*floor(points/4):3*floor(points/4)))+min(nega(3*floor(points/4):4*floor(points/4))))/4; 
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
countQ=zeros(1,1);  
countS=zeros(1,1);  
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
%求出QRS波起点  
       kqs=mark1-5;  
       markq=0;  
     while (kqs>1)&&( markq< 3)  
         if Mj1(kqs)~=0  
            markq=markq+1;  
         end  
         kqs= kqs -1;  
     end  
  countQ(kqs)=-1;  
%求出QRS波终点    
  kqs=mark1-5;  
  marks=0;  
  while (kqs<points)&&( marks<3)  
      if Mj1(kqs)~=0  
         marks=marks+1;  
      end  
      kqs= kqs+1;  
  end  
  countS(kqs)=-1;  
  i=i+60;  
  j=j+1;  
  Rnum=Rnum+1;  
 end  
i=i+1;  
end 

% %负向R波检测
% nloca2=find(diff==2);  
% %负极大值点  
% ninterva2(loca(nloca2(1:length(nloca2))))=interva(loca(nloca2(1:length(nloca2))));  
% %正极大值点  
% ninterva2(loca(nloca2(1:length(nloca2))+1))=interva(loca(nloca2(1:length(nloca2))+1));  
% %intervaqs(1:points-10)=interva2(11:points);  
% ncountR=zeros(1,1);  
% % countQ=zeros(1,1);  
% % countS=zeros(1,1);  
% mark1=0;  
% i=1;  
% j=1;  
% nRnum=0;  
% %*************************求正负极值对过零，即R波峰值，并检测出QRS波起点及终点*******************%  
% while i<length(ninterva2)  
%     if ninterva2(i)==1  
%        mark1=i;  
%        i=i+1;  
%        while(i<points&&interva2(i)==0)  
%           i=i+1;  
%        end  
%        mark2=i;  
% %求极大值对的过零点  
%       % mark3= floor((abs(Mj3(mark2))*mark1+mark2*abs(Mj3(mark1)))/(abs(Mj3(mark2))+abs(Mj3(mark1))));  
% %R波极大值点  
%        R_result(j)=mark1-5;%经验值 
%        countR(mark1-5)=1;  
%   i=i+60;  
%   j=j+1;  
%   nRnum=nRnum+1;  
%  end  
% i=i+1;  
% end  



  
  
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
       % Mjadjust=wpeak(3,R(i-1)+80:R(i)-80);  
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
        mark6=0;  
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
        mark8=0;  
        mark9=0;  
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
  % temp=cc(i)-31+find(x(cc(i)-31:cc(i)+17)==max(x(cc(i)-31:cc(i)+17)))-1;
   %temp=cc(i)-31+
   
   Uselect = x(cc(i)-31:cc(i)+17);
   jida = find(diff(sign(diff(Uselect)))==-2)+1;
   Mselect = Uselect(jida);
   if (length(jida) == 0)
       temp = cc(i)-31+find(Uselect == max(Uselect))-1;
       
   elseif (length(jida) == 1)
       temp = cc(i)-31+jida-1;
   else
       aloc = find(Mselect == max(Mselect));
       if length(aloc) > 1
           bloc = max(aloc);
       else
           bloc = aloc;
       end
       temp=cc(i)-31+jida(bloc)-1;
   end
   
    Rpeak(i)=min(temp);
end

RR = diff(Rpeak);
%dRR=diff(RR);
WindowSize = 32;
con = zeros(1,length(length(RR)-WindowSize));
for ss = 3:length(RR)-WindowSize
RR_use = RR(ss:WindowSize+ss);
dRR_use = diff(RR_use);
%dRR_use=dRR(1:WindowSize);
%%划分网格  25ms的网格   12.8*12.8
RR_useX = zeros(1,WindowSize);
RR_useY = zeros(1,WindowSize);
for i = 1:WindowSize
    %RR_useX(i) = ceil(RR_use(i)/12.8);
    RR_useX(i) = round(RR_use(i)/12.8);
    %RR_useY(i) = ceil(dRR_use(i)/12.8);
    RR_useY(i) = round(dRR_use(i)/12.8);
end
%遍历数组，寻找在同一个方格的点
RR_index = zeros(1,32);
j = 0;
for i = 1:WindowSize
    if i == 1
        %RR_index(i)=j;
        j = j + 1;
    else
        for k = 1:i-1
            if RR_useX(k) == RR_useX(i)&&RR_useY(k) == RR_useY(i)
                %RR_index(i)=RR_index(k);
                flag = 1;
                break;
            else
                flag = 0;
            end
        end
         if k == i - 1&&flag == 0
%             RR_index(i)=j;
             j = j + 1;
         end
    end
end
con(ss) = j;
end



