% b=textread('F:\crackalg\1470366477755\ecgnotfilter.data','%f');
% %plot(b)
% test2;
% c=x_3(2000:end);
% d=filter(hony,c);
% structure element
d=kk;
g1=[1 1 1]*1000;
g2=[0.2 0.6 1 1.2 1 0.6 0.2]*1000;
g3=[0.2 0.4 0.6 0.8 1 1.2 1 0.8 0.6 0.4 0.2]*1000;


M1=open_operation(d,g1,length(d),3);
MM1=closed_operation(d,g1,length(d),3);
MMM1=(M1-MM1)/16;

M2=open_operation(d,g2,length(d),7);
MM2=closed_operation(d,g2,length(d),7);
MMM2=(M2-MM2)/8;

M3=open_operation(d,g3,length(d),11);
MM3=closed_operation(d,g3,length(d),11);
MMM3=(M3-MM3)/4;

KKK=closed_operation(d,g3,length(d),11);
yyy=MMM1+MMM2+MMM3+KKK;
vvv=diff(yyy);
vvv=512*vvv;
sss=zeros(length(vvv),1);

%updating se
for i=26:length(vvv)-25
    sss(i)=sum(abs(vvv(i-25:i+25)));
end


windowL=43;
z=zeros(length(d),1);
for i=windowL:length(d)
    z(i)=max(d(i-windowL+1:i));
end
%thv=0.16*max(d);
thv=655;     %related to the length of windowL
index=1;
for i=1:length(d)-1;
    if((z(i)<thv&&z(i+1)>thv)||z(i)==thv)
        time(index)=i;
        index=index+1;
    end
end
pos=1;
for i=1:2:length(time)-1
    th=floor((time(i+1)+time(i))/2);
    if (d(th)<0)
      [value,temppos]=max(d(time(i):th));
      Rpos(pos)=temppos+time(i)-1;
      pos=pos+1;
    else
        [value,temppos]=max(d(time(i):time(i+1)));
        Rpos(pos)=temppos+time(i)-1;
        pos=pos+1; 
    end
end


count=1;
cnt=1;
Rpeak=[344 808 1270 1716 2170 2630 3090 3513 3956 4409 4858 5300 5759 6222 6680 7122 7565 7987 8413 8844 9286 9726 10170 10620 11070 11510 11970 12430 12860 13300];
for i=1:length(Rpeak)
     for j=1:100;
           if (d(Rpeak(i)-j)<=0)  
              start(count)=Rpeak(i)-j;
              count=count+1;
              break;
           end
     end       
end

for i=1:length(Rpeak)
     for j=1:100;
     
           if (d(Rpeak(i)+j)<=0)
              finsh(cnt)=Rpeak(i)+j;
              cnt=cnt+1;
              break;
           end
     end       
end

% plot(d)
nn=zeros(length(d),1);
% hold on
% plot(nn)
x=[zeros(1,35),1,zeros(1,35)];
a=polyfit([-35:35],x,4) ;
nn=polyval(a,[-35:35]) ;
fb=(0.1).*[1,1,1,1,1,1,1,1,1,1,1];
fa=[1,0,0,0,0,0,0,0,0,0,0];%½×Êý´ý½â¾ö

st1=filter(fb,fa,d);
[m,n]=size(start);


for i=1:n
    for j=start(i):finsh(i)
        st1(j+5)=d(j);               %offset is 5 (length(fb)-1)/2
    end
end


sw1=filter(fb,fa,st1);
sw1=filter(fb,fa,sw1);
sw1=filter(fb,fa,sw1);
sw1=filter(fb,fa,sw1);
sw1=filter(fb,fa,sw1);
sw1=filter(fb,fa,sw1);
sw1=filter(fb,fa,sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);
sw1=smooth(sw1);

f2=nn;
st=filter(f2,1,sw1);
sw=filter(f2,1,st);
sw=filter(f2,1,sw);
sw=filter(f2,1,sw);
sw=filter(f2,1,sw);
sw=filter(f2,1,sw);
sw=filter(f2,1,sw);
sw=filter(f2,1,sw);



