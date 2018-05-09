% clear all
% clc
 cnt = 1;
 
 mypath = 'F:\localcode\50af\';
 
% mydir=uigetdir('f:','选择一个目录');
mydir=mypath;%[mydir,'\'];
DIRS=dir([mydir,'*']);
n=length(DIRS);
% allvect = cell(1,n-2);
% allvect = zeros(n-2,28);
% AFresult = zeros(1,73);
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
           % AFresult(ii-2) = -1;
           flag = -1;
        else
         %   AFresult(ii-2) = 1;
         flag = 1;
        end
    end
end
fclose(fid);
a = textread([myPath 'ecgfilter.data'],'%f');
a = a';
[zuo,you] =  findclean(myPath);

if (zuo(1) == you(1))
    
    continue;
end

duannum(ii-2) = length(zuo); 

for mm = 1:length(zuo)
bb = a(zuo(mm):you(mm));
[ Pfa,Pfd,Ea,Ed ] = fevect( bb );

vect = [Pfa Pfd Ea Ed];
allvect(cnt,:) = vect;
Afresult(cnt) = flag;
cnt = cnt + 1;

end
clear Pfa
clear Pfd
clear Ea
clear Ed
end
BB =  trans_norm(allvect);

[labels,accuracy,dec] = svmpredict(Afresult',BB,model_linear);
% 
% clear BB;
% clear Afresult;







