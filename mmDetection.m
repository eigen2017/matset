[tm,sig]=rdsamp('D:\201m',1);
sample=-sig(1:10000);                   %选取前8秒的数据
sampleFilter=filter(lppass360,sample);  %40HZ 低通滤波
% plot(sampleFilter);
% hold on
% plot(sample)
%initialize SE
A=max(sample(1:720));
B=min(sample(1:720));
Amp=A-B;
%sePos=[1,7,13,20,27];
sePos=[1,19,37,55,73];
amPos=[0,B,A,B,0];
xi=1:1:sePos(5);
vq1 = interp1(sePos,amPos,xi);
% plot(sePos,amPos,'o',xi,vq1,':.');
windowL=360;     %窗口大小1S样本点
windowSample=sampleFilter(1:360);
FS=windowSample-(open_operation(windowSample,vq1,360,sePos(5))+closed_operation(windowSample,vq1,360,sePos(5)))/2;

flag=0;
% plot(FS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
state=0;    %找active period 的起点
for i=40:30+310
    if (flag==0&&state==0)
        if abs(FS(i))>eps
            indexStar=i;
            state=1;
        end
    end
    if(flag==0&&state==1)
        for j=i+2:30+300
            if abs(FS(j))<=eps&&abs(FS(j+1))<=eps&&abs(FS(j+2))<=eps
                indexEnd=j;
                if indexEnd-indexStar>20
                    flag=1;
                    break;
                else
                    state=0;
                    break;
                end
            end 
        end
    end
end

% for i=50:300 
%     if (abs(FS(i))>=eps)
%      %   if(FS(i+1)~=0&&FS(i+2)~=0)
%             indexStar=i;
%             for j=i+2:300
%                 if abs(FS(j))<eps&&abs(FS(j+1))<eps&&abs(FS(j+2))<eps
%                     indexEnd=j;
%                     if indexEnd-indexStar>10           %segment持续时间大于70ms   0.07*360
%                         flag=1;
%                       break;                             
%                     end
%                 end
%             end  
%             break;
%      end
% end
%active period
if(flag==1)
%正负极性判断
R1=indexStar+find(FS(indexStar:indexEnd)==max(FS(indexStar:indexEnd)))-1;
Q1=indexStar+find(FS(indexStar:R1)==min(FS(indexStar:R1)))-1;
S1=R1+find(FS(R1:indexEnd)==min(FS(R1:indexEnd)))-1;

R2=indexStar+find(FS(indexStar:indexEnd)==min(FS(indexStar:indexEnd)))-1;
Q2=indexStar+find(FS(indexStar:R2)==max(FS(indexStar:R2)))-1;
S2=R2+find(FS(R2:indexEnd)==max(FS(R2:indexEnd)))-1;

Pos_peak=-Q1+(R1-Q1)+(R1-S1)-S1;
Neg_peak=Q2+(Q2-R2)+(S2-R2)+S2;
if (Pos_peak<Neg_peak)
    R_peak=R1;
    Q_pos=Q1;
    S_pos=S1;
else
    R_peak=R2;
    Q_pos=Q2;
    S_pos=S2;
end
Rpos(1)=R_peak;
%calculate PA(peakactivity)
PA(1)=0;
for i=Q_pos:S_pos
    PA(1)=PA(1)+abs(FS(i));
end

%update SE
learnFactor=0.9;
%QRS
QNewloc=(1-learnFactor)*(sePos(2)-sePos(1))+learnFactor*(Q_pos-indexStar);
RNewloc=(1-learnFactor)*(sePos(3)-sePos(1))+learnFactor*(R_peak-indexStar);
SNewloc=(1-learnFactor)*(sePos(4)-sePos(1))+learnFactor*(S_pos-indexStar);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Endloc=(1-learnFactor)*(sePos(5)-sePos(1))+learnFactor*(indexEnd-indexStar);


QNewAmp=(1-learnFactor)*amPos(2)+learnFactor*windowSample(Q_pos);
RNewAmp=(1-learnFactor)*amPos(3)+learnFactor*windowSample(R_peak);
SNewAmp=(1-learnFactor)*amPos(4)+learnFactor*windowSample(S_pos);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EndAmp=(1-learnFactor)*amPos(5)+learnFactor*windowSample(indexEnd);

%Newse=[1,1+ceil(QNewloc),1+ceil(RNewloc),1+ceil(SNewloc),27];

%选择新的数据段
%if flag==1
    newStar=indexEnd+10;
    if newStar>360
        newStar=360;
    end
else
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     QNewloc=sePos(2)-sePos(1);
     RNewloc=sePos(3)-sePos(1);
     SNewloc=sePos(4)-sePos(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     Endloc=sePos(5)-sePos(1);
     QNewAmp=amPos(2);
     RNewAmp=amPos(3);
     SNewAmp=amPos(4);
     
     newStar=200;
end
learnFactor=0.9;
Newse=[1,1+ceil(QNewloc),1+ceil(RNewloc),1+ceil(SNewloc),1+ceil(Endloc)];

%Newam=[0,QNewAmp,RNewAmp,SNewAmp,0];
Newam=[0,QNewAmp,RNewAmp,SNewAmp,0];
%更新后的结构元素
xi=1:1:Newse(5);
vq1 = interp1(Newse,Newam,xi);



windowSample=sampleFilter(newStar:newStar+359);

FS=windowSample-(open_operation(windowSample,vq1,360,Newse(5))+closed_operation(windowSample,vq1,360,Newse(5)))/2;
%active period

flag=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
state=0;    %找active period 的起点
for i=30:30+310
    if (flag==0&&state==0)
        if abs(FS(i))>eps
            indexStar=i;
            state=1;
        end
    end
    if(flag==0&&state==1)
        for j=i+2:30+300
            if abs(FS(j))<=eps&&abs(FS(j+1))<=eps&&abs(FS(j+2))<=eps
                indexEnd=j;
                if indexEnd-indexStar>20
                    flag=1;
                    break;
                else
                    state=0;
                    break;
                end
            end 
        end
    end
end
            

% for i=30:30+300
%     if(abs(FS(i))>eps)
%         indexStar=i;
%         for j=i+2:30+290
%             if FS(j)<=eps&&FS(j+1)<=eps&&FS(j+2)<=eps
%                 indexEnd=j;
%                     if indexEnd-indexStar>25           %segment持续时间大于70ms   0.07*360
%                         flag=1;
%                       break;                             
%                     end
%             end
%        end  
%             break;
%      end
% end

if(flag==1)
R1=indexStar+find(FS(indexStar:indexEnd)==max(FS(indexStar:indexEnd)))-1;
Q1=indexStar+find(FS(indexStar:R1)==min(FS(indexStar:R1)))-1;
S1=R1+find(FS(R1:indexEnd)==min(FS(R1:indexEnd)))-1;

R2=indexStar+find(FS(indexStar:indexEnd)==min(FS(indexStar:indexEnd)))-1;
Q2=indexStar+find(FS(indexStar:R2)==max(FS(indexStar:R2)))-1;
S2=R2+find(FS(R2:indexEnd)==max(FS(R2:indexEnd)))-1;     
ax=find(windowSample(S2)==min(windowSample(S2)));
S2=S2(ax);


Pos_peak=-Q1+(R1-Q1)+(R1-S1)-S1;
Neg_peak=Q2+(Q2-R2)+(S2-R2)+S2;
if(Pos_peak<Neg_peak)
    R_peak=R1;
    Q_pos=Q1;
    S_pos=S1;
else
    R_peak=R2;  
    Q_pos=Q2;
    S_pos=S2; 
end
Rpos(2)=R_peak+newStar;
PA(2)=0;
for i=Q_pos:S_pos
    PA(2)=PA(2)+abs(FS(i));
end
%update learning coefficient
if (PA(2)>PA(1)*1.1)
    learnFactor=learnFactor-0.05;
else
    if (PA(2)<PA(1)*0.9)
        learnFactor=learnFactor+0.05;
    else
        learnFactor=0.3;
    end
end
QNewloc=(1-learnFactor)*(Newse(2)-Newse(1))+learnFactor*(Q_pos-indexStar);
RNewloc=(1-learnFactor)*(Newse(3)-Newse(1))+learnFactor*(R_peak-indexStar);
SNewloc=(1-learnFactor)*(Newse(4)-Newse(1))+learnFactor*(S_pos-indexStar);
%%%%%%%%%%%%%%%%%%%%
Endloc=(1-learnFactor)*(sePos(5)-sePos(1))+learnFactor*(indexEnd-indexStar);

QNewAmp=(1-learnFactor)*Newam(2)+learnFactor*windowSample(Q_pos);
RNewAmp=(1-learnFactor)*Newam(3)+learnFactor*windowSample(R_peak);
SNewAmp=(1-learnFactor)*Newam(4)+learnFactor*windowSample(S_pos);


%Newse=[1,1+ceil(QNewloc),1+ceil(RNewloc),1+ceil(SNewloc),27];
Newse=[1,1+ceil(QNewloc),1+ceil(RNewloc),1+ceil(SNewloc),1+ceil(Endloc)];
xi=1:1:Newse(5);
Newam=[0,QNewAmp,RNewAmp,SNewAmp,0];
vq1 = interp1(Newse,Newam,xi);
%选取新的数据段
%  if flag==1
     AA=newStar+S_pos-1+10;
    % windowSample=sampleFilter(newStar+S_pos-1+10:newStar+S_pos-1+10+359);
else
 
     AA=newStar+180;
    % windowSample=sampleDilter(newStar+180:newStar+180+359);
 end
 windowSample=sampleFilter(AA:AA+359);
 FS=windowSample-(open_operation(windowSample,vq1,360,Newse(5))+closed_operation(windowSample,vq1,360,Newse(5)))/2;
 flag=0;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 state=0;    %找active period 的起点
for i=30:30+310
    if (flag==0&&state==0)
        if abs(FS(i))>eps
            indexStar=i;
            state=1;
        end
    end
    if(flag==0&&state==1)
        for j=i+2:30+300
            if abs(FS(j))<=eps&&abs(FS(j+1))<=eps&&abs(FS(j+2))<=eps&&abs(FS(j+3))<=eps&&abs(FS(j+4))<=eps
                indexEnd=j;
                if indexEnd-indexStar>20
                    flag=1;
                    break;
                else
                    state=0;
                    break;
                end
            end 
        end
    end
end
      
 
%  for i=30:30+300
%     if(abs(FS(i))>eps)
%         indexStar=i;
%         for j=i+2:i+298
%             if FS(j)<=eps&&FS(j+1)<=eps&&FS(j+2)<=eps
%                     indexEnd=j;
%                     if indexEnd-indexStar>25           %segment持续时间大于70ms   0.07*360
%                         flag=1;
%                       break;                             
%                     end
%            end
%        end  
%             break;
%      end
%  end
 %if (flag==1)
 count=3;
 while(1)
 if(flag==1)
R1=indexStar+find(FS(indexStar:indexEnd)==max(FS(indexStar:indexEnd)))-1;
Q1=indexStar+find(FS(indexStar:R1)==min(FS(indexStar:R1)))-1;
S1=R1+find(FS(R1:indexEnd)==min(FS(R1:indexEnd)))-1;

R2=indexStar+find(FS(indexStar:indexEnd)==min(FS(indexStar:indexEnd)))-1;
Q2=indexStar+find(FS(indexStar:R2)==max(FS(indexStar:R2)))-1;
S2=R2+find(FS(R2:indexEnd)==max(FS(R2:indexEnd)))-1;     
ax=find(windowSample(S2)==min(windowSample(S2)));
S2=S2(ax);
%count=3;


    
Pos_peak=-Q1+(R1-Q1)+(R1-S1)-S1;
Neg_peak=Q2+(Q2-R2)+(S2-R2)+S2;
if(Pos_peak<Neg_peak)
    R_peak=R1;
    Q_pos=Q1;
    S_pos=S1;
else
    R_peak=R2;  
    Q_pos=Q2;
    S_pos=S2; 
end

Rpos(count)=R_peak+AA;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
QRS_length=(S_pos-Q_pos)/360;                                     %QRS波群的持续时间

PA(count)=0;
for i=Q_pos:S_pos
    PA(count)=PA(count)+abs(FS(i));
end
%update learning coefficient
if (PA(count)>PA(count-1)*1.1)
    learnFactor=learnFactor-0.05;
else
    if (PA(3)<PA(2)*0.9)
        learnFactor=learnFactor+0.05;
    else
        learnFactor=0.3;
    end
end
count=count+1;
QNewloc=(1-learnFactor)*(Newse(2)-Newse(1))+learnFactor*(Q_pos-indexStar);
RNewloc=(1-learnFactor)*(Newse(3)-Newse(1))+learnFactor*(R_peak-indexStar);
SNewloc=(1-learnFactor)*(Newse(4)-Newse(1))+learnFactor*(S_pos-indexStar);
Endloc=(1-learnFactor)*(Newse(5)-Newse(1))+learnFactor*(indexEnd-indexStar);

QNewAmp=(1-learnFactor)*Newam(2)+learnFactor*windowSample(Q_pos);
RNewAmp=(1-learnFactor)*Newam(3)+learnFactor*windowSample(R_peak-2);
SNewAmp=(1-learnFactor)*Newam(4)+learnFactor*windowSample(S_pos);

Newse=[1,1+ceil(QNewloc),1+ceil(RNewloc),1+ceil(SNewloc),1+ceil(Endloc)];
Newam=[0,QNewAmp,RNewAmp,SNewAmp,0];
xi=1:1:Newse(5);
vq1 = interp1(Newse,Newam,xi);
%选取新的数据段
% if flag==1
    AA=AA+S_pos-1+10;
else
    AA=AA+180;
end
if AA>length(sampleFilter)-360;
    break;
end
windowSample=sampleFilter(AA:AA+359);
FS=windowSample-(open_operation(windowSample,vq1,360,Newse(5))+closed_operation(windowSample,vq1,360,Newse(5)))/2;
plot(FS);
hold on
plot(windowSample);
flag=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 state=0;    %找active period 的起点
for i=30:30+310
    if (flag==0&&state==0)
        if abs(FS(i))>eps
            indexStar=i;
            state=1;
        end
    end
    if(flag==0&&state==1)
        for j=i+2:30+300
            if abs(FS(j))<=eps&&abs(FS(j+1))<=eps&&abs(FS(j+2))<=eps&&abs(FS(j+3))<=eps&&abs(FS(j+4))<=eps
                indexEnd=j;
                if indexEnd-indexStar>20
                    flag=1;
                    break;
                else
                    state=0;
                    break;
                end
            end 
        end
    end
end



% for i=30:30+300
%     if(abs(FS(i))>eps)
%         indexStar=i;
%         for j=i+2:i+298
%             if FS(j)<=eps&&FS(j+1)<=eps&&FS(j+2)<=eps
%                     indexEnd=j;
%                     if indexEnd-indexStar>25           %segment持续时间大于70ms   0.07*360
%                         flag=1;
%                       break;                             
%                     end
%            end
%        end  
%             break;
%      end
% end
% R1=indexStar+find(FS(indexStar:indexEnd)==max(FS(indexStar:indexEnd)))-1;
% Q1=indexStar+find(FS(indexStar:R1)==min(FS(indexStar:R1)))-1;
% S1=R1+find(FS(R1:indexEnd)==min(FS(R1:indexEnd)))-1;
% 
% R2=indexStar+find(FS(indexStar:indexEnd)==min(FS(indexStar:indexEnd)))-1;
% Q2=indexStar+find(FS(indexStar:R2)==max(FS(indexStar:R2)))-1;
% S2=R2+find(FS(R2:indexEnd)==max(FS(R2:indexEnd)))-1;     
% ax=find(windowSample(S2)==min(windowSample(S2)));
% S2=S2(ax);
 end    
% hold on
% plot(FS)
% hold on
% plot(windowSample)