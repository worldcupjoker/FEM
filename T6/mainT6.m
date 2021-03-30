% Copyright, 2021, (Ted) Zhongkun Zhan, all rights reserved.
% File name: mainT6.m

function mainT6()

% Problem 1
p1 = AbaqusClassT6('Prob1T6.inp');
T1 = p1.getT();
q1 = p1.getFlux();
nodes1 = p1.getNodes();
x1 = nodes1(:, 2);
y1 = nodes1(:, 3);
T1_analytical = x1 + 0.5;
err1 = max(abs(T1 - T1_analytical))
disp('In problem 1, the maximum error between the numerical solution and the analytical solution is: ');
disp(err1);
disp('It means that the numerical solution matched exactly with the analytical solution.');
% Plot T
figure;
scatter(x1, y1, [], T1);
plotElements(p1);
title('Problem 1 Temperature (celcius)');
colormap jet;
colorbar;
axis equal;
savefig('p1T6 T Zhan_Zhongkun');
close;
% Plot q
figure;
scatter(x1, y1, []);
plotElements(p1);
hold on;
quiver(q1(:, 1), q1(:, 2), q1(:, 3), q1(:, 4));
title('Problem 1 flux');
axis equal;
savefig('p1T6 q Zhan_Zhongkun');
close;

% Problem 2
% 2 elements
p2_2 = AbaqusClassT6('Prob2T6_2.inp');
T2_2 = p2_2.getT();
q2_2 = p2_2.getFlux();
nodes2_2 = p2_2.getNodes();
x2_2 = nodes2_2(:, 2);
y2_2 = nodes2_2(:, 3);
T2_2_analytical = -x2_2 .^ 2 + 3 * x2_2 + 1.75;
err2_2 = max(abs(T2_2 - T2_2_analytical))
% Plot T
figure;
scatter(x2_2, y2_2, [], T2_2);
plotElements(p2_2);
title('Problem 2 Temperature (celcius) with 2 elements');
colormap jet;
colorbar;
axis equal;
savefig('p2_2T6 T Zhan_Zhongkun');
close;
% Plot q
figure;
scatter(x2_2, y2_2, []);
plotElements(p2_2);
hold on;
quiver(q2_2(:, 1), q2_2(:, 2), q2_2(:, 3), q2_2(:, 4));
title('Problem 2 flux with 2 elements');
axis equal;
savefig('p2_2T6 q Zhan_Zhongkun');
close;

% 32 elements
p2_32 = AbaqusClassT6('Prob2T6_32.inp');
T2_32 = p2_32.getT();
q2_32 = p2_32.getFlux();
nodes2_32 = p2_32.getNodes();
x2_32 = nodes2_32(:, 2);
y2_32 = nodes2_32(:, 3);
T2_32_analytical = -x2_32 .^ 2 + 3 * x2_32 + 1.75;
err2_32 = max(abs(T2_32 - T2_32_analytical))
% Plot T
figure;
scatter(x2_32, y2_32, [], T2_32);
plotElements(p2_32);
title('Problem 2 Temperature (celcius) with 32 elements');
colormap jet;
colorbar;
axis equal;
savefig('p2_32T6 T Zhan_Zhongkun');
close;
% Plot q
figure;
scatter(x2_32, y2_32, []);
plotElements(p2_32);
hold on;
quiver(q2_32(:, 1), q2_32(:, 2), q2_32(:, 3), q2_32(:, 4));
title('Problem 2 flux with 32 elements');
axis equal;
savefig('p2_32T6 q Zhan_Zhongkun');
close;

% 200 elements
p2_200 = AbaqusClassT6('Prob2T6_200.inp');
T2_200 = p2_200.getT();
q2_200 = p2_200.getFlux();
nodes2_200 = p2_200.getNodes();
x2_200 = nodes2_200(:, 2);
y2_200 = nodes2_200(:, 3);
T2_200_analytical = -x2_200 .^ 2 + 3 * x2_200 + 1.75;
err2_200 = max(abs(T2_200 - T2_200_analytical))
% Plot T
figure;
scatter(x2_200, y2_200, [], T2_200);
plotElements(p2_200);
title('Problem 2 Temperature (celcius) with 200 elements');
colormap jet;
colorbar;
axis equal;
savefig('p2_200T6 T Zhan_Zhongkun');
close;
% Plot q
figure;
scatter(x2_200, y2_200, []);
plotElements(p2_200);
hold on;
quiver(q2_200(:, 1), q2_200(:, 2), q2_200(:, 3), q2_200(:, 4));
title('Problem 2 flux with 200 elements');
axis equal;
savefig('p2_200T6 q Zhan_Zhongkun');
close;
% Plot error
figure;
errBar2 = [err2_2 err2_32 err2_200];
bar(errBar2);
set(gca, 'xticklabel', {'2 elements', '32 elements', '200 elements'});
title('Problem 2 Maximum absolute error in different densities of discretization.')
savefig('p2T6 err Zhan_Zhongkun');
close;
disp('In problem 2, all the maximum absolute errors are in the order of 10e-14, meaning that the FEM T6 gives the exact solution for problem 2. The increasing in the errors should mean that more elements yield more computational rounding error.');

% Problem 3
% 12 elements
p3_12 = AbaqusClassT6('Prob3T6_12.inp');
T3_12 = p3_12.getT();
q3_12 = p3_12.getFlux();
nodes3_12 = p3_12.getNodes();
x3_12 = nodes3_12(:, 2);
y3_12 = nodes3_12(:, 3);
T3_12_analytical = ((x3_12 .^ 2 + y3_12 .^ 2) .^ 0.5 - 0.25) .^ 2;
err3_12 = max(abs(T3_12 - T3_12_analytical))
% Plot T
figure;
scatter(x3_12, y3_12, [], T3_12);
plotElements(p3_12);
title('Problem 3 Temperature (celcius) with 12 elements');
colormap jet;
colorbar;
axis equal;
savefig('p3_12T6 T Zhan_Zhongkun');
close;
% Plot q
figure;
scatter(x3_12, y3_12, []);
plotElements(p3_12);
hold on;
quiver(q3_12(:, 1), q3_12(:, 2), q3_12(:, 3), q3_12(:, 4));
title('Problem 3 flux with 8 elements');
axis equal;
savefig('p3_12T6 q Zhan_Zhongkun');
close;

% 40 elements
p3_40 = AbaqusClassT6('Prob3T6_40.inp');
T3_40 = p3_40.getT();
q3_40 = p3_40.getFlux();
nodes3_40 = p3_40.getNodes();
x3_40 = nodes3_40(:, 2);
y3_40 = nodes3_40(:, 3);
T3_40_analytical = ((x3_40 .^ 2 + y3_40 .^ 2) .^ 0.5 - 0.25) .^ 2;
err3_40 = max(abs(T3_40 - T3_40_analytical))
% Plot T
figure;
scatter(x3_40, y3_40, [], T3_40);
plotElements(p3_40);
title('Problem 3 Temperature (celcius) with 40 elements');
colormap jet;
colorbar;
axis equal;
savefig('p3_40T6 T Zhan_Zhongkun');
close;
% Plot q
figure;
scatter(x3_40, y3_40, []);
plotElements(p3_40);
hold on;
quiver(q3_40(:, 1), q3_40(:, 2), q3_40(:, 3), q3_40(:, 4));
title('Problem 3 flux with 40 elements');
axis equal;
savefig('p3_40T6 q Zhan_Zhongkun');
close;

% 176 elements
p3_176 = AbaqusClassT6('Prob3T6_176.inp');
T3_176 = p3_176.getT();
q3_176 = p3_176.getFlux();
nodes3_176 = p3_176.getNodes();
x3_176 = nodes3_176(:, 2);
y3_176 = nodes3_176(:, 3);
T3_176_analytical = ((x3_176 .^ 2 + y3_176 .^ 2) .^ 0.5 - 0.25) .^ 2;
err3_176 = max(abs(T3_176 - T3_176_analytical))
% Plot T
figure;
scatter(x3_176, y3_176, [], T3_176);
plotElements(p3_176);
title('Problem 3 Temperature (celcius) with 176 elements');
colormap jet;
colorbar;
axis equal;
savefig('p3_176T6 T Zhan_Zhongkun');
close;
% Plot q
figure;
scatter(x3_176, y3_176, []);
plotElements(p3_176);
hold on;
quiver(q3_176(:, 1), q3_176(:, 2), q3_176(:, 3), q3_176(:, 4));
title('Problem 3 flux with 176 elements');
axis equal;
savefig('p3_176T6 q Zhan_Zhongkun');
close;
% Plot error
figure;
errBar3 = [err3_12 err3_40 err3_176];
bar(errBar3);
set(gca, 'xticklabel', {'12 elements', '40 elements', '176 elements'});
title('Problem 3 Maximum absolute error in different densities of discretization.')
savefig('p3T6 err Zhan_Zhongkun');
close;
disp('In problem 3, the maximum absolute errors decrease as the number of elements increase.');

end

% Function: plotElements
% Works for T6 elements
function plotElements(obj)
hold on;
elements = obj.getElements;
nodeGlobal = obj.getNodes();
totalEle = size(elements, 1);
xy = zeros(4, 2);
for i = 1 : totalEle
    for j = 1 : 3
        globalNodeNumber = elements(i, j + 1);
        xy(j, 1) = nodeGlobal(globalNodeNumber, 2);
        xy(j, 2) = nodeGlobal(globalNodeNumber, 3);
    end
    
    % Set the starting point as the end point.
    xy(4, 1) = xy(1, 1);
    xy(4, 2) = xy(1, 2);
    plot(xy(:, 1), xy(:, 2), 'k');
end
end