function [ adcDatReversedlist ] = GetReverseAdcDatList( adcDatlist )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

for m = 1:length(adcDatlist)
    adcDatReversedlist(m) = GetReverseAdcDat(adcDatlist(m));
end

end
