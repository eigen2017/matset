function [ DISTANCE ] = dist( XS,XE,X )
%dist�˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%  XS,XE�����㣬����ȷ��ֱ��L
%  XS��XE��Ϊһ������Ϊ2��һά���飬XS(1),XS(2)�ֱ�����������
% X��ʾ����ϵ�е�һ����
%DISTANCE��ʾ���X��ֱ��L�ľ���
%����XS,XE��ʾ��ֱ��Ϊ y-XS(2)=(XE(2)-XS(2))/(XE(1)-XS(1))(x-XS(1))
A = (XE(2)-XS(2))/(XE(1)-XS(1));
DISTANCE = abs(A*(X(1)-XS(1))+XS(2)-X(2))/sqrt(1+A*A);
end

