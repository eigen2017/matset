function [ sorted ] = super_sort(arr, fh)
transformed = fh(arr);% ��ԭʼ������б任
[~, index] = sort(transformed); % ���������ԭ����λ������
sorted = arr(index); % ����������ԭ����
end

