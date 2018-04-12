%% Load 3D Seafloor
Z = dlmread('bezierPoints.dat');
X = linspace(0, 100, 100);
Y = linspace(100, 0, 100);
figure
hold on
title('3D Surface of the Seafloor')
xlabel('X')
ylabel('Y')
zlabel('H')
surf(X, Y, Z);
hold off

%% Load 2D Seafloor
X = linspace(0, 100, 101);
Y = dlmread('bezCurve.dat');
figure
hold on
title('Bezier Curve of the Seafloor from Epicenter to Power Plant')
xlabel('X');
ylabel('H');
plot(X, Y);
hold off

%% Load Precomputed Derivs of 2D Seafloor
X = linspace(0, 100, 101);
Y = dlmread('2DDerivs.dat');
figure
hold on
title('Derivs of Bezier Curve of the Seafloor from Epicenter to Power Plant')
xlabel('X');
ylabel('H prime');
plot(X, Y);
hold off

