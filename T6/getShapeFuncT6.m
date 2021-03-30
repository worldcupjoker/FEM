% Copyright, 2021, (Ted) Zhongkun Zhan, all rights reserved.
% File name: getShapeFuncT6.m

function N = getShapeFuncT6(L1, L2, mode)
L3 = 1 - L1 - L2;

% Get the shape function matrix is mode is true.
if mode == true
    N = zeros(1, 6);
    N(1, 1) = (2 * L1 - 1) * L1;
    N(1, 2) = (2 * L2 - 1) * L2;
    N(1, 3) = (2 * L3 - 1) * L3;
    N(1, 4) = 4 * L1 * L2;
    N(1, 5) = 4 * L2 * L3;
    N(1, 6) = 4 * L1 * L3;
    return

% Get the gradient of the shape function, G matrix, if mode is
% false.
else
    N = zeros(2, 6);
    N(1, 1) = 4 * L1 - 1;
    N(1, 2) = 0;
    N(1, 3) = 4 * L1 + 4 * L2 - 3;
    N(1, 4) = 4 * L2;
    N(1, 5) = -4 * L2;
    N(1, 6) = 4 - 8 * L1 - 4 * L2;
    N(2, 1) = 0;
    N(2, 2) = 4 * L2 - 1;
    N(2, 3) = 4 * L1 + 4 * L2 - 3;
    N(2, 4) = 4 * L1;
    N(2, 5) = 4 - 4 * L1 - 8 * L2;
    N(2, 6) = -4 * L1;
    return
end
end