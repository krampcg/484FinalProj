% Temporary File
Z = dlmread('bezierPoints.dat');
X = linspace(0, 100, 100);
Y = linspace(100, 0, 100);
surf(X, Y, Z);
