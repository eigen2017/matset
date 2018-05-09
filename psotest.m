
%------��������Ⱥ�Ż��㷨��Particle?Swarm?Optimization��-----------?
%------���ƣ���������Ⱥ�Ż��㷨��PSO��
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
%------������ʼ������----------------------------------------------?
c1 = 1.4962;  %ѧϰ����1
c2 = 1.4962;  %ѧϰ����2
w = 0.7298;   %����Ȩ�س�ʼ��

MaxDT = 2000; %����������
D = 6;       %�����ռ�ά����δ֪��������
N = 40;       %��ʼ��Ⱥ�������Ŀ
eps = 10^(-6);%���þ���(����֪��Сֵʱ����)

%------��ʼ����Ⱥ�ĸ���(�����������޶�λ�ú��ٶȵķ�Χ)------------
for i = 1:N
     for j = 1:D
         x(i,j) = randn;    %�����ʼ��λ��
         v(i,j) = randn;    %�����ʼ���ٶ�
     end
end
x(1,:) = [0.3671    0.1719    0.0278    0.0100   -0.1379   -0.1377];
%------�ȼ���������ӵ���Ӧ�ȣ�����ʼ��Pi��Pg----------------------
 for i=1:N
      C = filter(x(i,4:6), x(i,1:3),s);
      %p(i) = fitness(x(i,:),D);
      C = C';
      p(i)  = fitness(C,standard);
      y(i,:) = x(i,:); 
  end
pg = x(1,:);               %PgΪȫ������
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

%------������Ҫѭ�������չ�ʽ���ε�����ֱ�����㾫��Ҫ��------------
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

%------������������
disp('*************************************************************')
disp('������ȫ������λ��Ϊ��')
Solution = pg';
disp('���õ����Ż���ֵΪ��')
%Result = fitness(pg,D);
