% function [ leftpos,rightpos ] = findclean( rec_path )
% %UNTITLED2 此处显示有关此函数的摘要
% %   此处显示详细说明
% ann=textread([rec_path 'ecgatrann.data'],'%f');
% atr=textread([rec_path 'ecgatr.data'],'%f');
% 
% isFound=0;
% tempLeft=1;
% tempRight=1;
% startWithPos=1;
% 
% while(1)
%     if startWithPos >= length(ann)
%         break;
%     end
%     
%     for m1 = startWithPos:length(ann)
%         if(ann(m1) ~= 14)
%             tempLeft = m1;
%             break;
%         end
%     end
%     
%     if m1 >= length(ann)
%         break;
%     end
%     
%     for m2=m1+1:length(ann)
%         if(ann(m2) == 14)
%             tempRight = m2-1;
%             break;
%         end
%         
%         if m2 == length(ann)
%             tempRight = m2;
%         end
%     end
%     
%     if atr(tempRight) - atr(tempLeft) > 5120
%         isFound =1;
%         break;
%     end
%     
%     startWithPos = m2 + 1;
%     
%     
% end
% 
% if isFound==1
%     leftpos = atr(tempLeft); 
%     rightpos = atr(tempRight);
% else
%     leftpos = 0;
%     rightpos = 0;
% end
% 
% end
function [ leftpos,rightpos ] = findclean( rec_path )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
ann=textread([rec_path 'ecgatrann.data'],'%f');
atr=textread([rec_path 'ecgatr.data'],'%f');

isFound=0;
tempLeft=1;
tempRight=1;
startWithPos=1;

while(1)

    if startWithPos >= length(ann)
        break;
    end
    
    for m1=startWithPos:length(ann)
        if(ann(m1) ~= 14)
            tempLeft = m1;
            break;
        end
    end
    
    if m1 >= length(ann)
        break;
    end
    
    for m2=m1+1:length(ann)
        if(ann(m2) == 14)
            tempRight = m2-1;
            break;
        end
        
        if m2 == length(ann)
            tempRight = m2;
         end
    end
    
    if atr(tempRight) - atr(tempLeft) > 5120
        isFound = isFound+1;
        leftpos(isFound) = atr(tempLeft);
        rightpos(isFound) = atr(tempRight);
        
    end
    
    startWithPos = m2+1;
    
    
end

if isFound==0
    leftpos(1) = 0;
    rightpos(1) = 0;
end

end

