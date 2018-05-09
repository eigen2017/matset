%  ecgnotfilter=textread('F:\AF\12\1\1497505431859\ecgnotfilter.data','%f');
% % ecgnotfilter=textread('f:\12daes\ecgnotfilter.data');
mypath = 'F:\AF\AF\1476781739936\';
sss=textread([mypath 'ecgfilter.data'],'%f');
atr=textread([mypath 'ecgatr.data'],'%f');
ann=textread([mypath 'ecgatrann.data'],'%f');
cnt=1;
for i=2:length(ann)-3
if ann(i) == 1
     Rpeak(cnt,:)=sss(atr(i)+1-84:atr(i)+1+84); 
     meanR=mean(Rpeak(cnt,:));
     stdR=std(Rpeak(cnt,:));
    for j =1:length(Rpeak(cnt,:))
       Rpeak(cnt,j) = (Rpeak(cnt,j)-meanR)/stdR;
    end
     cnt=cnt+1;
end
end
lR=length(Rpeak(cnt-1,:));
Rpeak(:,lR+1)=zeros(cnt-1,1);
