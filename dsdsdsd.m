
mypath = 'C:\Users\pc20150817\Documents\Tencent Files\1181672105\FileRecv\ECG市一医院0058--0071\ECG\ecgdata\1506073835684000\';
sss=textread([mypath 'ecgfilter.data'],'%f');
atr=textread([mypath 'ecgatr.data'],'%f');
ann=textread([mypath 'ecgatrann.data'],'%f');
%nof = textread([mypath 'ecgnotfilter.data'],'%f');
plot(sss)

hold on
for i=1:length(ann)
 if ann(i) == 30
     hold on
     plot(atr(i)+1,sss(atr(i)+1), 'r^');
 end
 
 if ann(i) == 14
     hold on
     plot(atr(i)+1,sss(atr(i)+1), 'k^');
 end 
 if ann(i) == 1
    hold on
    plot(atr(i)+1,sss(atr(i)+1), 'g^'); 
 end
end                         