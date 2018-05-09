function [ B ] = transpre( A )
%UNTITLED9 此处显示有关此函数的摘要
%   此处显示详细说明


B = zeros(1,length(A));

    max_col = max(A);
    min_col = min(A);
    for j = 1:length(A)
        B(j) = -1 + 2 * (A(j) - min_col)/(max_col - min_col);
    end


end

