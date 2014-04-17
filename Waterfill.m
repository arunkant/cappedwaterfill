function [ popt] = Waterfill( noises, ptotal )
%WATERFILL Summary of this function goes here
%   Detailed explanation goes here
    [noises_sort, sort_index] = sort(noises);
    K = size(noises, 2);
    if K == 0
        popt = zeros(1,0);  %Kind of null return;
    else
        prem = ptotal;
        popt_sort = zeros(1,K);
        j = 1;
        mu = noises_sort(1);
        
        
        %calculate water level
        while(prem > 0)
            if j == K   %Fill all the water here
                mu = mu + prem/j;
                prem = 0;
            else
                delta = noises_sort(j + 1) - noises_sort(j);
                if (delta * j > prem)
                    mu = mu + prem/j;
                    prem = 0;
                else
                    mu = mu + delta;
                    prem = prem - delta * j;
                end
                j = j + 1;
            end
        end
        for j=1:K
            if (mu > noises_sort(j))
                popt_sort(j) = mu - noises_sort(j);
            else
                popt_sort(j) = 0;
            end
        end
        popt(sort_index) = popt_sort;
    end
end

