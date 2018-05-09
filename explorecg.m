
clear all
clc

%x=textread('F:\ecgfilter.data','%f');d
mypath = 'F:\nanyi4\1024\¡ı—‡ƒœ\';
x=textread([mypath 'ecgfilter.data'],'%f');
atr=textread([mypath 'ecgatr.data']);
ann=textread([mypath 'ecgatrann.data']);
figure
plot(x);
hold on;

for i=1:length(ann)
if ann(i) == 30
    plot(atr(i)+1,x(atr(i)+1), 'r^');
end

if ann(i) == 14
    plot(atr(i)+1,x(atr(i)+1), 'k^');
end

if ann(i) == 1
    plot(atr(i)+1,x(atr(i)+1), 'g^');
end


end


x=x';
x=filter(gogogo,x);
B=1000*ones(1,100);
PE=x-open_operation(x,B,length(x),50);

VE=x-closed_operation(x,B,length(x),50);
PVE=PE+VE;
PE=PVE-open_operation(PVE,B,length(PVE),50);
VE=PVE-closed_operation(PVE,B,length(PVE),50);
PVE=PE+VE;
PE=PVE-open_operation(PVE,B,length(PVE),50);
countM=zeros(1,length(x));

extrMaxIndex = find(diff(sign(diff(PE)))==-2)+1;
countM(extrMaxIndex)=1;

the=max(PE(1+5500:1024+5500));
for i=1:length(extrMaxIndex)
    if PE(extrMaxIndex(i))<=the/9
        countM(extrMaxIndex(i))=0;
    end
end
area=512*60/215;
P=find(countM);
count=0;
flag=1;
if(count==0||max(flag)==1)
    
len=length(P);
flag=zeros(1,len);
for i=2:len-1
    if flag(i)==0
        if P(i) - P( i-1) < area
              if PE( P( i) ) < PE( P( i-1) )
                  flag(i)=1;
              else
                  flag(i-1)=1;
              end
        end
        if i>2
            if P(i) - P( i-2) < area
                if PE(P(i))<PE(P(i-2))
                    flag(i)=1;
                else
                    flag(i-2)=1;
                end
            end
        end
         if i>3
            if P(i) - P( i-3) < area
                if PE(P(i))<PE(P(i-3))
                    flag(i)=1;
                else
                    flag(i-3)=1;
                end
            end
         end
         if i>4
            if P(i) - P( i-4) < area
                if PE(P(i))<PE(P(i-4))
                    flag(i)=1;
                else
                    flag(i-4)=1;
                end
            end
         end
          if i>5
            if P(i) - P( i-5) < area
                if PE(P(i))<PE(P(i-5))
                    flag(i)=1;
                else
                    flag(i-5)=1;
                end
            end
         end
        
        if P(i+1)-P(i)<area
            if PE(P(i))<PE(P(i+1))
                flag(i)=1;
            else
                flag(i+1)=1;
            end
        end
    end
end
P(flag==1)=[];

end

% plot(x)
% hold on
% plot(PE)
% 
% figure
% plot(x)
% hold on
% plot(VE)