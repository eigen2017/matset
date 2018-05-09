%%对环境和数据进行预处理  
%%...................................................  
%%清除环境变量  
clc  
clear  
%%导入数据  
N=load('F:\seeds_dataset.txt');  
%%对于导入的数据进行分组  
date1=[N(1:14,:);N(85:98,:);N(183:196,:)]';  
date2=[N(29:42,:);N(71:84,:);N(141:154,:)]';  
date3=[N(15:28,:);N(99:112,:);N(155:168,:)]';  
date4=[N(57:70,:);N(127:140,:);N(197:210,:)]';  
date5=[N(43:56,:);N(113:126,:);N(169:182,:)]';  
%%对于分组的数据进行合并成一个新的数组，具体的顺序任意  
data=[date2,date1,date3,date4,date5]';  
%%输入输出数据，提取前7列和第8列的内容单独成一个矩阵  
input=data(:,1:7);  
output=data(:,8);  
%%提取出矩阵后，由于输出的矩阵是3维的因此要变换成3维的形式  
for i=1:210  
   switch output(i)  
         case 1  
              output1(i,:)=[1 0 0];  
         case 2  
              output1(i,:)=[0 1 0];  
         case 3  
              output1(i,:)=[0 0 1];  
   end  
end  
%%对输入的矩阵处理完输入的形式了，接下来就是划分训练和测试集  
input_train=input(1:168,:)';  
output_train=output1(1:168,:)';  
input_test=input(169:210,:)';  
output_test=output1(169:210,:)';  
%%对数据进行归一化处理  
[inputn,inputps]=mapminmax(input_train);  
  
%%.................................................  
%%用matlab自带的工具箱里的函数来进行预测过程  
%%.................................................  
%%设置参数  
  
net=newff(input_train,output_train,5,{'logsig' 'purelin'},'traingda');  
%%初始化  
net=init(net);  
%%设置训练参数和训练BP网络  
net.trainParam.epochs = 5000;  
net.trainParam.goal = 0.0001;  
net.trainParam.show = 10;  
net.trainParam.lr=0.01;  
  
%%训练BP神经网络  
net = train(net,input_train,output_train);  
  
a = sim(net,input_test);   
for i=1:42  
    output_fore(i)=find(a(:,i)==max(a(:,i)));  
end  
%%BP训练结束  
  
%BP网络预测误差  
error=output_fore-output(169:210)';  
  
%%................................................  
figure(1)  
plot(output_fore,'-. r *')  
hold on  
plot(output(169:210)',' -.b p')  
legend('预测类别编号','实际类别编号')  
  
%画出误差图  
figure(2)  
plot(error)  
title('BP网络分类误差','fontsize',12)  
xlabel('机器学习特性','fontsize',12)  
ylabel('分类误差','fontsize',12)  
  
k=zeros(1,3);    
  
%找出判断错误的分类属于哪一类  
for i=1:42  
    if error(i)~=0  
        [b,c]=max(output_test(:,i));  
        switch c  
            case 1   
                k(1)=k(1)+1;  
            case 2   
                k(2)=k(2)+1;  
            case 3   
                k(3)=k(3)+1;  
        end  
    end  
end  
  
%找出每类的个体和  
kk=zeros(1,3);  
for i=1:42  
    [b,c]=max(output_test(:,i));  
    switch c  
        case 1  
            kk(1)=kk(1)+1;  
        case 2  
            kk(2)=kk(2)+1;  
        case 3  
            kk(3)=kk(3)+1;  
    end  
end  
  
%正确率  
right_rate5 = (kk-k)./kk;
