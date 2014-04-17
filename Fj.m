function [ fj ] = Fj(g_sort, p_bar_sort, t_sort, noises_sort, j)
%FJ Summary of this function goes here
%   Detailed explanation goes here
    fj = 0;
    K = size(t_sort, 2);
    
    for i=1:j
        fj = fj + g_sort(i)*p_bar_sort(i);
    end
    for i = (j+1):K
        fj = fj + g_sort(i)*PositiveOrZero(( t_sort(j)/g_sort(i) - noises_sort(i) ));
    end
    
end

