% Copyright, 2021, (Ted) Zhongkun Zhan, all rights reserved.
% File name: localFlux.m
% Find fluxes at 4 Gaussian quadrature points in an element.

function q = localFlux(xy, N_a, N_b, N_c, N_d, G_a, G_b, G_c, G_d, localTemp, K)
q = zeros(4, 4);

% Get x, y coordinates for each quadrature point.
xa = N_a * xy(:, 1);
ya = N_a * xy(:, 2);
q(1, 1) = xa;
q(1, 2) = ya;
xb = N_b * xy(:, 1);
yb = N_b * xy(:, 2);
q(2, 1) = xb;
q(2, 2) = yb;
xc = N_c * xy(:, 1);
yc = N_c * xy(:, 2);
q(3, 1) = xc;
q(3, 2) = yc;
xd = N_d * xy(:, 1);
yd = N_d * xy(:, 2);
q(4, 1) = xd;
q(4, 2) = yd;

% Find the jacobian matrix at each quadrature point.
% Find the flux at each quadrature point.
J_a = G_a * xy;
J_b = G_b * xy;
J_c = G_c * xy;
J_d = G_d * xy;
qa = -inv(J_a) * G_a * localTemp * K;
qb = -inv(J_b) * G_b * localTemp * K;
qc = -inv(J_c) * G_c * localTemp * K;
qd = -inv(J_d) * G_d * localTemp * K;

% Write in local flux vectors.
q(1, 3) = qa(1, 1);
q(1, 4) = qa(2, 1);
q(2, 3) = qb(1, 1);
q(2, 4) = qb(2, 1);
q(3, 3) = qc(1, 1);
q(3, 4) = qc(2, 1);
q(4, 3) = qd(1, 1);
q(4, 4) = qd(2, 1);
return
end