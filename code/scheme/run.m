clear all

% Simulation Parameters
% Spatial Range
x0 = -40;
xf = 132.5;
% Gravitational Constant - km/s^2
g = 9.80665/1000;
% Bezier Points of Seafloor Map
P = [-1099, -465, -130, 1];
% Bezier Seafloor Topology
b_z = @(x) bezier(P, x/xf);
% Reduced Seafloor Topology
z = @(x) b_z(x);
% Negative Image
H = @(x) -z(x);

% Spatial Grid
N_x = 1000;
x = linspace(x0,xf,N_x);
dx = x(2) - x(1);

% For Plotting
z_plot = z(x);

% Max Wave-Speed Velocity
v_max = g*max(H(x));

% Courant-Freidrichs-Lowy Condition
% CFL = 1.0;

% Temporal Discretization
t0 = 0;
dt = dx/v_max;
tf = 60;
t = t0:dt:tf;
N_t = length(t);

% Initial, Shallow Wave Profile
amp = 0.0046;
sigma = 10;
sealevel = 0;
x_peak = 0;
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

save('u_lw_p.mat','u_lw_p','x','t','z_plot');

% Call FDM Schemes
% u_upwind = upwind(dt,N_t,dx,N_x,u0,c,a,b);
% u_ftcs = ftcs(dt,N_t,dx,N_x,u0,c,a,b);
% u_lf = lax_freidrichs(dt,N_t,dx,N_x,u0,c,a,b);
% u_leap = leapfrog(dt,N_t,dx,N_x,u0,c,a,b,f);
% Get Max Nodal Error of Each Scheme
% u_err_upwind = zeros(10,1);
% u_err_ftcs = zeros(10,1);
% u_err_lf = zeros(10,1);
% u_err_leap = zeros(10,1);
% u_err_lw = zeros(10,1);
% % get max nodal error every 100 time steps
% for i = 1:10
% %     u_err_upwind(i) = max(abs(u_exact(i*100,:) - u_upwind(i*100,:)));
% %     u_err_ftcs(i) = max(abs(u_exact(i*100,:) - u_ftcs(i*100,:)));
% %     u_err_lf(i) = max(abs(u_exact(i*100,:) - u_lf(i*100,:)));
% %     u_err_leap(i) = max(abs(u_exact(i*100,:) - u_leap(i*100,:)));
%     u_err_lw(i) = max(abs(u_exact(i*100,:) - u_lw(i*100,:)));
% end

% Make Error Tables
% times = t([1:100:N_t])';
% T_err_upwind = table(times,u_err_upwind);
% T_err_ftcs = table(times,u_err_ftcs);
% T_err_lf = table(times,u_err_lf);
% T_err_leap = table(times,u_err_leap);
% T_err_lw = table(times,u_err_lw);
% T_err_full = table(times,u_err_upwind,u_err_ftcs,u_err_lf,u_err_leap,...
%     u_err_lw);

% Output as Latex Tables
% Upwind Scheme
% LT_err_upwind_input.data = T_err_upwind;
% LT_err_upwind_input.tableColLabels = {'Timestep','Max Error'};
% LT_err_upwind_input.dataFormat = {'%.3f', 1, '%22.18E', 1};
% LT_err_upwind = latexTable(LT_err_upwind_input);
% % FTCS Scheme
% LT_err_ftcs_input.data = T_err_ftcs;
% LT_err_ftcs_input.tableColLabels = {'Timestep','Max Error'};
% LT_err_ftcs_input.dataFormat = {'%.3f', 1, '%22.18E', 1};
% LT_err_ftcs = latexTable(LT_err_ftcs_input);
% % Lax-Freiderichs Scheme
% LT_err_lf_input.data = T_err_lf;
% LT_err_lf_input.tableColLabels = {'Timestep','Max Error'};
% LT_err_lf_input.dataFormat = {'%.3f', 1, '%22.18E', 1};
% LT_err_lf = latexTable(LT_err_lf_input);
% % Leapfrog Scheme
% LT_err_leap_input.data = T_err_leap;
% LT_err_leap_input.tableColLabels = {'Timestep','Max Error'};
% LT_err_leap_input.dataFormat = {'%.3f', 1, '%22.18E', 1};
% LT_err_leap = latexTable(LT_err_leap_input);
% % Lax-Wendroff Scheme
% LT_err_lw_input.data = T_err_lw;
% LT_err_lw_input.tableColLabels = {'Timestep','Max Error'};
% LT_err_lw_input.dataFormat = {'%.3f', 1, '%22.18E', 1};
% LT_err_lw = latexTable(LT_err_lw_input);
% % Full Table
% LT_err_input.data = T_err_full;
% LT_err_input.tableColLabels = {'Timestep','E\textsub{max} Upwind',...
%     'E\textsub{max} FTCS','E\textsub{max} Lax-Freiderichs',...
%     'E\textsub{max} Leapfrog','E\textsub{max} Lax-Wendroff'};
% LT_err_input.dataFormat = {'%.3f', 1, '%22.18E', 5};
% LT_err = latexTable(LT_err_input);

% Aminations
%plot(u_exact(1, :));
%f = getframe;
%[im,map] = rgb2ind(f.cdata,256,'nodither');
%im(1,1,1,1) = 0;

%for i = 2:length(u_exact)
%    if mod(i, 20) == 0
%        plot(u_exact(i, :));
%        f = getframe;
%        im(:,:,1,i) = rgb2ind(f.cdata, map,'nodither');
%    end
%end

% figure
% mesh(x,t,u_exact)
% title('Exact Solution')
%
% figure
% mesh(x,t,u_upwind)
% title('Upwind Scheme')
% 
% figure
% mesh(x,t,u_ftcs)
% title('FTCS Scheme')
% 
% figure
% mesh(x,t,u_lf)
% title('Lax-Freidrichs Scheme')
% 
% figure
% mesh(x,t,u_leap)
% title('Leapfrog Scheme')
% 
