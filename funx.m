function [ fx] = funx( x )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
w=0.1953*pi;
fx=(1+x)*sqrt(((1-x*cos(8*w)+x*cos(8*w)*cos(8*w)-cos(8*w)+x*sin(8*w)*sin(8*w))/((1-x*cos(8*w))^2-sin(8*w)*sin(8*w)))^2+(((x-1)*sin(8*w))/((1-x*cos(8*w))^2-sin(8*w)*sin(8*w)))^2)-0.01;


end

