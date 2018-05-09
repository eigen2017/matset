clear all
clc
% figure;
% mypath = 'f:\12daes\';
%遍历每个数据和注释文件
 mypath = 'F:\localcode\全部自动化\';
 DIRS=dir([mypath,'*']);
 n=length(DIRS);
 fid = fopen('F:\fileway.txt','w');
 for i = 1:n
 
     if (length(DIRS(i).name) < 3)
         continue;
     end
     %每个文件的路径
     myPath = [mypath,DIRS(i).name,'\'];
     
       fprintf(fid,'%s',[myPath 'ecgatrann.data']);
       fprintf(fid,'\n');    
     
 end
  fclose(fid);