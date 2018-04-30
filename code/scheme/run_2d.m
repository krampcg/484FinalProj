clear all

% Simulation Parameters
% Gravitational Constant
g = 9.81;
% Spatial Range
x0 = 0;
xf = 1;
% Spatial Discretization
N_x = 100;
% Spatial Grid
x = linspace(x0, xf, N_x);
% Spacing
dx = x(2)-x(1);
% Bezier Points of Seafloor Map
P = [-1099, -465, -130, 1];
% Bezier Seafloor Topology
b_z = @(x) bezier(P, x);
% Normalized Seafloor Topology
z = @(x) b_z(x)/max(abs(b_z(x)));
% For Plotting
z_plot = z(x);
% Sea-Floor Topology
% z = @(x) 0.5/xf*x - 0.5;
% Negative Image
H = @(x) -z(x);

% Max Wave-Speed Velocity
v_max = g*max(H(x));

% Courant-Freidrichs-Lowy Condition
CFL = 1.0;

% Temporal Parameters
dt = CFL*dx/v_max;
t0 = 0;
tf = 1;
% Temporal Discretization
t = t0:dt:tf;
N_t = length(t);

% Initial, Shallow Wave Profile
amp = 1;
sigma = 0.1;
sealevel = 0;
x_peak = mean(x);
eta = @(x,amp,sigma,x_peak) amp*exp(-((x-x_peak)/sigma).^2)+sealevel; 
% eta = @(x,amp,x0,sigma) exp(-abs(x0-x)).*sin(x);
etaprime = @(x,amp,sigma,x_peak) -2*amp/sigma^2*(x-x_peak).*exp(-((x-x_peak)/sigma).^2);
% etaprime = @(x,amp,x0,sigma) exp(-abs(x0-x)).*cos(x)-sin(x).*exp(-abs(x0-x));

% Initial Condition
u0_p = eta(x,amp,sigma,x_peak);
u0 = [etaprime(x,amp,sigma,x_peak);linspace(0,0,N_x)];

f = @(u,x) [0 -1; -g*H(x) 0]*[u(1); u(2)];
% f = @(u) [0 -v; -v 0]*[u(1); u(2)];

% Call Lax-Wendroff
[u_lw_c,u_lw_p] = lax_wendroff_gen(dt,N_t,x,dx,N_x,u0,f,u0_p,v_max);

figure
mesh(x,t,squeeze(u_lw_c(:,:,1)))
title('Lax-Wendroff Scheme, ALPHA')
xlabel('x')
ylabel('t')

figure
mesh(x,t,squeeze(u_lw_c(:,:,2)))
title('Lax-Wendroff Scheme, GAMMA')
xlabel('x')
ylabel('t')

figure
mesh(x,t,squeeze(u_lw_p(:,:)))
title('Lax-Wendroff Scheme, PRIMITIVE')
xlabel('x')
ylabel('t')

save('u_lw_p.mat','u_lw_p','x','t','z_plot');