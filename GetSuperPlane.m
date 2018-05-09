function [ trained_super_plane ] = GetSuperPlane( train_path )

mypath = train_path;
 
% mydir=uigetdir('f:','选择一个目录');
mydir=mypath;%[mydir,'\'];

DIRS=dir([mydir,'*']);
n=length(DIRS);
% allvect = cell(1,n-2);
allvect = zeros(n-2,28);
AFresult = zeros(1,n-2);
for ii = 1:n
%     if(ii == 191)
%         ssssssss=122;
%     end
    
if (length(DIRS(ii).name) < 3)
    continue;
end
myPath = [mypath,DIRS(ii).name,'\'];
Afcorrect = [myPath,'correct.txt'];
fid=fopen(Afcorrect,'r');
% if(ii == 191)
%     bbb = fid;
% end
while ~feof(fid)
    tline = fgetl(fid);
    if(tline(1) == 'A' && tline(2) == 'F')
        if(tline(4)=='0')
            AFresult(ii-2) = -1;
        else
            AFresult(ii-2) = 1;
        end
    end
    
end
fclose(fid);
a = textread([myPath 'ecgfilter.data'],'%f');
a = a';
%判断是否存在大于10S的干净数据段
[zuo,you] =  findclean(myPath);
if (zuo == you)
    continue;
end

a = a(zuo:zuo+5119);
[ Pfa,Pfd,Ea,Ed ] = fevect( a );
vect = [Pfa Pfd Ea Ed];
allvect(ii-2,:) = vect;
clear Pfa
clear Pfd
clear Ea
clear Ed
end
BB =  trans_norm(allvect); 
% [bestCVaccuracy,bestc,bestg]= SVMcgForClass(AFresult',BB,-5,5,-5,5,3,1,1,4.5);

trained_super_plane = svmtrain(AFresult',BB, '-c 1 -g 8');

end

