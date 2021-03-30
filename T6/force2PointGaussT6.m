% Copyright, 2021, (Ted) Zhongkun Zhan, all rights reserved.
% File name: force2PointGaussT6.m
% flux: function handle
% It seems that this function has to be on the path (a seperate file that
% is directly visible to matlab) in order to receive a function handle.
% https://www.mathworks.com/matlabcentral/answers/173155-using-function-handles-for-inputs

function f_n = force2PointGaussT6(xy, L, recordState, flux)
xia = -1 / 3 ^ 0.5;
xib = 1 / 3 ^ 0.5;

if recordState == 2
    
    % L2 = 1 - L1;
    % two point gaussian quadrature
    % The line integral starts at 0 and ends at 1.
    % Have to use L2 as the parameter, reason unknown.
    % Don't use L1 LOL!!!
    % Need to map L2 to xi
    % L2 = 1 / 2 * (xi + 1)
    % _L1, _L2 are partial derivatives.
    % Don't forget to multiply 0.5 to the integral.
    N1 = getShapeFuncT6(1 - 0.5 * (xia + 1), 0.5 * (xia + 1), true);
    N1_L2 = getShapeFuncT6(1 - 0.5 * (xia + 1), 0.5 * (xia + 1), false);
    x1 = N1 * xy(:, 1);
    x1_L2 = N1_L2(2, :) * xy(:, 1);
    y1 = N1 * xy(:, 2);
    y1_L2 = N1_L2(2, :) * xy(:, 2);
    N2 = getShapeFuncT6(1 - 0.5 * (xib + 1), 0.5 * (xib + 1), true);
    N2_L2 = getShapeFuncT6(1 - 0.5 * (xib + 1), 0.5 * (xia + 1), false);
    x2 = N2 * xy(:, 1);
    x2_L2 = N2_L2(2, :) * xy(:, 1);
    y2 = N2 * xy(:, 2);
    y2_L2 = N2_L2(2, :) * xy(:, 2);
    f_n = L.' * 0.5 * (N1.' * flux(x1, y1) * (x1_L2 ^ 2 + y1_L2 ^ 2) ^ 0.5 + N2.' * flux(x2, y2) * (x2_L2 ^ 2 + y2_L2 ^ 2) ^ 0.5);
    return
end

if recordState == 6
    L1 = 0;
    
    % two point gaussian quadrature
    % L2 = 1 / 2 * (xi + 1)
    N1 = getShapeFuncT6(L1, 0.5 * (xia + 1), true);
    N1_L2 = getShapeFuncT6(L1, 0.5 * (xia + 1), false);
    x1 = N1 * xy(:, 1);
    x1_L2 = N1_L2(2, :) * xy(:, 1);
    y1 = N1 * xy(:, 2);
    y1_L2 = N1_L2(2, :) * xy(:, 2);
    N2 = getShapeFuncT6(L1, 0.5 * (xib + 1), true);
    N2_L2 = getShapeFuncT6(L1, 0.5 * (xib + 1), false);
    x2 = N2 * xy(:, 1);
    x2_L2 = N2_L2(2, :) * xy(:, 1);
    y2 = N2 * xy(:, 2);
    y2_L2 = N2_L2(2, :) * xy(:, 2);
    f_n = L.' * 0.5 * (N1.' * flux(x1, y1) * (x1_L2 ^ 2 + y1_L2 ^ 2) ^ 0.5 + N2.' * flux(x2, y2) * (x2_L2 ^ 2 + y2_L2 ^ 2) ^ 0.5);
    return
end

if recordState == 3
    L2 = 0;
    
    % two point gaussian quadrature
    N1 = getShapeFuncT6(0.5 * (xia + 1), L2, true);
    N1_L1 = getShapeFuncT6(0.5 * (xia + 1), L2, false);
    x1 = N1 * xy(:, 1);
    x1_L1 = N1_L1(1, :) * xy(:, 1);
    y1 = N1 * xy(:, 2);
    y1_L1 = N1_L1(1, :) * xy(:, 2);
    N2 = getShapeFuncT6(0.5 * (xib + 1), L2, true);
    N2_L1 = getShapeFuncT6(0.5 * (xib + 1), L2, false);
    x2 = N2 * xy(:, 1);
    x2_L1 = N2_L1(1, :) * xy(:, 1);
    y2 = N2 * xy(:, 2);
    y2_L1 = N2_L1(1, :) * xy(:, 2);
    f_n = L.' * 0.5 * (N1.' * flux(x1, y1) * (x1_L1 ^ 2 + y1_L1 ^ 2) ^ 0.5 + N2.' * flux(x2, y2) * (x2_L1 ^ 2 + y2_L1 ^ 2) ^ 0.5);
    return
end
end