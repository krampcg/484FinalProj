%% Load 2D Seafloor
Z = dlmread('bezierPoints.dat');
X = linspace(0, 100, 101);
Y = linspace(100, 0, 101);
figure
hold on
set(gca, 'FontSize', 32)
title('2D Surface of the Seafloor')
xlabel('X')
ylabel('Y')
zlabel('H')
surf(X, Y, Z, 'EdgeColor', 'None', 'FaceColor', 'interp');
hold off

%% For reference, gradient
% [Fx, Fy] = gradient(Z);
% figure
% hold on
% set(gca, 'FontSize', 32)
% title('2D Derivative of Seafloor wrt X')
% xlabel('X')
% ylabel('Y')
% zlabel('H_x')
% surf(X,Y,Fx);
% figure
% hold on
% set(gca, 'FontSize', 32)
% title('2D Derivative of Seafloor wrt Y')
% xlabel('X')
% ylabel('Y')
% zlabel('H_y')
% surf(X,Y,Fy);

%% Load Precomputed 2D Derivative Seafloor of X
Z = dlmread('2DDerivsX.dat');
X = linspace(0, 100, 101);
Y = linspace(100, 0, 101);
X = flip(X);
Y = flip(Y);
Z = Z;
figure
hold on
set(gca, 'FontSize', 32)
title('2D Derivative wrt X Surface of the Seafloor')
xlabel('X')
ylabel('Y')
zlabel('H')
surf(Y, X, Z, 'EdgeColor', 'None', 'FaceColor', 'interp');
hold off

%% Load Precomputed 2D Derivative Seafloor of Y
Z = dlmread('2DDerivsY.dat');
X = linspace(0, 100, 101);
Y = linspace(100, 0, 101);
X = flip(X);
Y = flip(Y);
Z = Z;
figure
hold on
set(gca, 'FontSize', 32)
title('2D Derivative wrt Y Surface of the Seafloor')
xlabel('X')
ylabel('Y')
zlabel('H')
surf(Y, X, Z, 'EdgeColor', 'None', 'FaceColor', 'interp');
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
Y = dlmread('1DDerivs.dat');
Y = flip(Y);
figure
hold on
set(gca, 'FontSize', 32)
title('Derivs of Bezier Curve of the Seafloor from Epicenter to Power Plant')
xlabel('X');
ylabel('H prime');
plot(X, Y, 'LineWidth', 3);
hold off

