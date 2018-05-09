function [ fmg,fmgvt,fmgvp,Rpeak,Qlocatins,Slocatins,Qbegin,Send,Ppeak,Pbegin,Pend,Tbegin,Tend,Tpeak,NOofR,NOofT,NOofP ] = detect(ecgsignal )
%����˵����
%fmg:QRS�ĸ�ʴ���
%fmgvt:T��ʴ���
%fmgvp:P��ʴ���
%Rpeak��R��λ�ã�Qlocations:Q��λ�ã�Slocations:S��λ�ã�Qbegin��Q����㣬Send:S���յ�
%Ppeak��p����Pbegin��P����㣬Pend��P���յ�
%Tpeak:T����Tbegin:T����㣬Tend��T���յ�
%ecgsignal:�����ĵ��ź�

% a=load('F:\examplejson.txt');
% b = resample(a,500,446);
%[tm,sig]=rdsamp('E:\PHY\CCChallenge\set-a\1045434',[]);
coefs = cwt(ecgsignal,38,'db3');
hi = ecgsignal;
%mask
%ֱ��ͼ����ֵ
jidazhi = coefs(find(diff(sign(diff(coefs.*(coefs>0))))==-2)+1);
[counts,centers]=hist(jidazhi);
sum1 = 0;
for i =1:10
    sum1 =sum1 + counts(i)*centers(i);
end
mcent = sum1/sum(counts);
%ֱ��ͼ����ֵ

%������ѡ��
for i =1:length(coefs)
    if abs(coefs(i))>mcent;
        mp(i)=1;
    else
        mp(i)=0;
    end
end
%������ѡ��

%��ʴ���µĺ�ѡ��
s=ones(1,50);
fmg = enrosin( s,mp )+ones(1,length(mp));
vqrs=hi.*fmg';
clear s
%QRS dection
diffmg = diff(fmg);
st = find(diffmg==1);
en = find(diffmg(st(1)+2:end)==-1)+st(1)+1;
%��ʴ���µĺ�ѡ�� st��� en�յ�

%qrs�����ж�
qrsflag = findjizhidianfangxiang(coefs(st(1):en(1)));
if qrsflag ==1
    disp('qrs������')
else
    vqrs = -vqrs;
    coefs = -coefs;
    disp('qrs������')
end
%qrs�����ж�


lengthtouse = min(length(st),length(en));
fmginterval = en(1:lengthtouse)-st(1:lengthtouse);
Rpeak = [];
Qlocatins = [];
Slocatins = [];
Send = [];
Rs = [];
Re = [];
Qbegin = [];
%����ÿһ����ѡ����
for i = 1:lengthtouse
    if en(i)-st(i) < 0.5*mean(fmginterval) || en(i)-st(i) < 80
        for mj = st(i):en(i)+1
            fmg(mj)=0;
        end
        st(i)=0;
        en(i)=0;
        continue;
    end
    
    %��R
    tmparray = vqrs(st(i):en(i));
    tmparraypos = tmparray.*(tmparray>0);
    tmparrayneg = tmparray.*(tmparray<0);
    [maxpos,posloc] = max(tmparraypos);
    [mineg,negpoc] = min(tmparrayneg);
    Rpeak =[Rpeak, posloc(length(posloc))+st(i)-1];
    %��R
    
    
    %��¼���R������������յ�
    Rs = [Rs, st(i)];
    Re = [Re, en(i)];
   % tempq = vqrs(st(i):Rpeak(i));
   
   %��Q
     distancesq = zeros(1,1);
    for j = st(i):posloc(length(posloc))+st(i)-1
        distancesq(j-st(i)+1) = dist([st(i),vqrs(st(i))],[posloc(length(posloc))+st(i)-1,vqrs(posloc(length(posloc))+st(i)-1)],[j,vqrs(j)]);
    end
    [maxValue,location] = max(distancesq);
    Qlocatins = [Qlocatins,location(end)+st(i)-1];
    %��Q
    
    %��Q begin
    Qbeginarray = coefs(st(i):location(end)+st(i)-1);
    [minValues,minlocs] = min(Qbeginarray);
    Qbegin = [Qbegin, st(i)+minlocs(end)-1];
    %��Q begin
    
    %��S
    distancesS = zeros(1,1);
    for s = posloc(end)+st(i)-1:en(i)
        distancesS(s-(posloc(end)+st(i)-1)+1) = dist([posloc(end)+st(i)-1,vqrs(posloc(length(posloc))+st(i)-1)],[en(i),vqrs(en(i))],[s,vqrs(s)]);
    end
    [maxValues,locationS] = max(distancesS);
    tmps = vqrs( posloc(end)+st(i)-1:en(i));
    jixiaozhilocs = find(diff(sign(diff(tmps)))==2)+1;
    flags = xifiny(locationS(end),jixiaozhilocs);
    if flags == 1
        Slocatins =[Slocatins, locationS(end)+posloc(length(posloc))+st(i)-1-1];
        Sendarray = coefs(locationS(end)+posloc(end)+st(i)-1-1:en(i));
        %[minvaluesofS,minlocofs] = min(Sendarray);
        %Send =[Send,minlocofs(end)+locationS(length(locationS))+posloc(length(posloc))+st(i)-1-1-1];
    else
        jixiaoarray = vqrs( locationS(end)+posloc(end)+st(i)-1-1:en(i));
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
    %��S�� Slocatins
    
    %��Send
    tmpp = vqrs(Slocatins(end):en(i))';
    fdf = findlocations(vqrs(Qbegin(end)),tmpp);
    Send = [Send,Slocatins(length(Slocatins))+fdf(1)];
    %��Send
    
    clear tmparray
    clear distancesq
    clear distancesS
    clear Sendarray
    clear Qbeginarray
end

%��Ϊ������������st��en��ѡ�����㣬��������ȡ����
 st = st((st~=0));
 en = en((en~=0));
 
%У��
%ɾ������
flag = 1;

while(flag==1)
    flag = 0;
    jianyanR = ones(1,length(Rpeak));
    meanRR = mean(diff(Rpeak));
    for i = 2:length(Rpeak)
        if Rpeak(i)-Rpeak(i-1)<0.6*meanRR;
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

%У��
NOofR = [];
for i = 1:length(Rpeak)
    NOofR(i) = i;
end


%T wave detection
%���QRS��Ӧ�ĺ�ѡ������Ӧ���ź�
vt = hi-hi.*fmg';
%�任ϵ��
coefvt = cwt(vt,98,'db3');
%�任ϵ��

%ֱ��ͼ��ֵ
jidazhiofT = coefvt(find(diff(sign(diff(coefvt.*(coefvt>0))))==-2)+1);
[countvt,centervt]=hist(jidazhiofT);
sum2 = 0;
for i =1:length(centervt)
sum2 =sum2 + countvt(i)*centervt(i);
end
mcentvt = sum2/sum(countvt);
%ֱ��ͼ��ֵ

%������ѡ��
for i =1:length(coefvt)
    if abs(coefvt(i))>mcentvt;
        mpvt(i)=1;
    else
        mpvt(i)=0;
    end
end
%������ѡ��

%��ʴ���µĺ�ѡ��
s=ones(1,50);
fmgvt = enrosin( s,mpvt )+ones(1,length(mpvt));
nifmg = 1 - fmg;
fmgvt = nifmg.*fmgvt;
clear s
ecgvt = vt.*fmgvt';
diffmgvt = diff(fmgvt);
st = find(diffmgvt==1);
en = find(diffmgvt(st(1)+2:end)==-1)+st(1)+1;
%��ʴ���µĺ�ѡ�� ��ǿ��fmgvt = nifmg.*fmgvt;


%T��������
Tflag = findjizhidianfangxiang(coefvt(st(1):en(1)));
if Tflag ==1
    disp('t������')
else
    ecgvt = -ecgvt;
    coefvt = -coefvt;
    disp('t������')
end
%T�������� Tflag�������ˣ��ͷ�ת�ź�


Tpeak = [];
Tbegin = [];
Tend = [];
NOofT = [];
i = 1;
%����T��ÿһ����ѡ��
while(i<min(length(st),length(en)))
    
    %�Һ�ѡ�������ֵ������û����ת���������鷳��
    tmparray = ecgvt(st(i):en(i));
    tmparraypos = tmparray.*(tmparray>0);
    tmparrayneg = tmparray.*(tmparray<0);
    [maxpos,posloc] = max(tmparraypos);
    [mineg,negpoc] = min(tmparrayneg);
    Tpeak = [Tpeak,posloc(length(posloc))+st(i)-1];
    %�Һ�ѡ�������ֵ
    
    %��Tbegin
    Tbeginarray = ecgvt(st(i):posloc(length(posloc))+st(i)-1);
    [tmpbegin,beginloc] = min(Tbeginarray);
    Tbegin = [Tbegin,beginloc(length(beginloc))+st(i)-1];
    %��Tbegin
    
    %��T end
    Tendarray = ecgvt(posloc(length(posloc))+st(i)-1:en(i));
    [tmpend,endloc] = min(Tendarray);
    Tend = [Tend,endloc(length(endloc))+posloc(length(posloc))+st(i)-2];
    %��T end
    
    %��RΪ��׼��ȥ������ĺ�ѡ��
    
    index1 =  findlocations( st(i),Rpeak );
    NOofT = [NOofT index1-1 ];
    index2 =  findlocations( st(i+1),Rpeak );
    if (index1 == index2)
        for j = st(i+1):en(i+1)+3
            fmgvt(j)=0;
        end
        i = i + 2;
    else
        i = i + 1;
    end
    %��RΪ��׼��ȥ������ĺ�ѡ��
    
    clear tmparray
    clear tmparraypos
    clear tmparrayneg
    clear posloc
    clear negpoc Tbeginarray Tendarray endloc beginloc tmparray tmparraypos tmparrayneg
end
clear st
clear en
clear s


%P wvae detection
%����T�ĺ�ѡ��
ecgvts = hi.*fmgvt';
ecgvp = hi - ecgvts;
%����T�ĺ�ѡ��

%����Tpeak��Qbegin���������ź�
pidenticator = ones(1,length(hi));
for i = 1:min(length(Tpeak),length(Qlocatins))
    index = findlocations(Qlocatins(i),Tpeak);
    if index > length(Tpeak)
        for ds = Tpeak(end):length(ecgvp)
            ecgvp(ds) = 0;
        end
    else
        for j = Qlocatins(i)-5:Tpeak(index)
            ecgvp(j)=0;
            pidenticator(j)=0;
        end
    end
end
%����Tpeak��Qbegin���������ź�

%�任ϵ��
coefvp = cwt(ecgvp ,78,'db3');
%�任ϵ��

%ֱ��ͼȷ����ֵ��ֱ��ͼͳ�Ʊ任ϵ���ļ���ֵ
jidazhivp = coefvp(find(diff(sign(diff(coefvp.*(coefvp>0))))==-2)+1);
[countsvp,centersvp]=hist(jidazhivp);
sum3 = 0;
for i =1:10
    sum3 =sum3 + countsvp(i)*centersvp(i);
end
mcent = sum3/sum(countsvp);
%ֱ��ͼȷ����ֵ

%������ѡ����
for i =1:length(coefvp)
    if abs(coefvp(i))>mcent;
        mpvp(i)=1;
    else
        mpvp(i)=0;
    end
end
%������ѡ����

%��ʴ���µĺ�ѡ����
s=ones(1,50);
fmgvp = enrosin( s,mpvp )+ones(1,length(mpvp));
Ppeak = [];
Pbegin = [];
Pend = [];
NOofP = [];
diffmgvp = diff(fmgvp);
st = find(diffmgvp==1);
if(isempty(st))
    return;
end
en = find(diffmgvp(st(1)+2:end)==-1)+st(1)+1;
%��ʴ���µĺ�ѡ����

%�ж�p�������������򵹹���
%P�������ж�
Pflag = findjizhidianfangxiang(coefvp(st(1):en(1)));
if Pflag ==1
    disp('p������')
else
    ecgvp = -ecgvp;
    coefvp = -coefvp;
    disp('p������')
end
%�ж�p�������������򵹹���

i = 1;
%����ÿһ��p����ѡ��
while(i<min(length(st),length(en)))
    %ȥ���쳣��p����ѡ��
    if abs(st(i)-en(i))<10
        i = i + 1;
        continue;
    end
    %�ҵ�st(i)��Rpeak�����е�λ�ã�����R1��R2֮�䣬�򷵻�2
    index1 =  findlocations( st(i),Rpeak );
    index2 =  findlocations( st(i+1),Rpeak ); 
    if (index1 == index2)
        for j = st(i):en(i)+3
            fmgvp(j)=0;
        end
        i = i + 1;
        continue;
    end
    NOofP = [NOofP index1];
    %ȥ���쳣��p����ѡ��
    
    %�ҵ�st(i)֮�������Qbeigin��
    tselection = Qbegin.*(Qbegin>st(i));
    indexd = find(tselection);
    %�ҵ�st(i)֮�������Qbeigin��
    
    %��st(i)��Qbegin֮ǰ5����֮��Ŀ�Ϊ��ȷ��ѡ��
    tmparray = ecgvp(st(i):Qbegin(indexd(1))-5);
    %��st(i)��Qbegin֮ǰ5����֮��Ŀ�Ϊ��ȷ��ѡ��
    
    %ȡ��ѡ���ڷ�����Ӧ�ĺ�����
    %tmparraypos = tmparray.*(tmparray>0);
    %tmparrayneg = tmparray.*(tmparray<0);
    tpatt =find(tmparray);
    if length(tpatt)<10
        i = i+1;
        continue;
    end
     %ȡ��ѡ���ڷ�����Ӧ�ĺ�����tpatt
   
    %ȡp����Ӧ��CWTϵ��
    xxx = coefvp(st(i)+tpatt(2):st(i)+tpatt(end));
    %ȡp����Ӧ��CWTϵ��
    
    %ȡ����ֵ
    jidazhiloc = find(diff(sign(diff(xxx.*(xxx>0))))==-2)+1;
    if(length(jidazhiloc)==0)
        [ss,jidazhiloc]=max(xxx.*(xxx>0));
    end
    %ȡ����ֵλ��jidazhiloc
    
    %�ٴξ�ȷ��ѡ����
    houxuanp = ecgvp(jidazhiloc(end)+st(i)+tpatt(2)-4:jidazhiloc(end)+st(i)+tpatt(2)+4);
    [ps,locp] = max(houxuanp);
    %�ٴξ�ȷ��ѡ�����ź�:houxuanp��locpΪ���ֵ��λ��
    
    %P�㲨��
    Ppeak = [Ppeak,jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1];
    
    %P�㲨��
    
    %ʱ�����ߺͱ任ϵ�������󽻵�ΪPbegin
    sss = coefvp(jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1:-1:st(i)+tpatt(2)-1);
    uuu = ecgvp(jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1:-1:st(i)+tpatt(2)-1);
    locbe = findcrosspoint(uuu,sss);
    Pbegin = [Pbegin,jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1-locbe+1];
    %ʱ�����ߺͱ任ϵ�������󽻵�ΪPbegin
    
    %ʱ�����ߺͱ任ϵ�������ҽ���ΪPend
    eee = coefvp(jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1:st(i)+tpatt(end)-1);
    vvv = ecgvp(jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1:st(i)+tpatt(end)-1);
    locen = findcrosspoint(vvv,eee);
    
    Pend = [Pend, jidazhiloc(end)+st(i)+tpatt(2)-4+locp(end)-1+locen-1];
    %ʱ�����ߺͱ任ϵ�������ҽ���ΪPend
    
    
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
end
