% 1D FTCS Scheme
% Solves 1D Advection Equation
function u = lax_freidrichs(dt,N_t,dx,N_x,u0,c,a,b)

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
        u(i+1,j) = 0.5*(u(i,j+1) + u(i,j-1)) - r/2*c*(u(i,j+1)-u(i,j-1));
    end
end