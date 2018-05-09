clf
clear all
A = load('F:\心纹识别\实验数据\数据一\Rpeak数据\Rpeak.txt');
B = load('F:\心纹识别\实验数据\数据二\Rpeak数据\Rpeak.txt');
C = load('F:\心纹识别\实验数据\数据三\Rpeak数据\Rpeak.txt');
D = load('F:\心纹识别\实验数据\数据四\Rpeak数据\Rpeak.txt');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
E = load('F:\心纹识别\实验数据\数据五\Rpeak数据\Rpeak.txt');
F = load('F:\心纹识别\实验数据\数据六\Rpeak数据\Rpeak.txt');
G = load('F:\心纹识别\实验数据\数据七\Rpeak数据\Rpeak.txt');
H = load('F:\心纹识别\实验数据\数据八\Rpeak数据\Rpeak.txt');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
J = load('F:\心纹识别\实验数据\数据十\Rpeak数据\Rpeak.txt');
I = load('F:\心纹识别\实验数据\数据九\Rpeak数据\Rpeak.txt');
K = load('F:\心纹识别\实验数据\数据十一\Rpeak数据\Rpeak.txt');
L = load('F:\心纹识别\实验数据\数据十二\Rpeak数据\Rpeak.txt');
M = load('F:\心纹识别\实验数据\数据十三\Rpeak数据\Rpeak.txt');
N = load('F:\心纹识别\实验数据\数据十四\Rpeak数据\Rpeak.txt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%
O = load('F:\心纹识别\实验数据\数据十五\Rpeak数据\Rpeak.txt');
P = load('F:\心纹识别\实验数据\数据十六\Rpeak数据\Rpeak.txt');
Q = load('F:\心纹识别\实验数据\数据十七\Rpeak数据\Rpeak.txt');

%数据归一化
Asize = size(A);
Bsize = size(B);
Csize = size(C);
Dsize = size(D);
%%%%%%%%%%%%%%%
Esize = size(E);
Fsize = size(F);
Gsize = size(G);
Hsize = size(H);
%%%%%%%%%%%%%
Isize = size(I);
Jsize = size(J);
Ksize = size(K);
Lsize = size(L);
Msize = size(M);
Nsize = size(N);
%%%%%%%%%%%%%
Osize = size(O);
Psize = size(P);
Qsize = size(Q);
for i = 1:Asize(1)
    for j = 1:Asize(2)
        AN(i,j)  = (A(i,j) - mean(A(i,:)))/Asize(2);
    end
end
for i = 1:Bsize(1)
    for j = 1:Bsize(2)
        BN(i,j)  = (B(i,j) - mean(B(i,:)))/Bsize(2);
    end
end
for i = 1:Csize(1)
    for j = 1:Csize(2)
        CN(i,j)  = (C(i,j) - mean(C(i,:)))/Csize(2);
    end
end
for i = 1:Dsize(1)
    for j = 1:Dsize(2)
        DN(i,j)  = (D(i,j) - mean(D(i,:)))/Dsize(2);
    end
end
%%%%%%%%%%%%%%%%%%%
for i = 1:Esize(1)
    for j = 1:Esize(2)
        EN(i,j)  = (E(i,j) - mean(E(i,:)))/Esize(2);
    end
end
for i = 1:Fsize(1)
    for j = 1:Fsize(2)
        FN(i,j)  = (F(i,j) - mean(F(i,:)))/Fsize(2);
    end
end
for i = 1:Gsize(1)
    for j = 1:Gsize(2)
        GN(i,j)  = (G(i,j) - mean(G(i,:)))/Gsize(2);
    end
end
for i = 1:Hsize(1)
    for j = 1:Hsize(2)
        HN(i,j)  = (H(i,j) - mean(H(i,:)))/Hsize(2);
    end
end
%%%%%%%%%%%%%%%%%%
for i = 1:Isize(1)
    for j = 1:Isize(2)
        IN(i,j)  = (I(i,j) - mean(I(i,:)))/Isize(2);
    end
end
for i = 1:Jsize(1)
    for j = 1:Jsize(2)
        JN(i,j)  = (J(i,j) - mean(J(i,:)))/Jsize(2);
    end
end
for i = 1:Ksize(1)
    for j = 1:Ksize(2)
        KN(i,j)  = (K(i,j) - mean(K(i,:)))/Ksize(2);
    end
end
for i = 1:Lsize(1)
    for j = 1:Lsize(2)
        LN(i,j)  = (L(i,j) - mean(L(i,:)))/Lsize(2);
    end
end
for i = 1:Msize(1)
    for j = 1:Msize(2)
        MN(i,j)  = (M(i,j) - mean(M(i,:)))/Msize(2);
    end
end
for i = 1:Nsize(1)
    for j = 1:Nsize(2)
        NN(i,j)  = (N(i,j) - mean(N(i,:)))/Nsize(2);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:Osize(1)
    for j = 1:Osize(2)
        ON(i,j)  = (O(i,j) - mean(O(i,:)))/Osize(2);
    end
end
for i = 1:Psize(1)
    for j = 1:Psize(2)
        PN(i,j)  = (P(i,j) - mean(P(i,:)))/Psize(2);
    end
end
for i = 1:Qsize(1)
    for j = 1:Qsize(2)
        QN(i,j)  = (Q(i,j) - mean(Q(i,:)))/Qsize(2);
    end
end
%训练数据
%train_data = [AN(1:60,:);BN(1:60,:);CN(1:60,:);DN(1:60,:)];
train_data = [AN(1:60,:);BN(1:60,:);CN(1:60,:);DN(1:60,:);IN(1:60,:);JN(1:60,:);KN(1:60,:);LN(1:60,:);MN(1:60,:);NN(1:60,:)];
%标签

for i = 1:60
    output(i,:) =[1 0 0 0 0 0 0 0 0 0];
end
for i = 61:120
    output(i,:) = [0 1 0 0 0 0 0 0 0 0];
end
for i = 121:180
    output(i,:) = [0 0 1 0 0 0 0 0 0 0];
end
for i = 181:240
    output(i,:) = [0 0 0 1 0 0 0 0 0 0];
end
for i = 241:300
    output(i,:) =[0 0 0 0 1 0 0 0 0 0];
end
for i = 301:360
    output(i,:) = [0 0 0 0 0 1 0 0 0 0];
end
for i = 361:420
    output(i,:) = [0 0 0 0 0 0 1 0 0 0];
end
for i = 421:480
    output(i,:) = [0 0 0 0 0 0 0 1 0 0];
end
for i = 481:540
    output(i,:) = [0 0 0 0 0 0 0 0 1 0];
end
for i = 541:600
    output(i,:) = [0 0 0 0 0 0 0 0 0 1];
end

%测试数据
test_data = [AN(61:end,:);BN(61:end,:);CN(61:end,:);DN(61:end,:)];
test_data1 = EN;
test_data2 = FN;
test_data3 = GN;
test_data4 = HN;
test_data5 = ON;
test_data6 = PN;
test_data7 = QN;
% %标签
% for i = 1:67
%     output2(i,:) =[1 0 0 0];
% end
% for i = 68:140
%     output2(i,:) = [0 1 0 0];
% end
% for i = 141:247
%     output2(i,:) = [0 0 1 0];
% end
% for i = 248:316
%     output2(i,:) = [0 0 1 0];
% end
    

% output1 = zeros(600,2);
%分类器1 区分第一类和其他类
for i = 1:60
    output1(i,:) =[1 0];
end
for i = 61:120
    output1(i,:) =[0 1];
end
%分类器2 区分第二类和其他类
for i = 1:60
    output2(i,:) =[1 0];
end
for i = 61:120
    output2(i,:) =[0 1];
end
%分类器3 区分第三类和其他类
for i = 1:60
    output3(i,:) =[1 0];
end
for i = 61:120
    output3(i,:) =[0 1];
end
%分类器4 区分第四类和其他类
for i = 1:60
    output4(i,:) =[1 0];
end
for i = 61:120
    output4(i,:) =[0 1];
end
%分类器5 区分第5类和其他类
for i = 1:60
    output5(i,:) =[1 0];
end
for i = 61:120
    output5(i,:) =[0 1];
end  
%分类器6 区分第6类和其他类
for i = 1:60
    output6(i,:) =[1 0];
end
for i = 61:120
    output6(i,:) =[0 1];
end 
%分类器7 区分第7类和其他类
for i = 1:60
    output7(i,:) =[1 0];
end
for i = 61:120
    output7(i,:) =[0 1];
end  
%分类器8 区分第8类和其他类
for i = 1:60
    output8(i,:) =[1 0];
end
for i = 61:120
    output8(i,:) =[0 1];
end  
%分类器9 区分第9类和其他类
for i = 1:60
    output9(i,:) =[1 0];
end
for i = 61:120
    output9(i,:) =[0 1];
end  
%训练集组合
trainData1  = [AN(1:60,:);BN(1:6,:);CN(1:6,:);DN(1:6,:);IN(1:6,:);JN(1:6,:);KN(1:6,:);LN(1:8,:);MN(1:8,:);NN(1:8,:)];
trainData2  = [BN(1:60,:);CN(1:8,:);DN(1:8,:);IN(1:8,:);JN(1:6,:);KN(1:6,:);LN(1:8,:);MN(1:8,:);NN(1:8,:)];
trainData3  = [CN(1:60,:);DN(1:8,:);IN(1:8,:);JN(1:8,:);KN(1:9,:);LN(1:9,:);MN(1:9,:);NN(1:9,:)];
trainData4  = [DN(1:60,:);IN(1:10,:);JN(1:10,:);KN(1:10,:);LN(1:10,:);MN(1:10,:);NN(1:10,:)];
trainData5  = [IN(1:60,:);JN(1:12,:);KN(1:12,:);LN(1:12,:);MN(1:12,:);NN(1:12,:)];
trainData6  = [JN(1:60,:);KN(1:15,:);LN(1:15,:);MN(1:15,:);NN(1:15,:)];
trainData7  = [KN(1:60,:);LN(1:20,:);MN(1:20,:);NN(1:20,:)];
trainData8  = [LN(1:60,:);MN(1:30,:);NN(1:30,:)];
trainData9  = [MN(1:60,:);NN(1:60,:)];
%用matlab自带的工具箱里的函数来进行预测过程  
%.................................................  
%设置参数  
  
net1 = newff(trainData1',output1',10,{'logsig' 'purelin'},'traingda');  
%%初始化  
net1=init(net1);  
%设置训练参数和训练BP网络  
net1.trainParam.epochs = 5000;  
net1.trainParam.goal = 0.000001;  
net1.trainParam.show = 10;  
net1.trainParam.lr = 0.001;  
net1 = train(net1,trainData1',output1');

net2 = newff(trainData2',output2',10,{'logsig' 'purelin'},'traingda');  
%%初始化  
net2=init(net2);  
%设置训练参数和训练BP网络  
net2.trainParam.epochs = 5000;  
net2.trainParam.goal = 0.000001;  
net2.trainParam.show = 10;  
net2.trainParam.lr = 0.001;  
net2 = train(net2,trainData2',output2');

net3 = newff(trainData3',output3',10,{'logsig' 'purelin'},'traingda');  
%%初始化  
net3=init(net3);  
%设置训练参数和训练BP网络  
net3.trainParam.epochs = 5000;  
net3.trainParam.goal = 0.000001;  
net3.trainParam.show = 10;  
net3.trainParam.lr = 0.001;  
net3 = train(net3,trainData3',output3');

net4 = newff(trainData4',output4',10,{'logsig' 'purelin'},'traingda');  
%%初始化  
net4=init(net4);  
%设置训练参数和训练BP网络  
net4.trainParam.epochs = 5000;  
net4.trainParam.goal = 0.000001;  
net4.trainParam.show = 10;  
net4.trainParam.lr = 0.001;  
net4 = train(net4,trainData4',output4');

net5 = newff(trainData5',output5',10,{'logsig' 'purelin'},'traingda');  
%%初始化  
net5=init(net5);  
%设置训练参数和训练BP网络  
net5.trainParam.epochs = 5000;  
net5.trainParam.goal = 0.000001;  
net5.trainParam.show = 10;  
net5.trainParam.lr = 0.001;  
net5 = train(net5,trainData5',output5');

net6 = newff(trainData6',output6',10,{'logsig' 'purelin'},'traingda');  
%%初始化  
net6=init(net6);  
%设置训练参数和训练BP网络  
net6.trainParam.epochs = 5000;  
net6.trainParam.goal = 0.000001;  
net6.trainParam.show = 10; 
net6.trainParam.lr = 0.001;  
net6 = train(net6,trainData6',output6');

net7 = newff(trainData7',output7',10,{'logsig' 'purelin'},'traingda');  
%%初始化  
net7=init(net7);  
%设置训练参数和训练BP网络  
net7.trainParam.epochs = 5000;  
net7.trainParam.goal = 0.000001;  
net7.trainParam.show = 10;  
net7.trainParam.lr = 0.001;  
net7 = train(net7,trainData7',output7');

net8 = newff(trainData8',output8',10,{'logsig' 'purelin'},'traingda');  
%%初始化  
net8=init(net8);  
%设置训练参数和训练BP网络  
net8.trainParam.epochs = 5000;  
net8.trainParam.goal = 0.000001;  
net8.trainParam.show = 10;  
net8.trainParam.lr = 0.001;  
net8 = train(net8,trainData8',output8');

net9 = newff(trainData9',output9',10,{'logsig' 'purelin'},'traingda');  
%%初始化  
net9=init(net9);  
%设置训练参数和训练BP网络  
net9.trainParam.epochs = 5000;  
net9.trainParam.goal = 0.000001;  
net9.trainParam.show = 10;  
net9.trainParam.lr = 0.001;  
net9 = train(net9,trainData9',output9');


% a = sim(net,test_data7');

a = sim(net5,test_data5');
outsize = size(test_data5);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              

for i = 1:outsize(1)
     output_forest(i) = find(a(:,i) == max(a(:,i)));  
end
cc = hist(output_forest,1:max(output_forest));
[maxcc,classdata] = max(cc);
