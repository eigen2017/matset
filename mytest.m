clear all
clc

y=textread('F:\ce\ecgatr.data','%f');
yy=textread('F:\ce\ecgatrann.data','%f');
for i=1:33
    rr(i)= y(i+1)-y(i)
end