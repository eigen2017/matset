function [q1,s1, P,Q,R,S,T,suc] = Wdetect( sample )
%
% suc表示是否检测到QRS波群，0表示未检测到QRS波群，1表示检测到QRS波群
%结构元素的初始化

global sePos;
global amPos;
persistent bufferHeadPos;
if isempty(bufferHeadPos)
    bufferHeadPos=1;
end

persistent firsttime;
if isempty(firsttime)
   firsttime=0;
end
persistent learnFactor;
if isempty(learnFactor)
   learnFactor=0.9;
end

persistent lastPA;
if isempty(lastPA)
   lastPA=0;
end

persistent x;
if isempty(x)
   x=0;
end
x=x+1;
persistent buffer;

buffer(x)=sample;

if x==512
    
     xi=1:1:sePos(5);
     vq1 = interp1(sePos,amPos,xi);
     FS=buffer-(open_operation(buffer,vq1,512,sePos(5))+closed_operation(buffer,vq1,512,sePos(5)))/2;
     suc=0;
    % plot(FS)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    state=0;    %找active period 的起点
    for i=40:30+450
        if (suc==0&&state==0)
            if abs(FS(i))>eps
                indexStar=i;
                state=1;
            end
        end
        if(suc==0&&state==1)
            for j=i+2:30+450
                if abs(FS(j))<=1e-12&&abs(FS(j+1))<=1e-12&&abs(FS(j+2))<=1e-12&&abs(FS(j+3))<=1e-12&&abs(FS(j+4))<=1e-12&&abs(FS(j+5))<=1e-12&&abs(FS(j+6))<=1e-12&&abs(FS(j+7))<=1e-12&&abs(FS(j+8))<=1e-12&&abs(FS(j+9))<=1e-12
                    indexEnd=j;
                    if indexEnd-indexStar>19
                        suc=1;
                        break;
                    else
                        state=0;
                        break;
                    end
                end 
            end
        end
    end
    if(suc==1)
        %正负极性判断
        R1=indexStar+find(buffer(indexStar:indexEnd)==max(buffer(indexStar:indexEnd)))-1;
%       ex=find(buffer(R1)==max(buffer(R1)));
%       R1=R1(ex);
        R1=min(R1);
        
        q1=R1-40+find(buffer(R1-39:R1)==min(buffer(R1-39:R1)))+1;
        s1=R1+find(buffer(R1:R1+20)==min(buffer(R1:R1+20)))-1;
        % qx=find(buffer(q1)==min(buffer(q1)));
         q1=max(q1); 
         %sx=find(buffer(s1)==min(buffer(s1)));
         s1=min(s1);
         
        
        
        
        
        Q1=indexStar+find(FS(indexStar:R1)==min(FS(indexStar:R1)))-1;
        S1=R1+find(FS(R1:indexEnd)==min(FS(R1:indexEnd)))-1;
        ax=find(buffer(Q1)==min(buffer(Q1)));
        
        Q1=Q1(ax);
        bx=find(buffer(S1)==min(buffer(S1)));
        S1=S1(bx);

%         R2=indexStar+find(buffer(indexStar:indexEnd)==min(buffer(indexStar:indexEnd)))-1;
%         Q2=indexStar+find(FS(indexStar:R2)==max(FS(indexStar:R2)))-1;
%         S2=R2+find(FS(R2:indexEnd)==max(FS(R2:indexEnd)))-1;
%         cx=find(buffer(Q2)==max(buffer(Q2)));
%         Q2=Q2(cx);
%         dx=find(buffer(S2)==max(buffer(S2)));
%         S1=S2(dx);

%         Pos_peak=-Q1+(R1-Q1)+(R1-S1)-S1;
%         Neg_peak=Q2+(Q2-R2)+(S2-R2)+S2;
%         if (Pos_peak<Neg_peak)
%             R=R1;
%             Q=Q1;
%             S=S1;
%         else
%             R=R2;
%             Q=Q2;
%             S=S2;
%         end
             R=R1;
             Q=Q1;
             S=S1;
        P=indexStar;
        T=indexEnd;

        PA=0;
        for i=Q:S
            PA=PA+abs(FS(i));
        end

        if(firsttime == 0)
        learnFactor = 0.9;
        lastPA = PA;
        else
            if (PA>lastPA*1.1)
                learnFactor=learnFactor-0.05;   
            else
                if (PA<lastPA*0.9)
                    learnFactor=learnFactor+0.05;
                else
                    learnFactor=0.3;
                end
            end
            lastPA = PA;
        end

        %QRS
        QNewloc=(1-learnFactor)*(sePos(2)-sePos(1))+(0+learnFactor)*(Q-indexStar);
        RNewloc=(1-learnFactor)*(sePos(3)-sePos(1))+(0.1+learnFactor)*(R-indexStar);
        SNewloc=(1-learnFactor)*(sePos(4)-sePos(1))+(0.2+learnFactor)*(S-indexStar);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Endloc=(1-learnFactor)*(sePos(5)-sePos(1))+(0.3+learnFactor)*(indexEnd-indexStar);


        QNewAmp=(1-learnFactor)*amPos(2)+learnFactor*buffer(Q);
        RNewAmp=(1-learnFactor)*amPos(3)+learnFactor*buffer(R);
        SNewAmp=(1-learnFactor)*amPos(4)+learnFactor*buffer(S);

        sePos=[1,1+ceil(QNewloc),1+ceil(RNewloc),1+floor(SNewloc),1+ceil(Endloc)];
        amPos=[0,QNewAmp,RNewAmp,SNewAmp,0];
        
        localS = S;
        
        %用bufferheadpos去重新计算PQRST的绝对位置
        P=bufferHeadPos+P-1;
        Q=bufferHeadPos+Q-1;
        R=bufferHeadPos+R-1;
        S=bufferHeadPos+S-1;
        T=bufferHeadPos+T-1;
        q1=bufferHeadPos+q1-1;
        s1=bufferHeadPos+s1-1;
        
        if (512 < (localS+40))
            x = 0;
            bufferHeadPos = bufferHeadPos + 512;
        else
            for k=localS+40:512
                buffer(k-localS-40+1)=buffer(k);
            end
            x = 512-(localS+40)+1;
            bufferHeadPos=S+40;
        end


    else
         for k=350:512
                buffer(k-350+1)=buffer(k);
         end
         x=163;
         bufferHeadPos=bufferHeadPos+349;
          P=0;
          Q=0;
          R=0;
          S=0;
          T=0;
          q1=0;
          s1=0;
   
    end
   

else
    P=0;
    Q=0;
    R=0;
    S=0;
    T=0;
    suc=0;
    q1=0;
    s1=0;
end

