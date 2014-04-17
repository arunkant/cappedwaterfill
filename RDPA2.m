function [ popt ] = RDPA2(  noises, p_bar, pth1, pth2, g1, g2 )
%RDPA2 Summary of this function goes here
%   Detailed explanation goes here
    %solving SP1
    K = size(noises, 2);
    p1 = CMLWaterfill(noises, p_bar, pth1, g1);
    if (g2 * p1' < pth2)    %yo nigga, very ezy.
        popt = p1;
    else
        p2 = CMLWaterfill(noises, p_bar, pth2, g2);
        if (g1 * p2' < pth1)    %very ezy too.
            popt = p2;
        else
            cvx_begin
                variable p(1,K);
                maximize(sum(log(1+p./noises)))
                subject to
                    g1*p' == pth1;
                    g2*p' == pth2;
                    p < p_bar;
                    p > 0;
            cvx_end
            popt = p;
        end
    end

end

