%%�Ի��������ݽ���Ԥ����  
%%...................................................  
%%�����������  
clc  
clear  
%%��������  
N=load('F:\seeds_dataset.txt');  
%%���ڵ�������ݽ��з���  
date1=[N(1:14,:);N(85:98,:);N(183:196,:)]';  
date2=[N(29:42,:);N(71:84,:);N(141:154,:)]';  
date3=[N(15:28,:);N(99:112,:);N(155:168,:)]';  
date4=[N(57:70,:);N(127:140,:);N(197:210,:)]';  
date5=[N(43:56,:);N(113:126,:);N(169:182,:)]';  
%%���ڷ�������ݽ��кϲ���һ���µ����飬�����˳������  
data=[date2,date1,date3,date4,date5]';  
%%����������ݣ���ȡǰ7�к͵�8�е����ݵ�����һ������  
input=data(:,1:7);  
output=data(:,8);  
%%��ȡ���������������ľ�����3ά�����Ҫ�任��3ά����ʽ  
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
%%������ľ��������������ʽ�ˣ����������ǻ���ѵ���Ͳ��Լ�  
input_train=input(1:168,:)';  
output_train=output1(1:168,:)';  
input_test=input(169:210,:)';  
output_test=output1(169:210,:)';  
%%�����ݽ��й�һ������  
[inputn,inputps]=mapminmax(input_train);  
  
%%.................................................  
%%��matlab�Դ��Ĺ�������ĺ���������Ԥ�����  
%%.................................................  
%%���ò���  
  
net=newff(input_train,output_train,5,{'logsig' 'purelin'},'traingda');  
%%��ʼ��  
net=init(net);  
%%����ѵ��������ѵ��BP����  
net.trainParam.epochs = 5000;  
net.trainParam.goal = 0.0001;  
net.trainParam.show = 10;  
net.trainParam.lr=0.01;  
  
%%ѵ��BP������  
net = train(net,input_train,output_train);  
  
a = sim(net,input_test);   
for i=1:42  
    output_fore(i)=find(a(:,i)==max(a(:,i)));  
end  
%%BPѵ������  
  
%BP����Ԥ�����  
error=output_fore-output(169:210)';  
  
%%................................................  
figure(1)  
plot(output_fore,'-. r *')  
hold on  
plot(output(169:210)',' -.b p')  
legend('Ԥ�������','ʵ�������')  
  
%�������ͼ  
figure(2)  
plot(error)  
title('BP����������','fontsize',12)  
xlabel('����ѧϰ����','fontsize',12)  
ylabel('�������','fontsize',12)  
  
k=zeros(1,3);    
  
%�ҳ��жϴ���ķ���������һ��  
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
  
%�ҳ�ÿ��ĸ����  
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
  
%��ȷ��  
right_rate5 = (kk-k)./kk;
