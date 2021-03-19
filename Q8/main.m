% Copyright, 2021, (Ted) Zhongkun Zhan, all rights reserved.
% File name: mainQ8.m

function main()

% Problem 1
p1 = AbaqusClassQ8('Prob1Q8.inp');
T1 = p1.getT();
q1 = p1.getFlux();
nodes1 = p1.getNodes();
x1 = nodes1(:, 2);
y1 = nodes1(:, 3);
T1_analytical = x1 + 0.5;
err1 = max(abs(T1 - T1_analytical));
disp('In problem 1, the maximum error between the numerical solution and the analytical solution is: ');
disp(err1);
disp('It means that the numerical solution matched exactly with the analytical solution.');
% Plot T
figure;
scatter(x1, y1, [], T1);
title('Problem 1 Temperature (celcius)');
colormap jet;
colorbar;
axis equal;
savefig('p1 T ');
close;
% Plot q
figure;
scatter(x1, y1, []);
hold on;
quiver(q1(:, 1), q1(:, 2), q1(:, 3), q1(:, 4));
title('Problem 1 flux');
axis equal;
savefig('p1 q ');
close;

% Problem 2
% 4 elements
p2_4 = AbaqusClassQ8('Prob2Q8_4.inp');
T2_4 = p2_4.getT();
q2_4 = p2_4.getFlux();
nodes2_4 = p2_4.getNodes();
x2_4 = nodes2_4(:, 2);
y2_4 = nodes2_4(:, 3);
T2_4_analytical = -x2_4 .^ 2 + 3 * x2_4 + 1.75;
err2_4 = max(abs(T2_4 - T2_4_analytical));
% Plot T
figure;
scatter(x2_4, y2_4, [], T2_4);
title('Problem 2 Temperature (celcius) with 4 elements');
colormap jet;
colorbar;
axis equal;
savefig('p2_4 T ');
close;
% Plot q
figure;
scatter(x2_4, y2_4, []);
hold on;
quiver(q2_4(:, 1), q2_4(:, 2), q2_4(:, 3), q2_4(:, 4));
title('Problem 2 flux with 4 elements');
axis equal;
savefig('p2_4 q ');
close;

% 16 elements
p2_16 = AbaqusClassQ8('Prob2Q8_16.inp');
T2_16 = p2_16.getT();
q2_16 = p2_16.getFlux();
nodes2_16 = p2_16.getNodes();
x2_16 = nodes2_16(:, 2);
y2_16 = nodes2_16(:, 3);
T2_16_analytical = -x2_16 .^ 2 + 3 * x2_16 + 1.75;
err2_16 = max(abs(T2_16 - T2_16_analytical));
% Plot T
figure;
scatter(x2_16, y2_16, [], T2_16);
title('Problem 2 Temperature (celcius) with 16 elements');
colormap jet;
colorbar;
axis equal;
savefig('p2_16 T ');
close;
% Plot q
figure;
scatter(x2_16, y2_16, []);
hold on;
quiver(q2_16(:, 1), q2_16(:, 2), q2_16(:, 3), q2_16(:, 4));
title('Problem 2 flux with 16 elements');
axis equal;
savefig('p2_16 q ');
close;

% 100 elements
p2_100 = AbaqusClassQ8('Prob2Q8_100.inp');
T2_100 = p2_100.getT();
q2_100 = p2_100.getFlux();
nodes2_100 = p2_100.getNodes();
x2_100 = nodes2_100(:, 2);
y2_100 = nodes2_100(:, 3);
T2_100_analytical = -x2_100 .^ 2 + 3 * x2_100 + 1.75;
err2_100 = max(abs(T2_100 - T2_100_analytical));
% Plot T
figure;
scatter(x2_100, y2_100, [], T2_100);
title('Problem 2 Temperature (celcius) with 100 elements');
colormap jet;
colorbar;
axis equal;
savefig('p2_100 T ');
close;
% Plot q
figure;
scatter(x2_100, y2_100, []);
hold on;
quiver(q2_100(:, 1), q2_100(:, 2), q2_100(:, 3), q2_100(:, 4));
title('Problem 2 flux with 100 elements');
axis equal;
savefig('p2_100 q ');
close;
% Plot error
figure;
errBar2 = [err2_4 err2_16 err2_100];
bar(errBar2);
set(gca, 'xticklabel', {'4 elements', '16 elements', '100 elements'});
title('Problem 2 Maximum absolute error in different densities of discretization.')
savefig('p2 err ');
close;
disp('In problem 2, all the maximum absolute errors are in the order of 10e-14, meaning that the FEM Q8 gives the exact solution for problem 2. The increasing in the errors should mean that more elements yield more computational rounding error.');

% Problem 3
% 8 elements
p3_8 = AbaqusClassQ8('Prob3Q8_8.inp');
T3_8 = p3_8.getT();
q3_8 = p3_8.getFlux();
nodes3_8 = p3_8.getNodes();
x3_8 = nodes3_8(:, 2);
y3_8 = nodes3_8(:, 3);
T3_8_analytical = ((x3_8 .^ 2 + y3_8 .^ 2) .^ 0.5 - 0.25) .^ 2;
err3_8 = max(abs(T3_8 - T3_8_analytical));
% Plot T
figure;
scatter(x3_8, y3_8, [], T3_8);
title('Problem 3 Temperature (celcius) with 8 elements');
colormap jet;
colorbar;
axis equal;
savefig('p3_8 T ');
close;
% Plot q
figure;
scatter(x3_8, y3_8, []);
hold on;
quiver(q3_8(:, 1), q3_8(:, 2), q3_8(:, 3), q3_8(:, 4));
title('Problem 3 flux with 8 elements');
axis equal;
savefig('p3_8 q ');
close;

% 94 elements
p3_94 = AbaqusClassQ8('Prob3Q8_94.inp');
T3_94 = p3_94.getT();
q3_94 = p3_94.getFlux();
nodes3_94 = p3_94.getNodes();
x3_94 = nodes3_94(:, 2);
y3_94 = nodes3_94(:, 3);
T3_94_analytical = ((x3_94 .^ 2 + y3_94 .^ 2) .^ 0.5 - 0.25) .^ 2;
err3_94 = max(abs(T3_94 - T3_94_analytical));
% Plot T
figure;
scatter(x3_94, y3_94, [], T3_94);
title('Problem 3 Temperature (celcius) with 94 elements');
colormap jet;
colorbar;
axis equal;
savefig('p3_94 T ');
close;
% Plot q
figure;
scatter(x3_94, y3_94, []);
hold on;
quiver(q3_94(:, 1), q3_94(:, 2), q3_94(:, 3), q3_94(:, 4));
title('Problem 3 flux with 94 elements');
axis equal;
savefig('p3_94 q ');
close;

% 163 elements
p3_163 = AbaqusClassQ8('Prob3Q8_163.inp');
T3_163 = p3_163.getT();
q3_163 = p3_163.getFlux();
nodes3_163 = p3_163.getNodes();
x3_163 = nodes3_163(:, 2);
y3_163 = nodes3_163(:, 3);
T3_163_analytical = ((x3_163 .^ 2 + y3_163 .^ 2) .^ 0.5 - 0.25) .^ 2;
err3_163 = max(abs(T3_163 - T3_163_analytical));
% Plot T
figure;
scatter(x3_163, y3_163, [], T3_163);
title('Problem 3 Temperature (celcius) with 163 elements');
colormap jet;
colorbar;
axis equal;
savefig('p3_163 T ');
close;
% Plot q
figure;
scatter(x3_163, y3_163, []);
hold on;
quiver(q3_163(:, 1), q3_163(:, 2), q3_163(:, 3), q3_163(:, 4));
title('Problem 3 flux with 163 elements');
axis equal;
savefig('p3_163 q ');
close;
% Plot error
figure;
errBar3 = [err3_8 err3_94 err3_163];
bar(errBar3);
set(gca, 'xticklabel', {'8 elements', '94 elements', '163 elements'});
title('Problem 3 Maximum absolute error in different densities of discretization.')
savefig('p3 err ');
close;
disp('In problem 3, the maximum absolute errors decrease as the number of elements increase.');