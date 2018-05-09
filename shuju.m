mypath='F:\AF\zhenghuimin\';
for i = 1:2765
    subindex = b(i,end);
    mm = [mypath num2str(b(i,end))];
    if i==1
        mkdir(mm)
    end
    if (i~= 1 && subindex ~= b(i-1,end))
        mkdir(mm);
    end
    bb= [num2str(i) '.csv'];
    header = zeros(1,5121);
    header(1) = 1;
    header(2) = 5120;
    dlmwrite([mm '\' bb],a(i,:), ',');
end
