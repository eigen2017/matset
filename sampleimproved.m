combinecan = [canaf' cannoaf'];
combinecan = combinecan';
distanceMat = zeros(50,1049); 
for i = 1:50
    cnt = 1;
   for j = 1:1050
       if (i == j)
           continue;
       end
       distanceMat(i,cnt) = Edistance(combinecan(i,:),combinecan(j,:));
       cnt = cnt + 1;
   end
end

kmeansary = zeros(50,6);
for i = 1:50
    kmeansary(i,:) = min6(distanceMat(i,:));
end

