clf
clear all
A = load('F:\����ʶ��\ʵ������\����ʮ��\Rpeak����\Rpeak.txt');%%����
B = load('F:\����ʶ��\ʵ������\����ʮ��\Rpeak����\Rpeak.txt');%%̷��
C = load('F:\����ʶ��\ʵ������\���ݶ�ʮ\Rpeak����\Rpeak.txt');%%��
D = load('F:\����ʶ��\ʵ������\���ݶ�ʮһ\Rpeak����\Rpeak.txt');%%����ϼ
E = load('F:\����ʶ��\ʵ������\���ݶ�ʮ��\Rpeak����\Rpeak.txt');%%����
F = load('F:\����ʶ��\ʵ������\���ݶ�ʮ��\Rpeak����\Rpeak.txt');%%SAM
G = load('F:\����ʶ��\ʵ������\���ݶ�ʮ��\Rpeak����\Rpeak.txt');%%ALPH
H = load('F:\����ʶ��\ʵ������\���ݶ�ʮ��\Rpeak����\Rpeak.txt');%%����
%���ݹ�һ��
Asize = size(A);
Bsize = size(B);
Csize = size(C);
Dsize = size(D);
Esize = size(E);
Fsize = size(F);
Gsize = size(G);
Hsize = size(H);
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
%������1 ���ֵ�һ���������
for i = 1:40
    output1(i,:) =[1 0];
end
for i = 41:80
    output1(i,:) =[0 1];
end
%������2 ���ֵڶ����������
for i = 1:40
    output2(i,:) =[1 0];
end
for i = 41:80
    output2(i,:) =[0 1];
end
%������3 ���ֵ������������
for i = 1:40
    output3(i,:) =[1 0];
end
for i = 41:80
    output3(i,:) =[0 1];
end
%������4 ���ֵ������������
for i = 1:40
    output4(i,:) =[1 0];
end
for i = 41:80
    output4(i,:) =[0 1];
end
%������5 ���ֵ�5���������
for i = 1:40
    output5(i,:) =[1 0];
end
for i = 41:80
    output5(i,:) =[0 1];
end  
%������6 ���ֵ�6���������
for i = 1:40
    output6(i,:) =[1 0];
end
for i = 41:80
    output6(i,:) =[0 1];
end 
%������7 ���ֵ�7���������
for i = 1:40
    output7(i,:) =[1 0];
end
for i = 41:80
    output7(i,:) =[0 1];
end  
trainData1  = [AN(1:40,:);BN(1:6,:);CN(1:6,:);DN(1:6,:);EN(1:6,:);FN(1:6,:);GN(1:6,:);HN(1:4,:)];
trainData2  = [BN(1:40,:);CN(1:8,:);DN(1:6,:);EN(1:7,:);FN(1:6,:);GN(1:6,:);HN(1:7,:)];
trainData3  = [CN(1:40,:);DN(1:8,:);EN(1:8,:);FN(1:8,:);GN(1:8,:);HN(1:8,:)];
trainData4  = [DN(1:40,:);EN(1:10,:);FN(1:10,:);GN(1:10,:);HN(1:10,:)];
trainData5  = [EN(1:40,:);FN(1:13,:);GN(1:14,:);HN(1:13,:)];
trainData6  = [FN(1:40,:);GN(1:20,:);HN(1:20,:)];
trainData7  = [GN(1:40,:);HN(1:40,:)];
net1 = newff(trainData1',output1',10,{'logsig' 'purelin'},'traingda');  
%%��ʼ��  
net1=init(net1);  
%����ѵ��������ѵ��BP����  
net1.trainParam.epochs = 5000;  
net1.trainParam.goal = 0.000001;  
net1.trainParam.show = 10;  
net1.trainParam.lr = 0.001;  
net1 = train(net1,trainData1',output1');

net2 = newff(trainData2',output2',10,{'logsig' 'purelin'},'traingda');  
%%��ʼ��  
net2=init(net2);  
%����ѵ��������ѵ��BP����  
net2.trainParam.epochs = 5000;  
net2.trainParam.goal = 0.000001;  
net2.trainParam.show = 10;  
net2.trainParam.lr = 0.001;  
net2 = train(net2,trainData2',output2');

net3 = newff(trainData3',output3',10,{'logsig' 'purelin'},'traingda');  
%%��ʼ��  
net3=init(net3);  
%����ѵ��������ѵ��BP����  
net3.trainParam.epochs = 5000;  
net3.trainParam.goal = 0.000001;  
net3.trainParam.show = 10;  
net3.trainParam.lr = 0.001;  
net3 = train(net3,trainData3',output3');

net4 = newff(trainData4',output4',10,{'logsig' 'purelin'},'traingda');  
%%��ʼ��  
net4=init(net4);  
%����ѵ��������ѵ��BP����  
net4.trainParam.epochs = 5000;  
net4.trainParam.goal = 0.000001;  
net4.trainParam.show = 10;  
net4.trainParam.lr = 0.001;  
net4 = train(net4,trainData4',output4');

net5 = newff(trainData5',output5',10,{'logsig' 'purelin'},'traingda');  
%%��ʼ��  
net5=init(net5);  
%����ѵ��������ѵ��BP����  
net5.trainParam.epochs = 5000;  
net5.trainParam.goal = 0.000001;  
net5.trainParam.show = 10;  
net5.trainParam.lr = 0.001;  
net5 = train(net5,trainData5',output5');

net6 = newff(trainData6',output6',10,{'logsig' 'purelin'},'traingda');  
%%��ʼ��  
net6=init(net6);  

%����ѵ��������ѵ��BP����  
net6.trainParam.epochs = 5000;  
net6.trainParam.goal = 0.000001;  
net6.trainParam.show = 10; 
net6.trainParam.lr = 0.001;  
net6 = train(net6,trainData6',output6');

net7 = newff(trainData7',output7',10,{'logsig' 'purelin'},'traingda');  
%%��ʼ��  
net7=init(net7);  
%����ѵ��������ѵ��BP����  
net7.trainParam.epochs = 5000;  
net7.trainParam.goal = 0.000001;  
net7.trainParam.show = 10;  
net7.trainParam.lr = 0.001;  
net7 = train(net7,trainData7',output7');
testa = AN(41:end,:);
testb = BN(41:end,:);
testc = CN(41:end,:);
testd = DN(41:end,:);
teste = EN(41:end,:);
testf = FN(41:end,:);
testg = GN(41:end,:);
testh = HN(41:end,:);

a = sim(net2,testb');
outsize = size(testb);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              

for i = 1:outsize(1)
     output_forest(i) = find(a(:,i) == max(a(:,i)));  
end
cc = hist(output_forest,1:max(output_forest));
[maxcc,classdata] = max(cc);
