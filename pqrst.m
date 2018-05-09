%xx = load('F:\AF\临床数据\ECG南方医院0001-0057\ECG\data\ecg1504833568391.ecg');
[tm,sig]=rdsamp('E:\PHY\48abnormal\113',[],4096);

%yy = resample(xx,360,512);
level=4;    
sr=360; 
points = 4096;
ecgdata=sig(:,1)';
ecgdata = rmbaseline( ecgdata); %去除基线漂移
%ecgdata2 = Denoise_st(ecgdata1); %去除肌电干扰
swa=zeros(4,points);%存储概貌信息
swd=zeros(4,points);%存储细节信息
signal=ecgdata(0*points+1:1*points); %取点信号
signal = smooth(signal);
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
%求出极值点的值,其它点置0
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
Mj2 = wpeak(2,:);
Mj3 = wpeak(3,:);  
Mj4 = wpeak(4,:);  
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
    temp=cc(i)-31+find(signal(cc(i)-31:cc(i)+17)==max(signal(cc(i)-31:cc(i)+17)))-1;
    Rpeak(i)=min(temp);
end
%检测双峰R波
NUMofDoublepeaks = 0;
for i = 2:length(Rpeak)
    temparray = signal(Rpeak(i)-40:Rpeak(i)+40);
    [values,locations] = findpeaks(temparray);
    for j = 1:length(values)
        if values(j)~=max(values) && values(j)>0.5*max(values)
            disp('存在双峰R波')
            Doublepeaks(NUMofDoublepeaks+1) = Rpeak(i)-40 + locations(j);
            NUMofDoublepeaks = NUMofDoublepeaks + 1;
            continue;
        end
    end
    clear temparray
end


NcountR = zeros(1,1);

%负向R波检测   %检测双相R波
nloca2=find(Diff==2);  
%负极大值点  
ninterva2(loca(nloca2(1:length(nloca2))))=interva(loca(nloca2(1:length(nloca2))));  
%正极大值点  
ninterva2(loca(nloca2(1:length(nloca2))+1))=interva(loca(nloca2(1:length(nloca2))+1));  
%intervaqs(1:points-10)=interva2(11:points);  
ncountR=zeros(1,1);  

mark1=0;  
i=1;  
j=1;  
nRnum=0;  
%*************************求正负极值对过零，即R波峰值，并检测出QRS波起点及终点*******************%  
while i<length(ninterva2)  
    if ninterva2(i)==1  
       mark1=i;  
       i=i+1;  
       while(i<points&&interva2(i)==0)  
          i=i+1;  
       end  
       mark2=i;  
%求极大值对的过零点  
      % mark3= floor((abs(Mj3(mark2))*mark1+mark2*abs(Mj3(mark1)))/(abs(Mj3(mark2))+abs(Mj3(mark1))));  
%R波极大值点  
       
       NcountR(mark1-5)=1;  
  i=i+60;  
  j=j+1;  
  nRnum=nRnum+1;  
   end  
i=i+1;  
end  

ncc=find(NcountR);
if length(ncc)>1
    Rpeak(1)=ncc(1);
    for i=2:length(ncc)
        temp=ncc(i)-31+find(signal(ncc(i)-31:ncc(i)+17)==min(signal(ncc(i)-31:ncc(i)+17)))-1;
        NRpeak(i-1)=min(temp);
    end
    for t = 1:length(NRpeak)
        ploc = findminDistance(NRpeak(t),Rpeak);
        if abs(ploc - NRpeak(t) ) < 200
            if abs(abs(signal(ploc))-abs(signal(NRpeak(t))))<0.5*max(abs(signal(ploc)),abs(signal(NRpeak(t))))
                disp('存在双相R波')
            end
        end
    end
end
   
% 定位Q点，及Q波起点
for i = 2:length(Rpeak)
    RRprevious = Rpeak(i) - Rpeak(i-1);
    distances = zeros(1,1);
    for j = floor(Rpeak(i)-0.25*RRprevious):Rpeak(i)
        distances(j-floor(Rpeak(i)-0.25*RRprevious)+1) = dist([floor(Rpeak(i)-0.25*RRprevious),signal(floor(Rpeak(i)-0.25*RRprevious))],[Rpeak(i),signal(Rpeak(i))],[j,signal(j)]);
    end
    [maxValue,location] = max(distances);
    Qlocatins(i-1) = location(length(location)) +  floor(Rpeak(i)-0.25*RRprevious) -1;
    %Qbeign(i-1) =  Qlocatins(i-1)-10 + findmaxslope(signal( Qlocatins(i-1)-10: Qlocatins(i-1)));
    Qbeign(i-1) =  Qlocatins(i-1)-10 + findminDistancetoZero(signal( Qlocatins(i-1)-10: Qlocatins(i-1)))-1;
    clear distances
    
end
%定位S点，及S波终点

for i = 2:length(Rpeak)-1
    RRprevious = Rpeak(i+1) - Rpeak(i);
    distances = zeros(1,1);
    for j = Rpeak(i):floor(Rpeak(i)+0.25*RRprevious)
        distances(j- Rpeak(i)+1) = dist([Rpeak(i),signal(Rpeak(i))],[floor(Rpeak(i)+0.25*RRprevious),signal(floor(Rpeak(i)+0.25*RRprevious))],[j,signal(j)]);
    end
    [maxValue,location] = max(distances);
    Slocatins(i-1) = location(length(location)) +  Rpeak(i) -1;
    
    Send(i-1) =  Slocatins(i-1) + findminDistancetoZero(signal( Slocatins(i-1): Slocatins(i-1)+25))-1;
    clear distances
end

%定位T波
for i = 1:length(Send)
    temparray = signal(Send(i):Qbeign(i+1));
    temposi = temparray.*(temparray>0);
    [maxValueposi,maxLocations] = max(temposi);
    temneg = temparray.*(temparray<0);
    [minValueneg,minLocations] = min(temneg);
    if maxValueposi > abs(minValueneg)
        disp('正向T波')
        Tlocation(i) = maxLocations(length(maxLocations)) + Send(i) -1;
    else
        disp('反向T波')
        Tlocation(i) = minLocations(length(minLocations)) + Send(i) -1;
    end
    clear temparray
    clear temposi
    clear maxValueposi
    clear maxLocations
    clear temneg
    clear minValueneg
    clear minLocations
end

%定位P波



    










            























%画出原图及标出检測结果
%%%%%%%%%%%%%%%%%%%%%%%%%%開始求PT波段
%对R波点前的波用加窗法。窗体大小为100。然后计算窗体内极大极小的距离
%figure(20);
%plot(Mj4);
%title('j=4 细节系数'); hold on
%%%%%%%还是直接求j=4时的R过零点吧
Mj4posi=Mj4.*(Mj4>0);
%求正极大值的平均
Mj4thposi=(max(Mj4posi(1:round(points/4)))+max(Mj4posi(round(points/4):2*round(points/4)))+max(Mj4posi(2*round(points/4):3*round(points/4)))+max(Mj4posi(3*round(points/4):4*round(points/4))))/4;
Mj4posi=(Mj4posi>Mj4thposi/3);
Mj4nega=Mj4.*(Mj4<0);
%求负极大值的平均
Mj4thnega=(min(Mj4nega(1:round(points/4)))+min(Mj4nega(round(points/4):2*round(points/4)))+min(Mj4nega(2*round(points/4):3*round(points/4)))+min(Mj4nega(3*round(points/4):4*round(points/4))))/4;
Mj4nega=-1*(Mj4nega<Mj4thnega/4);
Mj4interval=Mj4posi+Mj4nega;
Mj4local=find(Mj4interval);
Mj4interva2=zeros(1,points);
for i=1:length(Mj4local)-1
    if abs(Mj4local(i)-Mj4local(i+1))<80
       Mj4diff(i)=Mj4interval(Mj4local(i))-Mj4interval(Mj4local(i+1));
    else
       Mj4diff(i)=0;
    end
end
%找出极值对
Mj4local2=find(Mj4diff==-2);
%负极大值点
Mj4interva2(Mj4local(Mj4local2(1:length(Mj4local2))))=Mj4interval(Mj4local(Mj4local2(1:length(Mj4local2))));
%正极大值点
Mj4interva2(Mj4local(Mj4local2(1:length(Mj4local2))+1))=Mj4interval(Mj4local(Mj4local2(1:length(Mj4local2))+1));
mark1=0;
mark2=0;
mark3=0;
Mj4countR=zeros(1,1);
Mj4countQ=zeros(1,1);
Mj4countS=zeros(1,1);
flag=0;
while i<points
    if Mj4interva2(i)==-1
       mark1=i;
       i=i+1;
       while(i<points&Mj4interva2(i)==0)
          i=i+1;
       end
       mark2=i;
%求极大值对的过零点,在R4中极值之间过零点就是R点。

       mark3= round((abs(Mj4(mark2))*mark1+mark2*abs(Mj4(mark1)))/(abs(Mj4(mark2))+abs(Mj4(mark1))));
       Mj4countR(mark3)=1;
       Mj4countQ(mark1)=-1;
       Mj4countS(mark2)=-1;
       flag=1;
    end
    if flag==1
        i=i+200;
        flag=0;
    else
        i=i+1;
    end
end




%%%%%%%%%%%%%%%%%%%%%%%%找到MJ4的QRS点后，这里缺少对R点的漏点检測和冗余检測。先不去细究了。
%%%%%
%%%%%对尺度4下R点检測不够好，须要改进的地方
%%%%%%
%figure(200);
%plot(Mj4);
%title('j=4');
%hold on;
%plot(Mj4countR,'r');
%plot(Mj4countQ,'g');
%plot(Mj4countS,'g');

%%%%%%%%%%%%%%%%%%%%%%%%%%Mj4过零点找到%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Rlocated=find(Mj4countR);
Qlocated=find(Mj4countQ);
Slocated=find(Mj4countS);
countPMj4=zeros(1,1);
countTMj4=zeros(1,1);
countP=zeros(1,1);
countPbegin=zeros(1,1);
countPend=zeros(1,1);
countT=zeros(1,1);
countTbegin = zeros(1,1);
countTend = zeros(1,1);
windowSize=100;
%%%%%%%%%%%%%%%%%%%%%%%P波检測%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Rlocated Qlocated 是在尺度4下的坐标
for i=2:length(Rlocated)
    flag=0;
    mark4=0;
    RRinteral=Rlocated(i)-Rlocated(i-1);
    for j=1:5:(RRinteral*2/3)
       % windowEnd=Rlocated(i)-30-j;
       windowEnd=Qlocated(i)-j;
        windowBegin=windowEnd-windowSize;
        if windowBegin<Rlocated(i-1)+RRinteral/3
            break;
        end
        %求窗内的极大极小值
        %windowposi=Mj4.*(Mj4>0);
        %windowthposi=(max(Mj4(windowBegin:windowBegin+windowSize/2))+max(Mj4(windowBegin+windowSize/2+1:windowEnd)))/2;
        [windowMax,maxindex]=max(Mj4(windowBegin:windowEnd));
        [windowMin,minindex]=min(Mj4(windowBegin:windowEnd));
        if minindex < maxindex &&((maxindex-minindex)<windowSize*2/3)&&windowMax>0.01&&windowMin<-0.1
            flag=1;
            mark4=round((maxindex+minindex)/2+windowBegin);
            countPMj4(mark4)=1;
            countP(mark4-20)=1;
            countPbegin(windowBegin+minindex-20)=-1;
            countPend(windowBegin+maxindex-20)=-1;
        end
        if flag==1
            break; 
        end
    end
    if mark4==0&&flag==0 %假设没有P波，在R波左间隔1/3处赋值-1
        mark4=round(Rlocated(i)-RRinteral/3);
        countP(mark4-20)=-1;
    end
end
 %plot(countPMj4,'g');       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%T波检測%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear windowBegin windowEnd maxindex minindex windowMax windowMin mark4 RRinteral;

windowSizeQ=100;
for i=1:length(Rlocated)-1;
    flag=0;
    mark5=0;
    RRinteral=Rlocated(i+1)-Rlocated(i);
    for j=1:5:(RRinteral*2/3)
       % windowBegin=Rlocated(i)+30+j;
       windowBegin=Slocated(i)+j;
        windowEnd  =windowBegin+windowSizeQ;
        if windowEnd >Rlocated(i+1)-RRinteral/4
            break;
        end
        %%%%%求窗体内的极大极小值
        [windowMax,maxindex]=max(Mj4(windowBegin:windowEnd));
        [windowMin,minindex]=min(Mj4(windowBegin:windowEnd));
        if minindex < maxindex &&((maxindex-minindex)<windowSizeQ)&&windowMax>0.1&&windowMin<-0.1
            flag=1;
            mark5=round((maxindex+minindex)/2+windowBegin);
            countTMj4(mark5)=1;
            countT(mark5-20)=1;%找到T波峰值点
            %%%%%确定T波起始点和终点
            countTbegin(windowBegin+minindex-20)=-1;
            countTend(windowBegin+maxindex-20)=-1;
        end
        if flag==1
            break;
        end
    end
    if mark5==0 %假设没有T波。在R波右 间隔1/3处赋值-2
        mark5=round(Rlocated(i)+ RRinteral/3);
        countT(mark5)=-2;
    end
end
%plot(countTMj4,'g');
%hold off;        
figure(1);
%plot(ecgdata(0*points+1:1*points)),grid on,axis tight,axis([1,points,-2,5]);
plot(ecgdata(0*points+1:1*points))
title('ECG信号的各波波段检測');
hold on
plot(countR,'r');
plot(countQ,'k');
plot(countS,'k');

for i=1:Rnum
    if R_result(i)==0;
        break
    end
    plot(R_result(i),ecgdata(R_result(i)),'bo','MarkerSize',10,'MarkerEdgeColor','g');
end
plot(countP,'r');
plot(countT,'r');
plot(countPbegin,'k');
plot(countPend,'k');
plot(countTbegin,'k');
plot(countTend,'k');

