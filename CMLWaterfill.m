function [ p ] = CMLWaterfill( noises, p_bar, pth, g )
%CMLWATERFILL for only single PU
%   Detailed explanation goes here
    t = g.*( noises + p_bar);
    [t_sort, sort_index] = sort(t);
    
    g_sort = g(sort_index);
    noises_sort = noises(sort_index);
    p_bar_sort = p_bar(sort_index);
    
    j = 1;
    K = size(noises, 2);
    F = zeros(1, K);
    for i = 1:K
        F(i) = Fj(g_sort, p_bar_sort, t_sort, noises_sort, i);
    end
    F
    
    i = 1;
    while (i <= K)
        if pth < F(i);
            break;
        end
        i = i + 1;
    end
    i0 = i - 1
    if (i0 == K)
        p_sort = p_bar_sort;
    else
        p_sort(1:i0) = p_bar_sort(1:i0);
        power_consumed = g_sort(:, 1:i0) * (p_bar_sort(:, 1:i0))';
        pth_rem = pth - power_consumed;
        p2 = Waterfill(noises_sort(i0+1:K), pth_rem);
        p_sort(i0+1:K) = p2./g_sort(i0+1:K);
    end
    
    p(sort_index) = p_sort;   
end

