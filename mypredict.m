function [ biaodingAf,predictAf,unknownCnt ] = mypredict( super_planes, predict_path )

unknownCnt=0;
cnt = 1;
cnt2=1;
 
mypath = predict_path;
 
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
    unknownCnt = unknownCnt+1;
    continue;
end



duannum(cnt2) = length(zuo); 
duanflag(cnt2) = flag;
cnt2=cnt2+1;

for mm = 1:length(zuo)
bb = a(zuo(mm):zuo(mm)+5119);
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

for ttt=1:cnt-1

BB =  trans_norm(allvect(ttt,:));

%[uu,accuracy,dec] = svmpredict(Afresult(ttt),BB,super_plane);
%labels(ttt) = uu(1);
accuracyAf = [0.796610 0.796610 0.898305 0.915254 0.915254 0.915254 0.881356 0.898305 0.864407];
NormAf = accuracyAf/sum(accuracyAf);
accuracyNAf = [0.863078 0.704506 0.699329 0.722645 0.693388 0.692218 0.739029 0.702165 0.722060];
NormNAf = accuracyNAf/sum(accuracyNAf);
sumaf =  0;
for jj = 1:9
    [temp(jj),accuracy,dec] = svmpredict(Afresult(ttt),BB,super_planes{jj});
  if (temp(jj)==1)
      sumaf = sumaf + NormAf;
  else
      sumaf =sumaf -NormNAf;
  end

end
clear temp

if    sumaf>=0
    labels(ttt) = 1;
else
    labels(ttt) = -1;
end
end
for mmm=1:length(duanflag)
    if(duanflag(mmm)==1)
        biaodingAf(mmm) = 1;
    else
        biaodingAf(mmm) = -1;
    end
end

for nnn=1:length(duannum)

    offsite = sum(duannum(1:nnn));
    offsite = offsite-duannum(nnn)+1;
    
%     if( -1*duannum(nnn) == sum(labels(offsite:offsite+duannum(nnn)-1)) )
%         predictAf(nnn)= -1;
%     else
%         predictAf(nnn)= 1;
%     end
    if( 0 > sum(labels(offsite:offsite+duannum(nnn)-1)) )
         predictAf(nnn)= -1;
     else
         predictAf(nnn)= 1;
    end
    
end



end

