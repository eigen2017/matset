fid = fopen('C:\Users\pc20150817\Downloads\rm460.ecg_mat3.csv');
name = textscan(fid, '%s %*[^\n]');
fclose(fid);
b = cell(3107,1);
for i = 1:3107
    a=name{1,1}{i,1};
    b{i}=str2num(a);
end

for i = 1:3017
    c{i}=b{i}(2:end);
end

cc=dlmread('C:\Users\pc20150817\Downloads\atr_mat2.csv');
dd=dlmread('C:\Users\pc20150817\Downloads\atrann_mat2.csv');

index =  [];

n=1;
for i = 1:10
    m = 1;
    B = (dd(i,:)~=0);
    KKK = sum(B(:));
    count14 = 0;
    for j = 2:KKK
        if dd(i,j)==14||dd(i,j)==42;
            count14 = count14 + 1;
        end
    end
        
    for j = 2:KKK
        if dd(i,j) == 0
            continue;
        end
        if dd(i,j)~=14||dd(i,j)~=42
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