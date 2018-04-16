%% Load 2D Seafloor
Z = dlmread('bezierPoints.dat');
X = linspace(0, 100, 100);
Y = linspace(100, 0, 100);
figure
hold on
set(gca, 'FontSize', 32)
title('2D Surface of the Seafloor')
xlabel('X')
ylabel('Y')
zlabel('H')
surf(X, Y, Z);
hold off

%% Load 1D Seafloor
X = linspace(0, 100, 101);
Y = dlmread('bezCurve.dat');
Y = flip(Y);
figure
hold on
set(gca, 'FontSize', 32)
title('Bezier Curve of the Seafloor from Epicenter to Power Plant')
xlabel('X');
ylabel('H');
plot(X, Y, 'LineWidth', 3);
hold off

%% Load Precomputed Derivs of 1D Seafloor
X = linspace(0, 100, 101);
Y = dlmread('2DDerivs.dat');
figure
hold on
title('Derivs of Bezier Curve of the Seafloor from Epicenter to Power Plant')
xlabel('X');
ylabel('H prime');
plot(X, Y);
hold off

