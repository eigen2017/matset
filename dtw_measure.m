%% Example Title
% % extract QRSTP
% x=textread('F:\ecgfilter.data','%f');
%  %x=textread('F:\nanyi\1470653911457\ecgfilter.data','%f');
% x=x';
%  x=x(10000:26000);
% points=15000;
% ecgdata=x(1:15000);
clear all
clc

%x=textread('F:\ecgfilter.data','%f');d
mypath = 'F:\nanyi4\1026\谭素红\';
x=textread([mypath 'ecgfilter.data'],'%f');
AddF=zeros(200,1);
AddE=zeros(300,1);
%c test
%x=x(1:4096);
x=[AddF', x',AddE'];
moban=x(3897:4196);
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
    temp=cc(i)-31+find(x(cc(i)-31:cc(i)+17)==max(x(cc(i)-31:cc(i)+17)))-1;
    Rpeak(i)=min(temp);
end
    
%画出原图及标出检测结果  
 R_R=Rpeak(2:length(Rpeak))-Rpeak(1:length(Rpeak)-1);  
 RRmean=mean(R_R);
scale=floor(RRmean/20);
Q_point=zeros(length(Rpeak),1);

%定Q点
for i=1:length(Rpeak)
    wtarr=Mj3(Rpeak(i)-scale:Rpeak(i));
    wtarr1=diff(wtarr);
    wtarr2=sign(wtarr1);
    wtarr3=diff(wtarr2);
    wssss= find(wtarr3 == -2);
    wssss=max(wssss);
    if isempty(wssss)
        wssss=scale+5;
    end
    
%   wssss = find(diff(sign(diff(wtarr))) == -2);
 Q_point(i)=Rpeak(i)-scale+wssss-3;
 %clear wtarr;
end

%定S点
S_point=zeros(length(Rpeak),1);
for i=1:length(Rpeak)
    mtarr=Mj3(Rpeak(i):Rpeak(i)+scale);
    mssss = find(diff(sign(diff(mtarr))) == -2);
    mssss=min(mssss);
    if isempty(mssss)
        mssss=10;
    end
    S_point(i)=Rpeak(i)+mssss-5;
end
x=x/6990.506666;
%计算QRS波群的面积Aqrs
Aqrs=zeros(length(Rpeak),1);
for i=1:length(Rpeak)
    Aqrs(i)=polyarea(Q_point(i):S_point(i),abs(x(Q_point(i):S_point(i))));
end
%计算QRS 波的肥胖指数Fqrs
Fqrs=zeros(length(Rpeak),1);
for i=1:length(Rpeak)
    Fqrs(i)=Aqrs(i)/x(Rpeak(i));
end
%计算QRS的尖峰粗顿指数AGqrs
AGqrs=zeros(length(Rpeak),1);
for i=1:length(Rpeak)
    AGqrs(i)=x(Rpeak(i))/min(abs(x(Rpeak(i))-x(Rpeak(i)-1)),abs(x(Rpeak(i))-x(Rpeak(i)+1)));
end
Amax=max(Aqrs);
Amin=min(Aqrs);
Amean=mean(Aqrs);
cnt=1;
for i=1:length(Aqrs)
    if Aqrs(i)<2*Amean
        Cqrs(cnt)=Aqrs(i); 
        cnt=cnt+1;
    end
end
[t,n]=hist(Cqrs,8);
%b=filter2(fspecial('average',2),t); 

% 
% [t1,n1]=hist(Aqrs,8);
% [t2,n2]=hist(AGqrs,8);
% [t3,n3]=hist(Fqrs,8);
% T=[t1 t2 t3];
% N=[n1 n2 n3];
  

%粗略分成4类
%各个数据段的形成：以R点为中心，向前向后搜索400ms，后600ms
Esample=cell(1,length(Rpeak)-2);
ie=zeros(1,300);
x=[x ie];
for i=2:length(Rpeak)-1
    Esample{i-1}=x(Rpeak(i)-floor((Rpeak(i)-Rpeak(i-1))/3):Rpeak(i)+floor((Rpeak(i+1)-Rpeak(i))/2));
end
%模板匹配分类(轮廓限围+累计差值)
%轮廓限围Kl=0.3
Template=cell(1,14);
ClassMark=zeros(1,length(Rpeak)-2);
CF=1;
 for i=1:length(Rpeak)-2
    tmp=Esample{i};
    %if isempty(Template)
    if CF==1    %第一次进入
        Template{1}=Esample{1};
        ClassMark(i)=1;
        CF=0;
        continue; 
    end
    %for j=1:length(Esample{i})
        EtyTem=cellfun('isempty',Template);
        count=0;
        %计算现有模板个数count
        for k=1:length(EtyTem)
            if EtyTem(k)==0
               count=count+1;
            end
        end
        %逐个模板比较
        for m=1:count
%             Dsum=0;
%             for nn=1:length(Template{m})
%                 if tmp(nn)>Template{m}(nn)+0.3
%                    Dsum=Dsum+ tmp(nn)-Template{m}(nn)-0.3;
%                 end
%                 if tmp(nn)<Template{m}(nn)-0.3
%                     Dsum=Dsum+Template{m}(nn)-0.3-tmp(nn);
%                 end
%                 
%             end
%             max(Template{m})-min(Template{m})+max(tmp)-min(tmp)
            for nn=2:length(Template{m})-1
                Template_D(nn-1)=(Template{m}(nn)-Template{m}(nn-1)+(Template{m}(nn+1)-Template{m}(nn-1))/2)/2;
            end
            for nn=2:length(tmp)-1
                tmp_D(nn-1)=(tmp(nn)-tmp(nn-1)+(tmp(nn+1)-tmp(nn-1))/2)/2;
            end
            Dsum=dtw(Template_D,tmp_D);
            clear  Template_D 
            clear  tmp_D
             if Dsum<0.0054;   %阈值设定
                    ClassMark(i)=m;
                    %模板更新
%                     for pp=1:length(Template{m})
%                         Template{m}(pp)=(Template{m}(pp)*13+tmp(pp))/14;
%                     end
                    break;
             else
            if m==count
                %建立新的模板
                %当模板库满时，
                if count==14                                                                       
                    %找到匹配次数最少的模板
                    Table=tabulate(ClassMark(1:i-1));
                    Times=Table(:,2);
                    loc=find(Times==min(Times));
                    loc=min(loc);
                    Template{loc}=[];
                    ClassMark(i)=loc;
                    Template{loc}=tmp;
                end
                if count<14
                    %建立新的模板
                    Template{count+1}=tmp;
                    ClassMark(i)=count+1;
                end
            end
            
             end
        end
        
 %   end
 end
%kkk=max(ClassMark);
%计算曲线
Ftable=tabulate(ClassMark);
cSMC=zeros(1,length(ClassMark));
%cSMC=1/Ftable(:,3);
for i=1:length(ClassMark)
 if ClassMark(i)==1
     cSMC(i)=1/Ftable(1,2); 
 end
 if ClassMark(i)==2
     cSMC(i)=1/Ftable(2,2);
 end
 if ClassMark(i)==3
     cSMC(i)=1/Ftable(3,2);
 end
 if ClassMark(i)==4
     cSMC(i)=1/Ftable(4,2);
 end
 if ClassMark(i)==5
     cSMC(i)=1/Ftable(5,2);
 end
 if ClassMark(i)==6
     cSMC(i)=1/Ftable(6,2);
 end
 if ClassMark(i)==7
     cSMC(i)=1/Ftable(7,2);
 end
 if ClassMark(i)==8
     cSMC(i)=1/Ftable(8,2);
 end
  if ClassMark(i)==9
     cSMC(i)=1/Ftable(9,2);
  end
  if ClassMark(i)==10
     cSMC(i)=1/Ftable(10,2);
  end
  if ClassMark(i)==11
     cSMC(i)=1/Ftable(11,2);
  end
  if ClassMark(i)==12
     cSMC(i)=1/Ftable(12,2);
 end
  if ClassMark(i)==13
     cSMC(i)=1/Ftable(13,2);
  end
  if ClassMark(i)==14
     cSMC(i)=1/Ftable(14,2);
 end
     
end

%plot(Ftable(3,:))
%cSMC=1/Ftable(:,3);
for i=1:length(cSMC)
    [ml,nl]=size(Ftable);
    if ml<=2
       break;
    end
    if cSMC(i)>=1/min(Ftable(:,2))||cSMC(i)>=1/4;
        cSMC(i)=1;
    else
%      cSMC<1/min(Ftable(:,2))
        cSMC(i)=0;
    end
end
%计算凌乱指数MI
%3个积分SUM1   SUM2  SUM3
% len=length(10:length(Rpeak)-9);
% SUM1=zeros(1,len);
% SUM2=zeros(1,len);
% SUM3=zeros(1,len);
% for i=10:length(Rpeak)-9
%     
%     SUM1(i-9)=sum(cSMC(i-9:i));
%     SUM2(i-9)=sum(cSMC(i-4:i+5));
%     SUM3(i-9)=sum(cSMC(i:i+9));
% end
% MI=zeros(1,length(Rpeak));
% for i=10:length(Rpeak)-9
%     if cSMC(i)==0&&SUM2(i-9)>5
%         MI(i)=1;
%     else
%         MI(i)=0;
%     end
%     if cSMC(i)==1&&(SUM1(i-9)>5||SUM2(i-9)>5||SUM3(i-9)>5)
%         MI(i)=1;
%     else
%         MI(i)=0;
%     end
% end



x=x*6990.506666;
 A=zeros(1,length(Rpeak));
B=zeros(1,length(Rpeak));
for i=2:length(Rpeak)-1
    for j=Rpeak(i):-1:Rpeak(i-1)
        if x(j)<0
            A(i)=j;
            break;
             else
            if j==Rpeak(i-1)
                A(i)=Rpeak(i-1)+1;
            end
        end
    end
    for j=Rpeak(i):1:Rpeak(i+1)
        if x(j)<0
            B(i)=j;
            break;
        else
            if j==Rpeak(i+1)
                B(i)=Rpeak(i+1)-1;
            end
        end
    end
end
%将R波周围置零
for i=2:length(Rpeak)-1
    for j=A(i):B(i)
        x(j)=0;
    end
end
T=zeros(1,length(Rpeak)-1);
P=zeros(1,length(Rpeak)-1);
for i=2:length(Rpeak)-1
    pe=floor((Rpeak(i)-Rpeak(i-1))/3);
    te=floor((Rpeak(i+1)-Rpeak(i))/3*2);
    [p,n]=max(x(Rpeak(i)-pe:Rpeak(i)));
    [t,m]=max(x(Rpeak(i):Rpeak(i)+te));
    P(i)=Rpeak(i)-pe+n-1;       %problem
    T(i)=Rpeak(i)+m-1;
end

%下采样

for i=1:floor(length(x)/7)
    y(i)=x(1+(i-1)*7);
end
%平稳小波变换，二次B样条，分解两层，取cd2
clear swd   swa signal  
signal=y;
for i=1:length(y)-3  
   swa(1,i+3)=1/4*signal(i+3-2^0*0)+3/4*signal(i+3-2^0*1)+3/4*signal(i+3-2^0*2)+1/4*signal(i+3-2^0*3);  
   swd(1,i+3)=-1/4*signal(i+3-2^0*0)-3/4*signal(i+3-2^0*1)+3/4*signal(i+3-2^0*2)+1/4*signal(i+3-2^0*3);  
end  
j=2;  
while j<=3  
   for i=1:length(y)-24  
     swa(j,i+24)=1/4*swa(j-1,i+24-2^(j-1)*0)+3/4*swa(j-1,i+24-2^(j-1)*1)+3/4*swa(j-1,i+24-2^(j-1)*2)+1/4*swa(j-1,i+24-2^(j-1)*3);  
     swd(j,i+24)=-1/4*swa(j-1,i+24-2^(j-1)*0)-3/4*swa(j-1,i+24-2^(j-1)*1)+3/4*swa(j-1,i+24-2^(j-1)*2)+1/4*swa(j-1,i+24-2^(j-1)*3);  
   end  
   j=j+1;  
end 







%%%%%%%%%%%%%%%%%%%%%%%%%%开始求PT波段  
%对R波点前的波用加窗法，窗口大小为100，然后计算窗口内极大极小的距离  
%figure(20);  
%plot(Mj4);  
%title('j=4 细节系数'); hold on  
 
Mj4posi=Mj4.*(Mj4>0);  
%求正极大值的平均  
Mj4thposi=(max(Mj4posi(1:floor(points/4)))+max(Mj4posi(floor(points/4):2*floor(points/4)))+max(Mj4posi(2*floor(points/4):3*floor(points/4)))+max(Mj4posi(3*floor(points/4):4*floor(points/4))))/4;  
Mj4posi=(Mj4posi>Mj4thposi/3);  
Mj4nega=Mj4.*(Mj4<0);  
%求负极大值的平均  
Mj4thnega=(min(Mj4nega(1:floor(points/4)))+min(Mj4nega(floor(points/4):2*floor(points/4)))+min(Mj4nega(2*floor(points/4):3*floor(points/4)))+min(Mj4nega(3*floor(points/4):4*floor(points/4))))/4;  
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
       while(i<points&&Mj4interva2(i)==0)  
          i=i+1;  
       end  
       mark2=i;  
%求极大值对的过零点,在R4中极值之间过零点就是R点。  
       mark3= floor((abs(Mj4(mark2))*mark1+mark2*abs(Mj4(mark1)))/(abs(Mj4(mark2))+abs(Mj4(mark1))));  
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
%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%  
%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%P波检测%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
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
            mark4=floor((maxindex+minindex)/2+windowBegin);  
            countPMj4(mark4)=1;  
            countP(mark4-20)=1;  
            countPbegin(windowBegin+minindex-20)=-1;  
            countPend(windowBegin+maxindex-20)=-1;   
        end  
        if flag==1  
            break;   
        end  
    end  
    if mark4==0&&flag==0 %如果没有P波，在R波左间隔1/3处赋值-1  
        mark4=floor(Rlocated(i)-RRinteral/3);  
        countP(mark4-20)=-1;  
    end  
end  
 %plot(countPMj4,'g');         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%T波检测%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
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
        %%%%%求窗口内的极大极小值  
        [windowMax,maxindex]=max(Mj4(windowBegin:windowEnd));  
        [windowMin,minindex]=min(Mj4(windowBegin:windowEnd));  
        if minindex < maxindex &&((maxindex-minindex)<windowSizeQ)&&windowMax>0.1&&windowMin<-0.1  
            flag=1;  
            mark5=floor((maxindex+minindex)/2+windowBegin);  
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
    if mark5==0 %如果没有T波，在R波右 间隔1/3处赋值-2  
        mark5=floor(Rlocated(i)+ RRinteral/3);  
        countT(mark5)=-2;  
    end  
end  
%plot(countTMj4,'g');  
%hold off;          
%figure(4);  
plot(x);
% ccccc=find(countR);
% eeee=find(countQ);
% ssss=find(countS);
% text(ccccc,ecgdata(ccccc),'o','color','g');
% text(eeee,ecgdata(eeee),'o','color','b');
% text(ssss,ecgdata(ssss),'o','color','r');
pppp=find(countP==1);
tttt=find(countT==1);
hold on
plot(pppp,x(pppp),'*');
hold on
plot(tttt,x(tttt),'o');

%plot(ecgdata(0*points+1:1*points)),grid on,axis tight,axis([1,points,-2,5]);  
%title('ECG信号的各波波段检测');  
%hold on  
%plot(countR,'r');  
%plot(countQ,'k');  
%plot(countS,'k');  
% for i=1:Rnum  
 %   if R_result(i)==0;  
  %      break  
   % end  
    %plot(R_result(i),ecgdata(R_result(i)),'bo','MarkerSize',10,'MarkerEdgeColor','g');  
%end  
%plot(countP,'r');  
%plot(countT,'r');  
%plot(countPbegin,'k');  
%plot(countPend,'k');  
%plot(countTbegin,'k');  
%plot(countTend,'k');  
