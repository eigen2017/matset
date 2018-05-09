A=[1 2 3; 5 34 5; 43 54 23];

rowrank = randperm(size(A, 1)); % 随机打乱的数字，从1~行数打乱
B = A(rowrank, :);