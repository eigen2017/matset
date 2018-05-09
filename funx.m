function [ fx] = funx( x )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
w=0.1953*pi;
fx=(1+x)*sqrt(((1-x*cos(8*w)+x*cos(8*w)*cos(8*w)-cos(8*w)+x*sin(8*w)*sin(8*w))/((1-x*cos(8*w))^2-sin(8*w)*sin(8*w)))^2+(((x-1)*sin(8*w))/((1-x*cos(8*w))^2-sin(8*w)*sin(8*w)))^2)-0.01;


end

