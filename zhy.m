function m=zhy(mypath)
fid = fopen([mypath 'correct.txt'], 'r');

while ~feof(fid)
    tline=fgetl(fid);
    if ~isempty(tline)
        
        if double(tline(1))==65   %×ÖÄ¸A¿ªÊ¼
         
            m = tline(4);
            m=str2double(m);
            m=int8(m);
            clear b b1 b2 b3 b4;
       
        end
    
    end
end
fclose(fid);
