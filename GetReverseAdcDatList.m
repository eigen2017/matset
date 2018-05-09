function [ adcDatReversedlist ] = GetReverseAdcDatList( adcDatlist )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明

for m = 1:length(adcDatlist)
    adcDatReversedlist(m) = GetReverseAdcDat(adcDatlist(m));
end

end
