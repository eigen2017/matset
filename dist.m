function [ DISTANCE ] = dist( XS,XE,X )
%dist此处显示有关此函数的摘要
%   此处显示详细说明
%  XS,XE两个点，用来确定直线L
%  XS，XE都为一个长度为2的一维数组，XS(1),XS(2)分别代表横纵坐标
% X表示坐标系中的一个点
%DISTANCE表示求点X到直线L的距离
%两点XS,XE表示的直线为 y-XS(2)=(XE(2)-XS(2))/(XE(1)-XS(1))(x-XS(1))
A = (XE(2)-XS(2))/(XE(1)-XS(1));
DISTANCE = abs(A*(X(1)-XS(1))+XS(2)-X(2))/sqrt(1+A*A);
end

