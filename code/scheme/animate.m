% Load File
load('u_lw_p.mat')

filename = 'wave.gif'
fig = figure;

max_amp = max(u_lw_p(1,:));

% Sea-Level
data_plot_1 = plot(x,u_lw_p(1,:), '-b');
hold on
% Sea-Floor
data_plot_2 = plot(x,z_plot,'-k');
% Formatting
axis([x(1), x(end), -0.01, 0.1])
title('Shallow Water Simulation')
xlabel('Distance')
ylabel('Height')
legend('Sea Surface','Sea Floor','Location','southeast')

% Pause for 0.0001 sec
pause(0.001);
drawnow
% Capture plot as image
frame = getframe(fig);
im = frame2im(frame);
[imind,cm] = rgb2ind(im,256);

imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.0005)

% Rest of the Plots
for i=2:20:length(t)
    % Delete Plots
    delete(data_plot_1);
    delete(data_plot_2);
    
    % Sea-Level
    data_plot_1 = plot(x,u_lw_p(i,:), '-b');
    hold on
    % Sea-Floor
    data_plot_2 = plot(x,z_plot,'-k');
    % Formatting
    axis([x(1), x(end), -0.01, 0.1])
    title('Shallow Water Simulation')
    xlabel('Distance')
    ylabel('Height')
    legend('Sea Surface','Sea Floor','Location','southeast')
    
    % Pause for 0.0001 sec
    %pause(0.001);
    
    drawnow
    % Capture plot as image
    frame = getframe(fig);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);

    % Write to the GIF file
    imwrite(imind,cm,filename,'gif', 'WriteMode','append','DelayTime',0.0005)
end