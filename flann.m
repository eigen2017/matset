clear all
clc

a = zeros(86,1);

b = ones(51,1);

b = 20972 * b;

c = zeros(5027,1);

standard = [a' b' c'];

standard = standard/6990;

s = textread('F:\test\1489038577457\ecgnotfilter.data','%f');

s = s(10890:22980);

u = length(standard);

s = s(1:u);

s = s/6990;
%flann各参数的设定
%W初始化
W = [0.01 0.01 0.01 0.01 0.01 0.01];
%W =cell(u,1);
%W{1} = [0.01 0.01 0.01 0.01 0.01 0.01];
%W{2} = [0.01 0.01 0.01 0.01 0.01 0.01];
%W{3} = [0.01 0.01 0.01 0.01 0.01 0.01];

%学习因子初始化
study = 0.03;
b = 0;
%输入信号的设定
X = cell(u,1);
     Z = zeros(u,1);
e =zeros(u,1);
X{1} = [s(1), 0, 0, 0, 0, 0];
count = 0;
for i = 3:u - 1
     X{i} = [s(i), s(i-1), s(i-2) , Z(i), Z(i-1), Z(i-2)];
        
        Z(i) = W * (X{i})' + b;
       % Z(i) = W{i} * (X{i})' + b;
        
        e(i) = standard(i) - Z(i);
        
        count =count + 1;
        
        if abs(e(i)) < 0.0000001
            break;
        end
        
        W = W + study * X{i} * e(i);
        %W{i+1} = W{i} + study * X{i} * e(i);
        
        b = b + study * e(i);
end


     



