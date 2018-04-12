% - Numerical Parameters -
% Velocity
c = 0.1;
% Spatial Parameters
x0 = 0;
xf = 10;
N_x = 1000;
% Temporal Parameters
t0 = 0;
tf = 10;
N_t = 1001;

% Time Grid
t = linspace(t0, tf, N_t);
% Spacing
dt = t(2)-t(1);

% Spatial Grid
x = linspace(x0, xf, N_x);
% Spacing
dx = x(2)-x(1);

% Wave Profile
amp = 2;
x0 = mean(x);
sigma = 0.5;
eta = @(x,amp,x0,sigma) amp*exp(-((x-x0)/sigma).^2); 

% Initial Condition
u0 = eta(x,amp,x0,sigma);
% Boundary Conditions
a = 0;
b = 0;

% Exact Solution
u_exact = zeros(N_t,N_x);
u_exact(1,:) = u0;
for i = 1:N_t
    for j = 1:N_x
    	u_exact(i,j) = eta(x(j)-c*t(i),amp,x0,sigma);
    end
end

% Call FDM Schemes
u_upwind = upwind(dt,N_t,dx,N_x,u0,c,a,b);
u_ftcs = ftcs(dt,N_t,dx,N_x,u0,c,a,b);
u_lf = lax_freidrichs(dt,N_t,dx,N_x,u0,c,a,b);
u_leap = leapfrog(dt,N_t,dx,N_x,u0,c,a,b);
u_lw = lax_wendroff(dt,N_t,dx,N_x,u0,c,a,b);

% Get Max Nodal Error of Each Scheme
u_err_upwind = zeros(10,1);
u_err_ftcs = zeros(10,1);
u_err_lf = zeros(10,1);
u_err_leap = zeros(10,1);
u_err_lw = zeros(10,1);
% get max nodal error every 100 time steps
for i = 1:10
    u_err_upwind(i) = max(abs(u_exact(i*100,:) - u_upwind(i*100,:)));
    u_err_ftcs(i) = max(abs(u_exact(i*100,:) - u_ftcs(i*100,:)));
    u_err_lf(i) = max(abs(u_exact(i*100,:) - u_lf(i*100,:)));
    u_err_leap(i) = max(abs(u_exact(i*100,:) - u_leap(i*100,:)));
    u_err_lw(i) = max(abs(u_exact(i*100,:) - u_lw(i*100,:)));
end

% Make Error Tables
times = t([101:100:N_t])';
T_err_upwind = table(times,u_err_upwind);
T_err_ftcs = table(times,u_err_ftcs);
T_err_lf = table(times,u_err_lf);
T_err_leap = table(times,u_err_leap);
T_err_lw = table(times,u_err_lw);
T_err_full = table(times,u_err_upwind,u_err_ftcs,u_err_lf,u_err_leap,...
    u_err_lw);

% Output as Latex Tables
% Upwind Scheme
LT_err_upwind_input.data = T_err_upwind;
LT_err_upwind_input.tableColLabels = {'Timestep','Max Error'};
LT_err_upwind_input.dataFormat = {'%.3f', 1, '%22.18E', 1};
LT_err_upwind = latexTable(LT_err_upwind_input);
% FTCS Scheme
LT_err_ftcs_input.data = T_err_ftcs;
LT_err_ftcs_input.tableColLabels = {'Timestep','Max Error'};
LT_err_ftcs_input.dataFormat = {'%.3f', 1, '%22.18E', 1};
LT_err_ftcs = latexTable(LT_err_ftcs_input);
% Lax-Freiderichs Scheme
LT_err_lf_input.data = T_err_lf;
LT_err_lf_input.tableColLabels = {'Timestep','Max Error'};
LT_err_lf_input.dataFormat = {'%.3f', 1, '%22.18E', 1};
LT_err_lf = latexTable(LT_err_lf_input);
% Leapfrog Scheme
LT_err_leap_input.data = T_err_leap;
LT_err_leap_input.tableColLabels = {'Timestep','Max Error'};
LT_err_leap_input.dataFormat = {'%.3f', 1, '%22.18E', 1};
LT_err_leap = latexTable(LT_err_leap_input);
% Lax-Wendroff Scheme
LT_err_lw_input.data = T_err_lw;
LT_err_lw_input.tableColLabels = {'Timestep','Max Error'};
LT_err_lw_input.dataFormat = {'%.3f', 1, '%22.18E', 1};
LT_err_lw = latexTable(LT_err_lw_input);
% Full Table
LT_err_input.data = T_err_full;
LT_err_input.tableColLabels = {'Timestep','E\textsub{max} Upwind',...
    'E\textsub{max} FTCS','E\textsub{max} Lax-Freiderichs',...
    'E\textsub{max} Leapfrog','E\textsub{max} Lax-Wendroff'};
LT_err_input.dataFormat = {'%.3f', 1, '%22.18E', 5};
LT_err = latexTable(LT_err_input);

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
% figure
% mesh(x,t,u_lw)
% title('Lax-Wendroff Scheme')