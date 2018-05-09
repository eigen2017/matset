fidin=fopen('C:\Users\pc20150817\Downloads\data.txt','r');

nline=1;

while ~feof(fidin)
    tline=fgetl(fidin); % 从文件读行
    xxx = strsplit(tline,',');
    for i = 1:length(xxx)-1
        mmmm(i) = str2num(xxx{1,i});
    end
    dataall{nline} = mmmm;
    nline=nline+1;
    clear mmmm
end
fclose(fidin);
