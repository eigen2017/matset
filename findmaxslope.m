function [ location ] = findmaxslope( Array )
%findmaxslope �˴���ʾ�йش˺�����ժҪ
%   �ҳ�б�ʾ���ֵ��С�ĵ�
  oneOrder = diff(Array);
  %SecondOrder = diff(oneOrder);
  [minvalue,locations] = min(abs(oneOrder));
  location = locations(length(locations)) + 1; 


end

