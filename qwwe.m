index =  [];
n=1;
for i = 1:3588
    m = 1;
    B = (dd(i,:)~=0);
    KKK = sum(B(:));
    count14 = 0;
    for j = 2:KKK
        if dd(i,j)==14;
            count14 = count14 + 1;
        end
    end
        
    for j = 2:KKK
        
        if dd(i,j) == 0
            continue;
        end
        if dd(i,j)~=14
            index(m) = j;
         
        else
            if (m-1)>0
                xx =m-1;
            else
                if m==1
                    continue;
                else
                   xx =1;
                end
            end
           if cc(i,index(xx))-cc(i,index(1))>5120&&(cc(i,index(1))+5120<length(b{i}))
               data{n} = b{i}(cc(i,index(1))+1:cc(i,index(1))+5120);
               data{n}(5121)=b{i}(1);
               n = n+1;
               m = 1;
               index = [];
               continue;
           else
               m = 1;
               index = [];
               continue;
           end
        end
        if m == KKK - 2 - count14 &&(cc(i,index(1))+5120<length(b{i}));
            data{n} = b{i}(cc(i,index(1))+1:cc(i,index(1))+5120);
            data{n}(5121)=b{i}(1);
            n = n + 1;
            m = 1;
            continue;
        end
        m = m + 1;
    end     
    index = [];
end
for i = 1:3213
    csvdata(i,:)=data{i};
end

aaa = csvdata(:,5121);


j = 1;

for i = 1:length(aaa)
    if i == 1
        bbb(i) = 1;
    else if aaa(i) ~= aaa(i-1)
       j = j +1;
        end
    end
    if i ~= 1
        bbb(i) = j;
    end
end

copyc=c;

j=1;
for i = 2:2001
    if i==2
        testcnn(j,:)=c(i,:);
        copyc(i,:)=zeros(1,5121);
        j=j+1;
        continue;
    end
    if c(i,5121)~=c(i-1,5121)&&aaaaaa(c(i,5121)+1,2)>1
        testcnn(j,:)=c(i,:);
        copyc(i,:)=zeros(1,5121);
        j=j+1;
    end
end
  d=b;    
for i =2:217
    for j=1:5120
        d(i,j)=b(i,j)/max(abs(b(i,1:5120)));
    end
end
for i = 1:length(noc)
    plot(d(loc(i),1:5120))
    hold on
end
for i = 1:3180
    csvdata(i,5121)=bbb(i)-1;
end

for i =1:3180
    for j=1:5120
        mina=min(csvdata(i,1:5120));
        maxa=max(csvdata(i,1:5120));
        d(i,j)=(csvdata(i,j)-mina)/(maxa-mina);
    end
end