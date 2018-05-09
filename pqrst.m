%xx = load('F:\AF\�ٴ�����\ECG�Ϸ�ҽԺ0001-0057\ECG\data\ecg1504833568391.ecg');
[tm,sig]=rdsamp('E:\PHY\48abnormal\113',[],4096);

%yy = resample(xx,360,512);
level=4;    
sr=360; 
points = 4096;
ecgdata=sig(:,1)';
ecgdata = rmbaseline( ecgdata); %ȥ������Ư��
%ecgdata2 = Denoise_st(ecgdata1); %ȥ���������
swa=zeros(4,points);%�洢��ò��Ϣ
swd=zeros(4,points);%�洢ϸ����Ϣ
signal=ecgdata(0*points+1:1*points); %ȡ���ź�
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
%С��ϵ���Ĵ���0�ĵ�
posw=swd.*(swd>0);
%б�ʴ���0
pdw=((posw(:,1:points-1)-posw(:,2:points))<0);
%������ֵ��
pddw(:,2:points-1)=((pdw(:,1:points-2)-pdw(:,2:points-1))>0);
%С��ϵ��С��0�ĵ�
negw=swd.*(swd<0);
ndw=((negw(:,1:points-1)-negw(:,2:points))>0);
%������ֵ��
nddw(:,2:points-1)=((ndw(:,1:points-2)-ndw(:,2:points-1))>0);
%������
ddw=pddw|nddw;
ddw(:,1)=1;
ddw(:,points)=1;
%�����ֵ���ֵ,��������0
wpeak=ddw.*swd;
wpeak(:,1)=wpeak(:,1)+1e-10;
wpeak(:,points)=wpeak(:,points)+1e-10;

%�������߶��¼�ֵ��
%figure(13);
%for i=1:level
%    subplot(level,1,i);
%    plot(wpeak(i,:)); axis tight;grid on;
%ylabel(strcat('j=   ',num2str(i)));
%end
%subplot(4,1,1);
%title('ECG�ź���j=1,2,3,4�߶��µ�С��ϵ����ģ����ֵ��');

interva2=zeros(1,points);  
intervaqs=zeros(1,points);  
Mj1=wpeak(1,:); 
Mj2 = wpeak(2,:);
Mj3 = wpeak(3,:);  
Mj4 = wpeak(4,:);  
%�����߶�3��ֵ��  
%figure(14);  
%plot (Mj3);  
%title('�߶�3��С��ϵ����ģ����ֵ��');  
  
posi=Mj3.*(Mj3>0);  
%��������ֵ��ƽ��  
%thposi=(max(posi(1:floor(points/4)))+max(posi(floor(points/4):2*floor(points/4)))+max(posi(2*floor(points/4):3*floor(points/4)))+max(posi(3*floor(points/4):4*floor(points/4))))/4;  
thposi=min([max(posi(1:floor(points/4))),max(posi(floor(points/4):2*floor(points/4))),max(posi(2*floor(points/4):3*floor(points/4))),max(posi(3*floor(points/4):4*floor(points/4)))]);
posi=(posi>thposi/3);  
nega=Mj3.*(Mj3<0);  
%�󸺼���ֵ��ƽ��
%thnega=(min(nega(1:floor(points/4)))+min(nega(floor(points/4):2*floor(points/4)))+min(nega(2*floor(points/4):3*floor(points/4)))+min(nega(3*floor(points/4):4*floor(points/4))))/4; 
thnega=max([min(nega(1:floor(points/4))),min(nega(floor(points/4):2*floor(points/4))),min(nega(2*floor(points/4):3*floor(points/4))),min(nega(3*floor(points/4):4*floor(points/4)))]);
nega=-1*(nega<thnega/4);  
%�ҳ���0��  
interva=posi+nega;  
loca=find(interva);  
for i=1:length(loca)-1  
    if abs(loca(i)-loca(i+1))<80  
       Diff(i)=interva(loca(i))-interva(loca(i+1));  
    else  
       Diff(i)=0;  
    end  
end  
%�ҳ���ֵ��  
%����R�����
loca2=find(Diff==-2);  
%������ֵ��  
interva2(loca(loca2(1:length(loca2))))=interva(loca(loca2(1:length(loca2))));  
%������ֵ��  
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
%*************************��������ֵ�Թ��㣬��R����ֵ��������QRS����㼰�յ�*******************%  
while i<points  
    if interva2(i)==-1  
       mark1=i;  
       i=i+1;  
       while(i<points&&interva2(i)==0)  
          i=i+1;  
       end  
       mark2=i;  
%�󼫴�ֵ�ԵĹ����  
       mark3= floor((abs(Mj3(mark2))*mark1+mark2*abs(Mj3(mark1)))/(abs(Mj3(mark2))+abs(Mj3(mark1))));  
%R������ֵ��  
       R_result(j)=mark1-5;%����ֵ 
       countR(mark1-5)=1;  
%���QRS�����  
       kqs=mark1-5;  
       markq=0;  
     while (kqs>1)&&( markq< 3)  
         if Mj1(kqs)~=0  
            markq=markq+1;  
         end  
         kqs= kqs -1;  
     end  
  countQ(kqs)=-1;  
%���QRS���յ�    
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



%************************ɾ�����㣬����©���**************************%  
num2=1;  
while(num2~=0)  
   num2=0;  
%j=3,�����  
   R=find(countR);  
%�������  
   R_R=R(2:length(R))-R(1:length(R)-1);  
   RRmean=mean(R_R);  
%������R�����С��0.4RRmeanʱ,ȥ��ֵС��R��  
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
%������R���������1.6RRmeanʱ,��С��ֵ,����һ�μ��R��  
for i=2:length(R)  
    if (R(i)-R(i-1))>1.6*RRmean  
       % Mjadjust=wpeak(3,R(i-1)+80:R(i)-80);  
         Mjadjust=Mj3(R(i-1)+80:R(i)-80);  
        points2=(R(i)-80)-(R(i-1)+80)+1;  
%��������ֵ��  
        adjustposi=Mjadjust.*(Mjadjust>0);  
        adjustposi=(adjustposi>thposi/4);  
%�󸺼���ֵ��  
        adjustnega=Mjadjust.*(Mjadjust<0);  
        adjustnega=-1*(adjustnega<thnega/5);  
%������  
        interva4=adjustposi+adjustnega;  
%�ҳ���0��  
        loca3=find(interva4);  
        diff2=interva4(loca3(1:length(loca3)-1))-interva4(loca3(2:length(loca3)));  
%����м���ֵ��,�ҳ�����ֵ��  
%�����©
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
    %�����©
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
%j=3,�����  
   R=find(countR);  
%�������  
   R_R=R(2:length(R))-R(1:length(R)-1);  
   RRmean=mean(R_R);  
%������R�����С��0.4RRmeanʱ,ȥ��ֵС��R��  
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
%���˫��R��
NUMofDoublepeaks = 0;
for i = 2:length(Rpeak)
    temparray = signal(Rpeak(i)-40:Rpeak(i)+40);
    [values,locations] = findpeaks(temparray);
    for j = 1:length(values)
        if values(j)~=max(values) && values(j)>0.5*max(values)
            disp('����˫��R��')
            Doublepeaks(NUMofDoublepeaks+1) = Rpeak(i)-40 + locations(j);
            NUMofDoublepeaks = NUMofDoublepeaks + 1;
            continue;
        end
    end
    clear temparray
end


NcountR = zeros(1,1);

%����R�����   %���˫��R��
nloca2=find(Diff==2);  
%������ֵ��  
ninterva2(loca(nloca2(1:length(nloca2))))=interva(loca(nloca2(1:length(nloca2))));  
%������ֵ��  
ninterva2(loca(nloca2(1:length(nloca2))+1))=interva(loca(nloca2(1:length(nloca2))+1));  
%intervaqs(1:points-10)=interva2(11:points);  
ncountR=zeros(1,1);  

mark1=0;  
i=1;  
j=1;  
nRnum=0;  
%*************************��������ֵ�Թ��㣬��R����ֵ��������QRS����㼰�յ�*******************%  
while i<length(ninterva2)  
    if ninterva2(i)==1  
       mark1=i;  
       i=i+1;  
       while(i<points&&interva2(i)==0)  
          i=i+1;  
       end  
       mark2=i;  
%�󼫴�ֵ�ԵĹ����  
      % mark3= floor((abs(Mj3(mark2))*mark1+mark2*abs(Mj3(mark1)))/(abs(Mj3(mark2))+abs(Mj3(mark1))));  
%R������ֵ��  
       
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
                disp('����˫��R��')
            end
        end
    end
end
   
% ��λQ�㣬��Q�����
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
%��λS�㣬��S���յ�

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

%��λT��
for i = 1:length(Send)
    temparray = signal(Send(i):Qbeign(i+1));
    temposi = temparray.*(temparray>0);
    [maxValueposi,maxLocations] = max(temposi);
    temneg = temparray.*(temparray<0);
    [minValueneg,minLocations] = min(temneg);
    if maxValueposi > abs(minValueneg)
        disp('����T��')
        Tlocation(i) = maxLocations(length(maxLocations)) + Send(i) -1;
    else
        disp('����T��')
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

%��λP��



    










            























%����ԭͼ�������y���
%%%%%%%%%%%%%%%%%%%%%%%%%%�_ʼ��PT����
%��R����ǰ�Ĳ��üӴ����������СΪ100��Ȼ����㴰���ڼ���С�ľ���
%figure(20);
%plot(Mj4);
%title('j=4 ϸ��ϵ��'); hold on
%%%%%%%����ֱ����j=4ʱ��R������
Mj4posi=Mj4.*(Mj4>0);
%��������ֵ��ƽ��
Mj4thposi=(max(Mj4posi(1:round(points/4)))+max(Mj4posi(round(points/4):2*round(points/4)))+max(Mj4posi(2*round(points/4):3*round(points/4)))+max(Mj4posi(3*round(points/4):4*round(points/4))))/4;
Mj4posi=(Mj4posi>Mj4thposi/3);
Mj4nega=Mj4.*(Mj4<0);
%�󸺼���ֵ��ƽ��
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
%�ҳ���ֵ��
Mj4local2=find(Mj4diff==-2);
%������ֵ��
Mj4interva2(Mj4local(Mj4local2(1:length(Mj4local2))))=Mj4interval(Mj4local(Mj4local2(1:length(Mj4local2))));
%������ֵ��
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
%�󼫴�ֵ�ԵĹ����,��R4�м�ֵ֮���������R�㡣

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




%%%%%%%%%%%%%%%%%%%%%%%%�ҵ�MJ4��QRS�������ȱ�ٶ�R���©���y�������y���Ȳ�ȥϸ���ˡ�
%%%%%
%%%%%�Գ߶�4��R���y�����ã���Ҫ�Ľ��ĵط�
%%%%%%
%figure(200);
%plot(Mj4);
%title('j=4');
%hold on;
%plot(Mj4countR,'r');
%plot(Mj4countQ,'g');
%plot(Mj4countS,'g');

%%%%%%%%%%%%%%%%%%%%%%%%%%Mj4������ҵ�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%P����y%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Rlocated Qlocated ���ڳ߶�4�µ�����
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
        %���ڵļ���Сֵ
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
    if mark4==0&&flag==0 %����û��P������R������1/3����ֵ-1
        mark4=round(Rlocated(i)-RRinteral/3);
        countP(mark4-20)=-1;
    end
end
 %plot(countPMj4,'g');       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%T����y%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
        %%%%%�����ڵļ���Сֵ
        [windowMax,maxindex]=max(Mj4(windowBegin:windowEnd));
        [windowMin,minindex]=min(Mj4(windowBegin:windowEnd));
        if minindex < maxindex &&((maxindex-minindex)<windowSizeQ)&&windowMax>0.1&&windowMin<-0.1
            flag=1;
            mark5=round((maxindex+minindex)/2+windowBegin);
            countTMj4(mark5)=1;
            countT(mark5-20)=1;%�ҵ�T����ֵ��
            %%%%%ȷ��T����ʼ����յ�
            countTbegin(windowBegin+minindex-20)=-1;
            countTend(windowBegin+maxindex-20)=-1;
        end
        if flag==1
            break;
        end
    end
    if mark5==0 %����û��T������R���� ���1/3����ֵ-2
        mark5=round(Rlocated(i)+ RRinteral/3);
        countT(mark5)=-2;
    end
end
%plot(countTMj4,'g');
%hold off;        
figure(1);
%plot(ecgdata(0*points+1:1*points)),grid on,axis tight,axis([1,points,-2,5]);
plot(ecgdata(0*points+1:1*points))
title('ECG�źŵĸ������μ�y');
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

