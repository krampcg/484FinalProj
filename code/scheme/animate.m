% Load File
load('u_lw_p.mat')

filename = 'wave.gif'
fig = figure;

data_plot_1 = plot(x,u_lw_p(1,:));
title('Lax-Wendroff Scheme')
xlabel('x')
axis([x(1), x(end), -5, 5])

% Pause for 0.0001 sec
pause(0.001);
drawnow
% Capture plot as image
frame = getframe(fig);
im = frame2im(frame);
[imind,cm] = rgb2ind(im,256);

imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.0005)

% Rest of the Plots
for i=2:length(t)
    % Get Plots, Plot
    data_plot_1 = plot(x,u_lw_p(i,:));
    title('Lax-Wendroff Scheme')
    xlabel('x')
    axis([x(1), x(end), -5, 5])
    % Pause for 0.0001 sec
    %pause(0.001);
    
    drawnow
    % Capture plot as image
    frame = getframe(fig);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);

    % Write to the GIF file
    imwrite(imind,cm,filename,'gif', 'WriteMode','append','DelayTime',0.0005)
    
    % Delete Plots
    delete(data_plot_1);
end