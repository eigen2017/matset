

  clear all;
mydir='F:\localcode\part_train\';
DIRS=dir([mydir,'*']);
for i = 3:length(DIRS)
    myPath = [mydir,DIRS(i).name,'\'];
    super111 = GetSuperPlane(myPath);
    super{i-2} = super111;
    clear super111
end
% super111 = GetSuperPlane('F:\localcode\part_train\hunhe9\');
% super{1}=super111;

[ biaodingAf1,predictAf1,unknownCnt ] = mypredict(super,  'F:\localcode\part_test\');

zhengqueCnt = 0;

for ii = 1:length(biaodingAf1)
    if(biaodingAf1(ii) == predictAf1(ii))
        zhengqueCnt = zhengqueCnt  +  1; 
    end
end

buzhengqueCnt = length(biaodingAf1) - zhengqueCnt;

AccuracyMy = zhengqueCnt*100 / length(biaodingAf1);

