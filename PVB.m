clear all
clc

%x=textread('F:\ecgfilter.data','%f');d
mypath = 'F:\各种异常QRS\各种异常QRS\室早\唐友民\';
x=textread([mypath 'ecgfilter.data'],'%f');
AddF=zeros(200,1);
AddE=zeros(300,1);
%c test
%x=x(1:4096);
x=[AddF', x',AddE'];
%moban=x(3897:4196);
%moban=[-215,-209,-202,-198,-195,-190,-185,-181,-177,-174,-171,-167,-162,-157,-150,-143,-135,-127,-119,-112,-107,-103,-101,-99,-98,-96,-94,-91,-87,-82,-76,-69,-62,-55,-47,-39,-30,-21,-13,-5,2,10,17,24,29,34,39,46,53,62,72,81,92,102,113,122,130,136,145,159,176,197,222,249,276,300,311,303,274,222,146,46,-76,-220,-377,-539,-702,-861,-1014,-1153,-1275,-1377,-1459,-1523,-1570,-1601,-1619,-1625,-1625,-1618,-1606,-1590,-1570,-1547,-1521,-1486,-1444,-1393,-1334,-1265,-1183,-1087,-976,-854,-722,-583,-439,-294,-157,-36,66,149,212,256,281,290,290,287,282,278,274,271,269,268,266,260,251,239,226,214,201,190,181,174,169,165,163,161,160,159,157,155,150,144,138,130,121,112,104,97,91,88,86,85,85,84,83,81,78,74,71,68,67,69,73,80,90,101,114,128,144,159,176,193,211,229,247,264,281,297,312,326,338,349,358,367,376,387,398,412,427,444,461,479,495,509,520,528,533,535,535,532,528,523,519,513,508,502,495,488,480,471,460,448,434,420,404,386,368,348,328,306,283,260,235,210,184,158,133,108,85,63,42,23,5,-11,-27,-43,-59,-75,-92,-109,-127,-145,-163,-180,-197,-214,-228,-241,-252,-261,-267,-272,-275,-277,-278,-277,-276,-275,-273,-270,-268,-264,-261,-258,-256,-253,-250,-247,-244,-241,-237,-232,-228,-222,-216,-209,-201,-192,-183,-174,-165,-157,-151,-145,-142,-140,-140,-142,-143,-145,-145,-145,-143,-141,-137,-133,-130,-126];

moban=[-210,-199,-188,-177,-166,-155,-145,-134,-123,-113,-103,-93,-83,-73,-64,-55,-46,-37,-29,-21,-14,-7,0,5,11,16,20,24,27,29,31,32,32,31,29,26,22,17,11,4,-3,-12,-22,-34,-46,-60,-75,-92,-109,-128,-148,-170,-192,-215,-240,-266,-292,-319,-348,-376,-406,-436,-466,-497,-527,-558,-589,-619,-650,-679,-709,-737,-765,-792,-818,-843,-867,-889,-910,-929,-947,-963,-977,-990,-1000,-1009,-1016,-1020,-1023,-1024,-1022,-1019,-1014,-1007,-998,-987,-975,-961,-946,-929,-910,-891,-870,-849,-826,-803,-779,-755,-730,-705,-679,-653,-628,-602,-577,-552,-527,-502,-478,-455,-432,-411,-390,-369,-350,-332,-315,-300,-285,-271,-259,-247,-237,-227,-219,-211,-205,-199,-193,-189,-184,-181,-177,-174,-172,-170,-169,-168,-167,-166,-166,-164,-162,-160,-155,-150,-142,-132,-119,-105,-88,-68,-46,-22,3,31,61,91,122,151,179,206,229,251,272,293,316,341,368,397,427,457,487,520,558,608,669,750,862,1014,1206,1419,1621,1788,1898,1945,1939,1877,1761,1592,1367,1098,813,540,300,101,-57,-195,-319,-425,-532,-644,-776,-957,-1182,-1446,-1744,-2054,-2376,-2703,-3014,-3292,-3509,-3656,-3731,-3738,-3682,-3559,-3371,-3121,-2819,-2487,-2156,-1842,-1556,-1299,-1054,-820,-605,-412,-258,-154,-92,-75,-93,-127,-176,-238,-306,-378,-446,-498,-533,-551,-549,-524,-475,-405,-324,-244,-168,-98,-38,10,47,76,105,142,185,236,291,349,410,473,532,582,624,660,690,717,739,757,771,783,795,809,823,840,858,880,906,936,970,1006,1044,1085,1129,1175,1224,1276,1330,1385,1443,1502,1562,1623,1684,1746,1808,1870,1933,1996,2058,2120,2181,2242,2301,2358,2414,2468,2519,2567,2613,2655,2694,2729,2760,2787,2810,2828,2842,2851,2854,2852,2844,2830,2810,2784,2752,2713,2668,2617,2560,2496,2426,2350,2268,2179,2085,1986,1882,1773,1659,1542,1421,1297,1171,1041,907,770,629,484,337,187,35,-116,-268,-420,-570,-718,-866,-1014,-1161,-1304,-1442,-1572,-1693,-1802,-1902,-1992,-2072,-2144,-2209,-2266,-2317,-2361,-2391,-2407,-2408,-2398,-2380,-2356,-2327,-2299,-2278,-2266,-2265,-2266,-2267,-2268,-2268,-2266,-2254,-2230,-2196,-2156,-2113,-2067,-2015,-1956,-1897,-1841,-1787,-1734,-1679,-1623,-1568,-1516,-1464,-1410,-1356,-1301,-1247,-1195,-1146,-1098,-1051,-1007,-964,-923,-883,-845,-807,-769,-733,-699,-665,-633,-603,-574,-546,-519,-493,-469,-446,-423,-402,-382,-362,-344,-327,-310,-294,-279,-264,-250,-237,-224,-211,-199,-187,-175,-164,-153,-142,-131,-121,-110,-100,-89,-78,-68,-57,-46,-35,-23,-12,0,11,22,35,47,59,71,84,96,108,120,132,144,156,168,180,191,202,213,224,235,245,255,265,274,284,293,301,309,317,325,333,340,346,353,359,365,371,377,383,388,393,399,404,409,414,419,424,428,433,438,442,446,451,455,458,462,466,469,472,475,478,480,482,484,486,487,488,488,489,488,488,487,485,483,481,478,475,472,468,464,459,454,449,444,438,431];
moban=moban+max(abs(moban))+1;
%模板的分段线性表示
 for nn=2:length(moban)-1
                moban_D(nn-1)=(moban(nn)-moban(nn-1)+(moban(nn+1)-moban(nn-1))/2)/2;
 end
    MOBAN(1)=moban(1);
    index=2;
for j=2:length(moban)-1
    if (moban(j)>moban(j-1)&&moban(j)>moban(j+1))
        if moban(j)/MOBAN(index-1)>0.25;
            MOBAN(index)=moban(j);
            index=index+1;
        end 
    else
     if (moban(j)<moban(j-1)&&moban(j)<moban(j+1))
        if MOBAN(index-1)/moban(j)>0.25;
            MOBAN(index)=moban(j);
            index=index+1;
        end 
     end
    end
end

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
Esample=cell(1,length(Rpeak)-2);
ie=zeros(1,300);
x=[x ie];
for i=2:length(Rpeak)-1
    Esample{i-1}=x(Rpeak(i)-floor((Rpeak(i)-Rpeak(i-1))/2):Rpeak(i)+floor((Rpeak(i+1)-Rpeak(i))/3*2));
end
for i=1:length(Rpeak)-2
    Esample{i}=Esample{i}+max(abs(Esample{i}))+1;
end
%待测数据的分段线性表示
PLR=cell(1,length(Rpeak)-2);
for i=1:length(Rpeak)-2
    PLR{i}(1)=Esample{i}(1);
    index=2;
for j=2:length(Esample{i})-1
    if (Esample{i}(j)>Esample{i}(j-1)&&Esample{i}(j)>Esample{i}(j+1))
        if Esample{i}(j)/PLR{i}(index-1)>0.25;
            PLR{i}(index)=Esample{i}(j);
            index=index+1;
        end
        
    else
     if (Esample{i}(j)<Esample{i}(j-1)&&Esample{i}(j)<Esample{i}(j+1))
        if PLR{i}(index-1)/Esample{i}(j)>0.25;
            PLR{i}(index)=Esample{i}(j);
            index=index+1;
        end
        
     end
    end
    
end
end

DSUM=zeros(1,length(Rpeak)-2);
DDSUM=zeros(1,length(Rpeak)-2);
Esample_D=cell(1,length(Rpeak)-2);
for i=1:length(Rpeak)-2
     for nn=2:length(Esample{i})-1
              Esample_D{i}(nn-1)=(Esample{i}(nn)-Esample{i}(nn-1)+(Esample{i}(nn+1)-Esample{i}(nn-1))/2)/2;
     end
end
for i=1:length(Rpeak)-2
 %  DSUM(i)= dtw(PLR{i}/max(PLR{i}),MOBAN/max(MOBAN));
  DDSUM(i)= dtw(Esample_D{i}/max(Esample_D{i}),moban_D/max(moban_D));
  DSUM(i)=dtw(Esample{i}/max(Esample{i}),moban/max(moban));
end