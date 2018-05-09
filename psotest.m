
%------基本粒子群优化算法（Particle?Swarm?Optimization）-----------?
%------名称：基本粒子群优化算法（PSO）
clear all;
clc;
format long;

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
%------给定初始化条件----------------------------------------------?
c1 = 1.4962;  %学习因子1
c2 = 1.4962;  %学习因子2
w = 0.7298;   %惯性权重初始化

MaxDT = 2000; %最大迭代次数
D = 6;       %搜索空间维数（未知数个数）
N = 40;       %初始化群体个体数目
eps = 10^(-6);%设置精度(在已知最小值时候用)

%------初始化种群的个体(可以在这里限定位置和速度的范围)------------
for i = 1:N
     for j = 1:D
         x(i,j) = randn;    %随机初始化位置
         v(i,j) = randn;    %随机初始化速度
     end
end
x(1,:) = [0.3671    0.1719    0.0278    0.0100   -0.1379   -0.1377];
%------先计算各个粒子的适应度，并初始化Pi和Pg----------------------
 for i=1:N
      C = filter(x(i,4:6), x(i,1:3),s);
      %p(i) = fitness(x(i,:),D);
      C = C';
      p(i)  = fitness(C,standard);
      y(i,:) = x(i,:); 
  end
pg = x(1,:);               %Pg为全局最优
for i = 2:N
    M = filter(x(i,4:6), x(i,1:3),s);
      %p(i) = fitness(x(i,:),D);
      M = M';
      L = filter(pg(4:6), pg(1:3),s);
      %p(i) = fitness(x(i,:),D);
      L = L';
     if fitness(M,standard) < fitness(L,standard)
         pg = x(i,:);
     end
end

%------进入主要循环，按照公式依次迭代，直到满足精度要求------------
for t = 1:MaxDT
    for i = 1:N
        v(i,:) = w * v(i,:) + c1 * rand * (y(i,:) - x(i,:)) + c2 * rand * (pg-x(i,:));
        x(i,:) = x(i,:) + v(i,:);
        M = filter(x(i,4:6), x(i,1:3),s);
      %p(i) = fitness(x(i,:),D);
        M = M';
        if fitness(M,standard) < p(i)
            p(i) = fitness(M,standard);
            y(i,:) = x(i,:);
        end
        L = filter(pg(4:6), pg(1:3),s);
      %p(i) = fitness(x(i,:),D);
        L = L';
        if p(i) < fitness(L,standard)
            pg = y(i,:);
        end
    end
      Q = filter(x(i,4:6), x(i,1:3),s);
      %p(i) = fitness(x(i,:),D);
      Q = Q';
    Pbest(t) = fitness(Q,standard);
end

%------最后给出计算结果
disp('*************************************************************')
disp('函数的全局最优位置为：')
Solution = pg';
disp('最后得到的优化极值为：')
%Result = fitness(pg,D);
