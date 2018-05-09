a=load('example12leads.txt');
a=a';
%b = resample(a,500,446);
lengthofsample = length(a(:,1));
Rfmg = zeros(12,lengthofsample);
Tfmg = zeros(12,lengthofsample);
Pfmg = zeros(12,lengthofsample);
Rpeak = cell(12,1);
Qlocations = cell(12,1);
Slocations = cell(12,1);
Qbegin =cell(12,1);
Send = cell(12,1);
Tpeak = cell(12,1);
Tbegin = cell(12,1);
Tend = cell(12,1);
Ppeak =cell(12,1);
Pbegin =cell (12,1);
Pend = cell(12,1);
NOR = cell(12,1);
NOT = cell(12,1);
NOP = cell(12,1);
% ValidR =cell(12,1);
% ValidT =cell(12,1);
% ValidP = cell(12,1);
for i = 1:12
    [x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17 ] = detect(a(:,i));
    Rfmg(i,:) = x1;
    Tfmg(i,:) =x2;
    Pfmg(i,:) = x3;
    Rpeak{i} = x4;
    Qlocations{i} = x5;
    Slocations{i} = x6;
    Qbegin{i} =x7;
    Send{i} = x8;
    Ppeak{i} = x9;
    Pbegin{i} = x10;
    Pend{i} = x11;
    Tbegin{i} = x12;
    Tend{i} = x13;
    Tpeak{i} = x14;
    NOR{i} = x15;
    NOT{i} = x16;
    NOP{i} = x17;
    
end

jiaoyanR = sum(Rfmg);
jiaoyanT = sum(Tfmg);
jiaoyanP = sum(Pfmg);
ValidR =  JudegeValidpoints( Rpeak,jiaoyanR );
ValidT =  JudegeValidpoints( Tpeak,jiaoyanT );
ValidP =  JudegeValidpoints( Ppeak,jiaoyanP );
%计算有效的特征点，并对齐

inValidleads =[];
j = 1;
for i = 1:12
    if (isempty(Rpeak{i})||isempty(Tpeak{i})||isempty(Ppeak{i}))
        inValidleads(j) = i;
        j = j + 1;
    end
end
if(isempty(inValidleads))
    disp('all leads Valid');
end
%add flags indicates the points belong to which beats.

Rpeak1 = erasezerospoints( ValidR,Rpeak ,inValidleads);

Qlocations1 = erasezerospoints( ValidR,Qlocations ,inValidleads);
Slocations1 = erasezerospoints( ValidR,Slocations ,inValidleads);
Qbegin1 = erasezerospoints( ValidR,Qbegin ,inValidleads);
Send1 = erasezerospoints( ValidR,Send ,inValidleads);

Tpeak1 = erasezerospoints( ValidT,Tpeak ,inValidleads);

Tbegin1 = erasezerospoints( ValidT,Tbegin ,inValidleads);
Tend1 = erasezerospoints( ValidT,Tend ,inValidleads);
Ppeak1 = erasezerospoints( ValidP,Ppeak ,inValidleads);
Pbegin1 = erasezerospoints( ValidP,Pbegin ,inValidleads);
Pend1 = erasezerospoints( ValidP,Pend ,inValidleads);

for i = 1:length(Rpeak1)
    tempR(i) = length(Rpeak(i));
end
[maxValue,maxloc] = max(tempR);
flagR = cell(12,1);
flagP = cell(12,1);
flagT = cell(12,1);
for i = 1:12
    for j = 1:length(Rpeak1{i})
        flagR{i}(j) =  findnearst(Rpeak1{i}(j),Rpeak1{maxloc});
    end
end

for i =1:12
    for j = 1:length(Ppeak1{i})
        flagP{i}(j) =  findnearst(Ppeak1{i}(j),Rpeak1{maxloc});
        
    end
end

for i =1:12
    for j = 1:length(Tpeak1{i})
        flagT{i}(j) =  findnearst(Tpeak1{i}(j),Rpeak1{maxloc});
    end
end

%%compute P duaration
%aim to I II III leads
for i = 1:length(Pbegin1{1})
    ps =[];
    pe = [];
    ps = [ps Pbegin1{1}(i)];
    pe = [pe Pend1{1}(i)];
   iden1 = xifiny( flagP{1}(i),flagP{2});
   if (iden1 == 1)
       loc = locationyes(flagP{1}(i),flagP{2});
       ps = [ps Pbegin1{2}(loc)];
       pe = [pe Pend1{2}(loc)];
   end
   iden2 = xifiny( flagP{1}(i),flagP{3});
   if (iden2 == 1)
       loc1 = locationyes(flagP{1}(i),flagP{3});
       ps = [ps Pbegin1{3}(loc1)];
       pe = [pe Pend1{3}(loc1)];
   end
   
    Pduartion(i) =max( pe) - min(ps);   
   
end
Pse = mean(Pduartion);




%compute PR interval






% 
%  [fudicalattay,sl] = shortestValid(Rpeak1,Tpeak1,Ppeak1);
% 
%  Rpeak2 = adjust( fudicalattay,Rpeak1 );
%  Qbegin2 = adjust( fudicalattay,Qbegin1 );
%  Qlocations2 = adjust( fudicalattay,Qlocations1 );
%  Slocations2 = adjust( fudicalattay,Slocations1 );
%  Send2 = adjust( fudicalattay,Send1 );
%  Ppeak2 = adjust( fudicalattay,Ppeak1 );
%  Pbegin2 = adjust( fudicalattay,Pbegin1 );
%  Pend2 = adjust( fudicalattay,Pend1 );
%  Tpeak2 = adjust( fudicalattay,Tpeak1 );
%  Tbegin2 = adjust( fudicalattay,Tbegin1 );
%  Tend2 = adjust( fudicalattay,Tend1 );

%%%%%%%%%%%%%%%%%
%compute P duaration
%aim to I II III leads
[m,n]=size(Rpeak2);
for i = 1:n
    ps = min([Pbegin2(1,i),Pbegin2(2,i),Pbegin2(3,i)]);
    pe = max([Pend2(1,i),Pend2(2,i),Pend2(3,i)]);
    Pduartion(i) = pe(1) - ps(1);
end
xx = sort(Pduartion);
loc = floor(length(xx)/2);
Pse = xx(loc);
%compute PR interval
for i = 1:n
    for xxx = 1:m
        sss(xxx) = Pbegin2(xxx,i);
    end
    for ttt = 1:m
        uuu(ttt) = Qbegin2(ttt,i);
    end
    ps = min(sss);
    qs = min(uuu);
    PR(i) = qs - ps;
end
yy = sort(PR);
loc = floor(length(yy)/2);
PRe =yy(loc);

%computer QRS duartion
for i = 1:n
    for ttt = 1:m
        uuu(ttt) = Qbegin2(ttt,i);
    end
    for ttt = 1:m
        fff(ttt) = Send2(ttt,i);
    end
    qs = min(uuu);
    se = max(fff);
    
   qrs(i) = se - qs; 
end
ssd = sort(qrs);
loc = floor(length(ssd)/2);
QRSe = ssd(loc);

%compute QT duartion
for i = 1:n
    qt(i) = Tend2(7,i) - Qbegin2(7,i);
end
QT = mean(qt);
%compute R V5 S V1
b5 = a(:,11);
for i = 1:length(Rpeak2(end-1,:))
    Rv5(i) = abs(b5(Rpeak2(end-1,i))-b5(Qbegin2(end-1,i)));
end
asd = sort(Rv5);
loc = floor(length(asd)/2);
V5R = asd(loc);


b7 = a(:,7);
for i = 1:length(Slocations2(7,:))
    Sv1(i) = abs(b7(Slocations2(7,i))-b7(Qbegin2(7,i)));
end
msd = sort(Sv1);
loc = floor(length(msd)/2);
V1S = msd(loc);

%计算电轴：
b6 = a(:,6);
b1 = a(:,1);
for i = 1:length(Rpeak2(6,:))
    I = b1(Rpeak2(1,i)) + b1(Slocations2(1,i));
    AVF = b6(Rpeak2(6,i)) + b6(Slocations2(6,i));
    if (I>0&&AVF>0)
        angleaa(i) = atan(abs(2/sqrt(3)*AVF/I));
    elseif (I>0&&AVF<0)
        angleaa(i) =  - atan(abs(2/sqrt(3)*AVF/I));
    elseif (I<0&&AVF>0)
        angleaa(i) = pi - atan(abs(2/sqrt(3)*AVF/I));
    else
        angleaa(i) = pi + atan(abs(2/sqrt(3)*AVF/I));
    end
end
dsgt = sort(angleaa);
loc = floor(length(dsgt)/2);
QRSangle = angleaa(loc)/pi*180;




