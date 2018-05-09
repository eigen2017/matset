clear all
clc
% figure;
% mypath = 'f:\12daes\';
%遍历每个数据和注释文件
 mypath = 'F:\AF\13\1497778429222\';
 DIRS=dir([mypath,'*']);
 n=length(DIRS);
% fid = fopen('F:\AF_training\Rpeak1.txt','w');
%  for i = 1:n
%      Rinput=[];
%      Rxinput=[];
%      Ryinput=[];
%      if (length(DIRS(i).name) < 3)
%          continue;
%      end
%      %每个文件的路径
%      myPath = [mypath,DIRS(i).name,'\'];
%      %读取注释文件
%      ann=textread([myPath 'ecgatrann.data'],'%f');
%      atr=textread([myPath 'ecgatr.data'],'%f');
%      %读取数据文件
%      sss=textread([myPath 'ecgfilter.data'],'%f');
%      %只读取大于12的数据
%      if (length(sss) < 512*12)
%          continue;
%      end
%      %只读取有连续10个R点的数据
%      k =  1; 
%      for j = 1:length(ann)
%          if ann(j) == 14
%            cc(k) = j;
%            k = k+1;
%          end
%      end
%      if k == 1
%           for xx=20+1:20+5120
%              fprintf(fid,'%d,',sss(xx));
%           end
%           ss = 2;
%           while(atr(ss)<5120)
%               Rinput(ss-1) = atr(ss);
%               ss = ss +  1;
%           end
% %          fprintf(fid,'%f,',std(diff(Rinput)));
% %          fprintf(fid,'%f,',mean(diff(Rinput)));
% %          fprintf(fid,'%f,',kurtosis(diff(Rinput)));
%          fprintf(fid,'%d',zhy(myPath));
%          fprintf(fid,'\n');  
%      end
%      if k == 3
%          if atr(cc(1))<5300 && atr(cc(2))+5300>length(sss)
%              continue;
%          end
%          if atr(cc(1))>5300
%              for tt=40+1:40+5120
%                  fprintf(fid,'%d,',sss(tt));
%              end
%              pp=1;
%               while(atr(pp)<5200)
%               Rxinput(pp) = atr(pp);
%               pp = pp +  1;
%               end
% %          fprintf(fid,'%f,',std(diff(Rxinput)));
% %          fprintf(fid,'%f,',mean(diff(Rxinput)));
% %          fprintf(fid,'%f,',kurtosis(diff(Rxinput)));
%            fprintf(fid,'%d',zhy(myPath));
%          fprintf(fid,'\n');  
%          elseif atr(cc(2))+5300 < length(sss)
%              for tt=atr(cc(2))+100+1:atr(cc(2))+100+5120
%                  fprintf(fid,'%d,',sss(tt));
%              end
%              ind = cc(2);
%              yg=1;
%              while(atr(ind) < length(sss))
%                  Ryinput(yg) = atr(ind);
%                  ind = ind +1;
%                  yg = yg + 1;
%                  if ind>=length(atr)
%                      break;
%                  end
%                  
%              end
% %                fprintf(fid,'%f,',std(diff(Ryinput)));
% %                fprintf(fid,'%f,',mean(diff(Ryinput)));
% %                fprintf(fid,'%f,',kurtosis(diff(Ryinput)));
%                fprintf(fid,'%d',zhy(myPath));
%                fprintf(fid,'\n'); 
%          else
%              continue;
%          end    
%      end
%      if k>3
%      
%      [maxvalue,maxloc] = max(diff(cc));
%      if maxvalue < 10
%          continue;
%      else
%          %写入心电数据
%          if atr(cc(maxloc))+5120 < length(sss)
%              ending = atr(cc(maxloc))+5120;
%          else
% %              ending = length(sss)-10;
%                continue
%          end
%          for m=atr(cc(maxloc))+1:ending
%              fprintf(fid,'%d,',sss(m));
%          end
%          %写入RR间期的均值,方差,峰度
%          kk = cc(maxloc);
%          nn = 1;
%          while(atr(kk)+1 < ending)
%              Rpeak(nn) = atr(kk)+1;
%              kk = kk+1;
%              if kk >= length(atr)
%                  break;
%              end
%              nn = nn + 1;
%          end
% %          fprintf(fid,'%f,',std(diff(Rpeak)));
% %          fprintf(fid,'%f,',mean(diff(Rpeak)));
% %          fprintf(fid,'%f,',kurtosis(diff(Rpeak)));
%            fprintf(fid,'%d',zhy(myPath));
%          fprintf(fid,'\n');
%      end
%      end
%      clear cc
%      clear Rpeak
%      clear Rinput
%      clear Rxinput
%      clear Ryinput
%  end
%  fclose(fid);
     
         
     
     


% ecgnotfilter=textread([mypath 'ecgnotfilter.data'],'%f');
% % ecgnotfilter=textread('f:\12daes\ecgnotfilter.data');
sss=textread([mypath 'ecgfilter.data'],'%f');
atr=textread([mypath 'ecgatr.data'],'%f');
ann=textread([mypath 'ecgatrann.data'],'%f');
% expos=textread([mypath 'extremepos.middle'],'%f');
% thresholds=textread([mypath 'threshold.middle'],'%f');

% plot(expos);
% hold on;
% plot([1 length(sss)],[thresholds(1) thresholds(1)]);
% hold on;
% plot([1 length(sss)],[thresholds(2) thresholds(2)]);

% thr=textread('f:\12daes\ecgthr.data');
% fang=textread('f:\12daes\ecgfang.data');

% sss=log(sss);
% plot(ecgnotfilter);
% hold on;

%plot(sss);

%hold on;
fid = fopen('F:\AF\13\rpeak','w');
for i=1:length(ann)
% if ann(i) == 30
%     plot(atr(i)+1,sss(atr(i)+1), 'r^');
% end
% 
% if ann(i) == 14
%     plot(atr(i)+1,sss(atr(i)+1), 'k^');
% end
% 
if ann(i) == 1
    plot(atr(i)+1,sss(atr(i)+1), 'g^');
    for j= atr(i)+1-84:atr(i)+1+84
    fprintf(fid,'%d ',sss(j));
    end
    fprintf(fid,'\n'); 
    
end
% 
 end
fclose(fid);



for i=1:length(ann)
 if ann(i) == 30
     plot(atr(i)+1,sss(atr(i)+1), 'r^');
 end
 
 if ann(i) == 14
     plot(atr(i)+1,sss(atr(i)+1), 'k^');
 end 
if ann(i) == 1
    plot(atr(i)+1,sss(atr(i)+1), 'g^'); 
end
end



