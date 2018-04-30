% Load File
%load('u_lw_p.mat')

filename = 'wave.gif'
fig = figure;

max_amp = max(u_lw_p(1,:));

% Sea-Level
data_plot_1 = plot(x,u_lw_p(1,:)*1000, '-b');
hold on
% Sea-Floor
data_plot_2 = plot(x,z_plot*100,'-k');
% Epicenter
data_plot_3 = plot(0,-1,'x','Color','red','MarkerFaceColor','red',...
    'MarkerSize',10,'Linewidth',3);
% Formatting
axis([x(1), x(end), -1, 15])
title('2011 T?hoku Tsunami Simulation')
xlabel('Distance (km)')
ylabel('Height (m)')
legend('Sea Surface','Sea Floor','Epicenter','Location','northwest')

% Pause for 0.0001 sec
pause(0.001);
drawnow
% Capture plot as image
frame = getframe(fig);
im = frame2im(frame);
[imind,cm] = rgb2ind(im,256);

imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.0005)

% Rest of the Plots
for i=2:1:length(t)
    % Delete Plots
    delete(data_plot_1);
    delete(data_plot_2);
    delete(data_plot_3);
    
    % Sea-Level
    data_plot_1 = plot(x,u_lw_p(i,:)*1000, '-b');
    hold on
    % Sea-Floor
    data_plot_2 = plot(x,z_plot/100,'-k');
    % Epicenter
    data_plot_3 = plot(0,-1,'x','Color','red','MarkerFaceColor','red',...
    'MarkerSize',10,'Linewidth',3);
    % Formatting
    axis([x(1), x(end), -1, 15])
    title('2011 T?hoku Tsunami Simulation')
    xlabel('Distance (km)')
    ylabel('Height (m)')
    legend('Sea Surface','Sea Floor','Epicenter','Location','northwest')
    
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