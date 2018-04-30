    % 1D FTCS Scheme
% Solves 1D Advection Equation
function [u,u_p] = lax_wendroff_gen(dt,N_t,x,dx,N_x,u0,f,u0_p,v_max)

% Solution Discretization
% Conservative Variables
u = zeros(N_t,N_x,2);
% Initial Condition
u(1,:,:) = u0';
% Plebian Variables
u_p = zeros(N_t,N_x);
% Initial Condition
u_p(1,:) = u0_p;

r = dt/dx;

Q = (1-0.5*v_max*r)/(1+0.5*v_max*r);

% loop over time
for i=1:N_t-1 
    % Fun
%     X = floor(rand(50)*N_x);
%     for p=1:length(X)
%         u(i,p,2) = u(i,p,1) + 0.1;
%     end
    
    % loop over space
    for j=2:N_x-1
        % Half Steps w/ Lax-Friedrichs
        u_h_p = 0.5*(u(i,j+1,:) + u(i,j,:)) - ...
            reshape(r*0.5*(f(u(i,j+1,:),x(j+1))-f(u(i,j,:),x(j))),[1,1,2]);
        u_h_m = 0.5*(u(i,j,:) + u(i,j-1,:)) - ...
            reshape(r*0.5*(f(u(i,j,:),x(j))-f(u(i,j-1,:),x(j-1))),[1,1,2]);
        % Evaluation of Flux at Half-Steps
        f_h_p = reshape(f(u_h_p,x(j)+dx/2),[1,1,2]);
        f_h_m = reshape(f(u_h_m,x(j)-dx/2),[1,1,2]);
        % Full Step
        u(i+1,j,:) = u(i,j,:) - r*(f_h_p-f_h_m);
        
        % Primitive Variable
        u_p(i+1,j) = u_p(i,j) + dt*u(i,j,2);
    end
    
    % Ingoing Sommerfield BC
    u(i+1,1,1) = u(i,2,1) - u(i+1,2,1)*Q + u(i,1,1)*Q;
    u(i+1,1,2) = u(i,2,2) - u(i+1,2,2)*Q + u(i,1,2)*Q;
    % Outgoing Sommerfield BC
    u(i+1,N_x,1) = u(i,N_x-1,1) - u(i+1,N_x-1,1)*Q + u(i,N_x,1)*Q;
    u(i+1,N_x,2) = u(i,N_x-1,2) - u(i+1,N_x-1,2)*Q + u(i,N_x,2)*Q;

    % Update Plebian Variable
    u_p(i+1,1) = u_p(i,1) + dt*u(i,1,2);
    u_p(i+1,N_x) = u_p(i,N_x) + dt*u(i,N_x,2);
end
