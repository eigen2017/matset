clear all
clc
% figure;
% mypath = 'f:\12daes\';
%����ÿ�����ݺ�ע���ļ�
 mypath = 'F:\localcode\ȫ���Զ���\';
 DIRS=dir([mypath,'*']);
 n=length(DIRS);
 fid = fopen('F:\fileway.txt','w');
 for i = 1:n
 
     if (length(DIRS(i).name) < 3)
         continue;
     end
     %ÿ���ļ���·��
     myPath = [mypath,DIRS(i).name,'\'];
     
       fprintf(fid,'%s',[myPath 'ecgatrann.data']);
       fprintf(fid,'\n');    
     
 end
  fclose(fid);