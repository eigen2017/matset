A=[1 2 3; 5 34 5; 43 54 23];

rowrank = randperm(size(A, 1)); % ������ҵ����֣���1~��������
B = A(rowrank, :);