dird = 'E:\PHY\12lea\';
dirs=dir('E:\PHY\12lea\*.atr'); 
dircell=struct2cell(dirs);
todir = 'F:\12lead10min\';

for i = 75:75
    dest = [dird dircell{1,i}(1:3)];
    todest = [todir dircell{1,i}(1:3) '.txt' ];
    [tm,sig]=rdsamp( dest,[],10*60*257); 
    dlmwrite(todest,sig, ',');
    clear tm
    clear sig
end