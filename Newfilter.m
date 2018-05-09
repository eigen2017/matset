% shennian=textread('F:\shanlinshennian.data','%f');
% shennian=-shennian';
shennian=x_3;
length_filter=320;
b=10;
buffer=zeros(10,10);
ss=zeros(10,10);

for j=1:10 
    i=j:b:100;
    buffer(j,:)=shennian(i);
end

for i=1:10
    j=1:10;
    SUM=sum(buffer(i,j));
    res(i)=SUM/10;
end
 


for j=1:10
    i=10+j:b:100+10;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
    ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    fin(i)=SUM/10;
end


for j=1:10
    i=10*2+j:b:100+10*2;
%      for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
     ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    tmt(i)=SUM/10;
end



for j=1:10
    i=10*3+j:b:100+10*3;
%      for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
    ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    fes(i)=SUM/10;
end

for j=1:10
    i=10*4+j:b:100+10*4;
%      for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
    ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    ese(i)=SUM/10;
end  

for j=1:10
    i=10*5+j:b:100+10*5;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
    ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    str(i)=SUM/10;
end   

for j=1:10
    i=10*6+j:b:100+10*6;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
    ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    tfk(i)=SUM/10;
end   

for j=1:10
    i=10*7+j:b:100+10*7;
%    for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
      ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    ygr(i)=SUM/10;
end   

for j=1:10
    i=10*8+j:b:100+10*8;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
     ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    utr(i)=SUM/10;
end   
       
for j=1:10
    i=10*9+j:b:100+10*9;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
     ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    cgh(i)=SUM/10;
end   

for j=1:10
    i=10*10+j:b:100+10*10;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
     ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    sfh(i)=SUM/10;
end   

for j=1:10
    i=10*11+j:b:100+10*11;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
     ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    khy(i)=SUM/10;
end 

for j=1:10
    i=10*12+j:b:100+10*12;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
     ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    bgy(i)=SUM/10;
end  

for j=1:10
    i=10*13+j:b:100+10*13;
%      for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
    ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    yui(i)=SUM/10;
end  

for j=1:10
    i=10*14+j:b:100+10*14;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
     ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    ugr(i)=SUM/10;
end  

for j=1:10
    i=10*15+j:b:100+10*15;
%      for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
    ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    opt(i)=SUM/10;
end  


for j=1:10
    i=10*16+j:b:100+10*16;
%      for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
    ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    ury(i)=SUM/10;
end

for j=1:10
    i=10*17+j:b:100+10*17;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
     ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    pyh(i)=SUM/10;
end  
for j=1:10
    i=10*18+j:b:100+10*18;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
     ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    cfp(i)=SUM/10;
end  

for j=1:10
    i=10*19+j:b:100+10*19;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
     ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    atd(i)=SUM/10;
end  

for j=1:10
    i=10*20+j:b:100+10*20;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
     ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    sgk(i)=SUM/10;
end  

for j=1:10
    i=10*21+j:b:100+10*21;
%    for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
      ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    kub(i)=SUM/10;
end  

for j=1:10
    i=10*22+j:b:100+10*22;
%      for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
    ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    lvg(i)=SUM/10;
end  

for j=1:10
    i=10*23+j:b:100+10*23;
%     for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
     ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    uvl(i)=SUM/10;
end  

for j=1:10
    i=10*24+j:b:100+10*24;
%    for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%     end
      ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    hnf(i)=SUM/10;
end  

for j=1:10
    i=10*25+j:b:100+10*25;
%    for m=1:10
%     ss(j,m)=median(shennian(i(m)-5:i(m)+5));
%    end
      ss(j,:)=shennian(i);
end
for i=1:10
    j=1:10;
    SUM=sum(ss(i,j));
    tsk(i)=SUM/10;
end 
