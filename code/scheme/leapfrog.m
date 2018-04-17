% 1D Leapfrog Scheme
% Solves 1D Advection Equation
function u = leapfrog(dt,N_t,dx,N_x,u0,c,a,b,f)

% Solution Discretization
u = zeros(N_t,N_x);
% Initial Condition
u(1,:) = u0;

% BC's
u(:,1) = a;
u(:,N_x) = b;

r = dt/dx;

% Initialize w/ FTCS
for j=2:N_x-1
    u(2,j) = u(1,j) - r*c*(f(u(1,j+1))-f(u(1,j)));
end

% loop over time
for i=2:N_t-1
    % loop over space
    for j=2:N_x-1
        u(i+1,j) = u(i-1,j) - r*c*(f(u(i,j+1))-f(u(i,j-1)));
    end
end
