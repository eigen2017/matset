function [ sorted ] = super_sort(arr, fh)
transformed = fh(arr);% 对原始数组进行变换
[~, index] = sort(transformed); % 获得排序后的原数组位置索引
sorted = arr(index); % 返回排序后的原数组
end

