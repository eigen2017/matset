y=textread('C:\Users\pc20150817\Downloads\hp\hp\yechunyi\1\ecgfilter.data','%f');
atr= textread('C:\Users\pc20150817\Downloads\hp\hp\yechunyi\1\ecgatr.data','%f');
ann=textread('C:\Users\pc20150817\Downloads\hp\hp\yechunyi\1\ecgatrann.data','%f');
y1=textread('C:\Users\pc20150817\Downloads\hp\hp\yechunyi\2\ecgfilter.data','%f');
atr1= textread('C:\Users\pc20150817\Downloads\hp\hp\yechunyi\2\ecgatr.data','%f');
ann1=textread('C:\Users\pc20150817\Downloads\hp\hp\yechunyi\2\ecgatrann.data','%f');
j = 0;
for i = 1:length(ann1)
     if(ann1(i) == 30 || ann1(i) == 1)
         a20(j*256+1:(j+1)*256) = y1(atr1(i)-128:atr1(i)+127);
         j = j + 1;
         if (j == 30)
             break;
         end
     end
end
for i =1:20
    for j =1:30
        A = a(i, (j-1)*256+1:j*256);
        Amean = mean(A);
        Astd = std(A);
        for k = 1:256
            A(k)=(A(k)-Amean)/Astd;
        end
        a(i, (j-1)*256+1:j*256) = A;
    end
end


    