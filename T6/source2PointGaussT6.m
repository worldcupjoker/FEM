% Copyright, 2021, (Ted) Zhongkun Zhan, all rights reserved.
% File name: source2PointGaussT6.m

function f_s = source2PointGaussT6(N_a, N_b, N_c, N_d, detJ_a, detJ_b, detJ_c, detJ_d, L, xy, source, Wa, Wb, Wc, Wd)

xa = N_a * xy(:, 1);
ya = N_a * xy(:, 2);
xb = N_b * xy(:, 1);
yb = N_b * xy(:, 2);
xc = N_c * xy(:, 1);
yc = N_c * xy(:, 2);
xd = N_d * xy(:, 1);
yd = N_d * xy(:, 2);

f_s = L.' * (Wa * N_a.' * detJ_a * source(xa, ya) + Wb * N_b.' * detJ_b * source(xb, yb) + Wc * N_c.' * detJ_c * source(xc, yc) + Wd * N_d.' * detJ_d * source(xd, yd));
f_s = f_s / 2;
return
end