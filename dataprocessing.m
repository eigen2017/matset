yyy=load('F:\AF_training\training2017\mytest1.csv');
for i=2:148
    maxcol(i-1)=abs(max(yyy(i,1:5120)));
end
for i = 2:148
  for j = 1:5120
    yyy(i,j) = yyy(i,j)/maxcol(i-1);
  end
end