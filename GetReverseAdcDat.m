function [ adcDatReversed ] = GetReverseAdcDat( adcDat )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
realMV = (adcDat/8388608-0.5)*4800/3.5;
realMV = 0 - realMV;
adcDatReversed = (3.5*realMV/4800+0.5)*8388608;

end

