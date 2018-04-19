    % 1D FTCS Scheme
% Solves 1D Advection Equation
function u = lax_wendroff(dt,N_t,dx,N_x,u0,c,a,b,f)

% Solution Discretization
u = zeros(N_t,N_x);
% Initial Condition
u(1,:) = u0;

% BC's
u(:,1) = a;
u(:,N_x) = b;

r = dt/dx;

% loop over time
for i=1:N_t-1
    % loop over space
    for j=2:N_x-1
        % Half Steps w/ Lax-Friedrichs
        u_h_p = 0.5*(u(i,j) + u(i,j+1)) - r/2*c*(f(u(i,j+1))-f(u(i,j)));
        u_h_m = 0.5*(u(i,j) + u(i,j-1)) + r/2*c*(f(u(i,j-1))-f(u(i,j)));
        % Evaluation of Flux at Half-Steps
        f_h_p = f(u_h_p);
        f_h_m = f(u_h_m);
        % Full Step
        u(i+1,j) = u(i,j) - r*c*(f_h_p-f_h_m);
    end
end
