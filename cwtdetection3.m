a=load('F:\examplejson.txt');
b = resample(a,500,446);
%[tm,sig]=rdsamp('E:\PHY\CCChallenge\set-a\1045434',[]);
coefs = cwt(b(:,3)/10000,38,'db3');
hi =b(:,3)/10000;

%mask
jidazhi = coefs(find(diff(sign(diff(coefs.*(coefs>0))))==-2)+1);
[counts,centers]=hist(jidazhi);
sum1 = 0;
for i =1:10
sum1 =sum1 + counts(i)*centers(i);
end
mcent = sum1/sum(counts);
for i =1:length(coefs)
    if abs(coefs(i))>mcent;
        mp(i)=1;
    else
        mp(i)=0;
    end
end

s=ones(1,50);
fmg = enrosin( s,mp )+ones(1,length(mp));
vqrs=hi.*fmg';
clear s
%QRS dection
diffmg = diff(fmg);
st = find(diffmg==1);
en = find(diffmg(st(1)+2:end)==-1)+st(1)+1;
lengthtouse = min(length(st),length(en));
fmginterval = en(1:lengthtouse)-st(1:lengthtouse);
Rpeak = [];
Qlocatins = [];
Slocatins = [];
Send = [];
Rs = [];
Re = [];
Qbegin = [];
for i = 1:lengthtouse
    if en(i)-st(i) < 0.4*mean(fmginterval) || en(i)-st(i) < 80
        for mj = st(i):en(i)+1
            fmg(mj)=0;
        end
        st(i)=0;
        en(i)=0;
        continue;
    end
    tmparray = vqrs(st(i):en(i));
    tmparraypos = tmparray.*(tmparray>0);
    tmparrayneg = tmparray.*(tmparray<0);
    [maxpos,posloc] = max(tmparraypos);
    [mineg,negpoc] = min(tmparrayneg);
    Rpeak =[Rpeak, posloc(length(posloc))+st(i)-1];
    %记录检出R波区域的起点和终点
    Rs = [Rs, st(i)];
    Re = [Re, en(i)];
   % tempq = vqrs(st(i):Rpeak(i));
     distancesq = zeros(1,1);
    for j = st(i):posloc(length(posloc))+st(i)-1
        distancesq(j-st(i)+1) = dist([st(i),hi(st(i))],[posloc(length(posloc))+st(i)-1,hi(posloc(length(posloc))+st(i)-1)],[j,hi(j)]);
    end
    [maxValue,location] = max(distancesq);
    Qlocatins = [Qlocatins,location(end)+st(i)-1];
    Qbeginarray = coefs(st(i):location(end)+st(i)-1);
    [minValues,minlocs] = min(Qbeginarray);
    Qbegin = [Qbegin, st(i)+minlocs(end)-1];
    distancesS = zeros(1,1);
    for s = posloc(end)+st(i)-1:en(i)
        distancesS(s-(posloc(end)+st(i)-1)+1) = dist([posloc(end)+st(i)-1,hi(posloc(length(posloc))+st(i)-1)],[en(i),hi(en(i))],[s,hi(s)]);
    end
    [maxValues,locationS] = max(distancesS);
    tmps = hi( posloc(end)+st(i)-1:en(i));
    jixiaozhilocs = find(diff(sign(diff(tmps)))==2)+1;
    flags = xifiny(locationS(end),jixiaozhilocs);
    if flags == 1
        Slocatins =[Slocatins, locationS(end)+posloc(length(posloc))+st(i)-1-1];
        Sendarray = coefs(locationS(end)+posloc(end)+st(i)-1-1:en(i));
        %[minvaluesofS,minlocofs] = min(Sendarray);
        %Send =[Send,minlocofs(end)+locationS(length(locationS))+posloc(length(posloc))+st(i)-1-1-1];
    else
        jixiaoarray = hi( locationS(end)+posloc(end)+st(i)-1-1:en(i));
        jixiaozhilocfin = find(diff(newsign(diff(jixiaoarray)))==2)+1;
        if length(jixiaozhilocfin)==0
            Slocatins = [Slocatins,en(i)];
            %Send =[Send,en(i)];
        else
             Slocatins =[Slocatins, locationS(end)+posloc(end)+st(i)-1-1+jixiaozhilocfin(1)-1];
%              Sendarray = coefs( locationS(end)+posloc(length(posloc))+st(i)-1-1+jixiaozhilocfin(1)-1:en(i));
%              [minvaluesofS,minlocofs] = min(Sendarray);
%              Send =[Send,minlocofs(end)+locationS(end)+posloc(length(posloc))+st(i)-1-1+jixiaozhilocfin(1)-1-1];
        end
            
       
    end
    Send = [Send,en(i)];
    
   
    clear tmparray
    clear distancesq
    clear distancesS
    clear Sendarray
    clear Qbeginarray
end
 st = st((st~=0));
 en = en((en~=0));
%删除多检点
flag = 1;

while(flag==1)
    flag = 0;
    jianyanR = ones(1,length(Rpeak));
    meanRR = mean(diff(Rpeak));
    for i = 2:length(Rpeak)
        if Rpeak(i)-Rpeak(i-1)<0.5*meanRR;
            flag = flag + 1;
            if coefs(Rpeak(i))>coefs(Rpeak(i-1))
                jianyanR(i-1)=0;
            else
                jianyanR(i)=0;
            end
        end
    end
    if flag == 0
        break;
    end
   NewRR=jianyanR.*Rpeak;
   mm = Rs;
   nn = Re;
   Rs = Rs.*jianyanR;
   Re = Re.*jianyanR;
   newQlocatins =  Qlocatins.*jianyanR;
   newSlocatins = Slocatins.*jianyanR;
   newSend = Send.*jianyanR;
   newQbegins = Qbegin.*jianyanR;
   Rpeak = NewRR((NewRR~=0));
   Qlocatins = newQlocatins((newQlocatins~=0));
   Slocatins = newSlocatins((newSlocatins~=0));
   Send = newSend((newSend~=0));
   Qbegin = newQbegins((newQbegins~=0));
   slocs = find(Rs==0);
   for i = 1:length(slocs)
       for j = mm(slocs(i)):nn(slocs(i))
           fmg(j)=0;
       end
   end
   Rs =  Rs((Rs~=0));
   Re =  Re((Re~=0));
   flag = 1;
   clear jianyanR
   clear NewRR
   clear mm
   clear nn
end


%T wave detection
vt = hi-hi.*fmg';
coefvt = cwt(vt,98,'db3');
jidazhiofT = coefvt(find(diff(sign(diff(coefvt.*(coefvt>0))))==-2)+1);
[countvt,centervt]=hist(jidazhiofT);
sum2 = 0;
for i =1:length(centervt)
sum2 =sum2 + countvt(i)*centervt(i);
end
mcentvt = sum2/sum(countvt);
for i =1:length(coefvt)
    if abs(coefvt(i))>mcentvt;
        mpvt(i)=1;
    else
        mpvt(i)=0;
    end
end
s=ones(1,50);
fmgvt = enrosin( s,mpvt )+ones(1,length(mpvt));
nifmg = 1 - fmg;
fmgvt = nifmg.*fmgvt;
clear s
ecgvt = vt.*fmgvt';
diffmgvt = diff(fmgvt);
st = find(diffmgvt==1);
en = find(diffmgvt(st(1)+2:end)==-1)+st(1)+1;
Tpeak = [];
Tbegin = [];
Tend = [];
i = 1;
while(i<min(length(st),length(en)))
    tmparray = ecgvt(st(i):en(i));
    tmparraypos = tmparray.*(tmparray>0);
    tmparrayneg = tmparray.*(tmparray<0);
    [maxpos,posloc] = max(tmparraypos);
    [mineg,negpoc] = min(tmparrayneg);
    
    
    Tpeak = [Tpeak,posloc(length(posloc))+st(i)-1];
    Tbeginarray = ecgvt(st(i):posloc(length(posloc))+st(i)-1);
    [tmpbegin,beginloc] = min(Tbeginarray);
    Tbegin = [Tbegin,beginloc(length(beginloc))+st(i)-1];
    Tendarray = ecgvt(posloc(length(posloc))+st(i)-1:en(i));
    [tmpend,endloc] = min(Tendarray);
    Tend = [Tend,endloc(length(endloc))+posloc(length(posloc))+st(i)-2];
    
    index1 =  findlocations( st(i),Rpeak );
    index2 =  findlocations( st(i+1),Rpeak );
    if (index1 == index2)
        for j = st(i+1):en(i+1)+3
            fmgvt(j)=0;
        end
        i = i + 2;
    else
        i = i + 1;
    end
    clear tmparray
    clear tmparraypos
    clear tmparrayneg
    clear posloc
    clear negpoc Tbeginarray Tendarray endloc beginloc tmparray tmparraypos tmparrayneg
end
clear st
clear en
%P wvae detection
ecgvts = hi.*fmgvt';
ecgvp = hi - ecgvts;
pidenticator = ones(1,length(hi));
for i = 1:min(length(Tpeak),length(Qlocatins))
    for j = Qlocatins(i)-5:Tpeak(i)
        ecgvp(j)=0;
        pidenticator(j)=0;
    end
end
coefvp = cwt(ecgvp ,78,'db3');
jidazhivp = coefvp(find(diff(sign(diff(coefvp.*(coefvp>0))))==-2)+1);
[countsvp,centersvp]=hist(jidazhivp);
sum3 = 0;
for i =1:10
    sum3 =sum3 + countsvp(i)*centersvp(i);
end
mcent = sum3/sum(countsvp);
for i =1:length(coefvp)
    if abs(coefvp(i))>mcent;
        mpvp(i)=1;
    else
        mpvp(i)=0;
    end
end
s=ones(1,50);
fmgvp = enrosin( s,mpvp )+ones(1,length(mpvp));
%nifmgvp = 1- (fmg + fmgvt);
%fmgvp = nifmgvp.*fmgvp;
diffmgvp = diff(fmgvp);
st = find(diffmgvp==1);
en = find(diffmgvp(st(1)+2:end)==-1)+st(1)+1;
Ppeak = [];
Pbegin = [];
Pend = [];
i = 1;
while(i<min(length(st),length(en)))
    if abs(st(i)-en(i))<10
        i = i + 1;
        continue;
    end
    index1 =  findlocations( st(i),Rpeak );
    index2 =  findlocations( st(i+1),Rpeak ); 
    if (index1 == index2)
        for j = st(i):en(i)+3
            fmgvp(j)=0;
        end
        i = i + 1;
        continue;
    end
    tselection = Qbegin.*(Qbegin>st(i));
    indexd = find(tselection);
    tmparray = ecgvp(st(i):Qbegin(indexd(1))-5);
    %tmparraypos = tmparray.*(tmparray>0);
    %tmparrayneg = tmparray.*(tmparray<0);
    tpatt =find(tmparray);
    if length(tpatt)<10
        i = i+1;
        continue;
    end
   
    xxx = coefvp(st(i)+tpatt(2):st(i)+tpatt(end));
    jidazhiloc = find(diff(sign(diff(xxx.*(xxx>0))))==-2)+1;
    houxuanp = hi(jidazhiloc(end)+st(i)+tpatt(2)-4:jidazhiloc(end)+st(i)+tpatt(2)+4);
    [ps,locp] = max(houxuanp);
    
    Ppeak = [Ppeak,jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1];
    sss = coefvp(jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1:-1:st(i)+tpatt(2)-1);
    uuu = hi(jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1:-1:st(i)+tpatt(2)-1);
   
    locbe = findcrosspoint(uuu,sss);
    Pbegin = [Pbegin,jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1-locbe+1];
    eee = coefvp(jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1:st(i)+tpatt(end)-1);
    vvv = hi(jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1:st(i)+tpatt(end)-1);
    locen = findcrosspoint(vvv,eee);

    Pend = [Pend, jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1+locen-1];
    i = i + 1;
    clear tmparray tmparraypos tmparrayneg posloc negpoc Pbeginarray Pendarray sss eee uuu vvv
end


figure
plot(hi)
hold on
plot(Ppeak,hi(Ppeak),'*')
hold on
plot(Rpeak,hi(Rpeak),'*')
hold on
plot(Tpeak,hi(Tpeak),'*')
hold on
plot(Qlocatins,hi(Qlocatins),'o')
hold on
plot(Slocatins,hi(Slocatins),'o')
hold on
plot(Qbegin,hi(Qbegin),'o')
hold on
plot(Send,hi(Send),'o')
hold on
plot(Tend,hi(Tend),'o')
hold on
plot(Tbegin,hi(Tbegin),'o')
hold on
plot(Pbegin,hi(Pbegin),'*')
hold on
plot(Pend,hi(Pend),'*')








    
            
    
















