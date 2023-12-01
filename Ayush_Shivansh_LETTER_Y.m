% Given points
Y = [16, 15, 16, 15, 14];
X = [0, 1, 2, 1, 1];

% Number of interpolation points (cha
% nge as needed)
nPoints = 5;

% Interpolate between first two points
xi1 = linspace(X(1), X(2), nPoints);
yi1 = linspace(Y(1), Y(2), nPoints);

% Interpolate between second and third points
xi2 = linspace(X(2), X(3), nPoints);
yi2 = linspace(Y(2), Y(3), nPoints);

% Interpolate between third and fourth points
xi3 = linspace(X(3), X(4), nPoints);
yi3 = linspace(Y(3), Y(4), nPoints);

% Interpolate between third and fourth points
xi4 = linspace(X(4), X(5), nPoints);
yi4 = linspace(Y(4), Y(5), nPoints);


% Combine interpolated points
Xi = [xi1, xi2, xi3, xi4];
Yi = [yi1, yi2, yi3, yi4];

% Plot the original and interpolated points
figure;
plot(X, Y, 'o-', Xi, Yi, '.-');
legend('Original Points', 'Interpolated Points');
xlabel('X');
ylabel('Y');
grid on;
title('Linear Interpolation');



l1=9;
l2=8;

th1 =[];
th2 =[];

for i=1:length(Xi)
    x = Xi(i);
    y = Yi(i);
    theta2 = acos((x*x +y*y -l1*l1 -l2*l2)/(2*l1*l2));
    theta1 = atan2(y,x) -atan2(l2*sin(theta2),l1 +l2*cos(theta2));
    th1 =[th1,theta1*(180/pi)];
    th2 =[th2,theta2*(180/pi)];

end
animate_2r_manipulator(th1, th2, l1, l2);

function animate_2r_manipulator(theta1_values, theta2_values, length1, length2)
    % Convert angles to radians
    theta1_values = deg2rad(theta1_values);
    theta2_values = deg2rad(theta2_values);

    % Initialize figure
    figure;
    h1 = plot([0, length1 * cos(theta1_values(1))], [0, length1 * sin(theta1_values(1))], 'o-','LineWidth',2);
    hold on;
    h2 = plot([length1 * cos(theta1_values(1)), length1 * cos(theta1_values(1)) + length2 * cos(theta1_values(1) + theta2_values(1))], ...
         [length1 * sin(theta1_values(1)), length1 * sin(theta1_values(1)) + length2 * sin(theta1_values(1) + theta2_values(1))], 'o-','LineWidth',2);
    effector_point = plot(length1 * cos(theta1_values(1)) + length2 * cos(theta1_values(1) + theta2_values(1)), ...
         length1 * sin(theta1_values(1)) + length2 * sin(theta1_values(1) + theta2_values(1)), 'ro','MarkerSize',8);
    
    % Initialize a new plot for storing permanent points
    permanent_points = plot(NaN, NaN, 'go', 'MarkerSize', 8);

    % Set axis limits
    axis equal;
    xlim([-max(length1, length2) max(length1, length2)]);
    ylim([-max(length1, length2) max(length1, length2)]);

    % Set labels
    title('2R Manipulator Animation');
    xlabel('X-axis');
    ylabel('Y-axis');

    % Animation loop
    for i = 1:length(theta1_values)
        t1 = theta1_values(i);
        t2 = theta2_values(i);
        
        x = length1 * cos(t1);
        y = length1 * sin(t1);
        
        % Update plot
        set(h1, 'XData', [0, x]);
        set(h1, 'YData', [0, y]);
        set(h2, 'XData', [x, x + length2 * cos(t1 + t2)]);
        set(h2, 'YData', [y, y + length2 * sin(t1 + t2)]);
        set(effector_point, 'XData', x + length2 * cos(t1 + t2));
        set(effector_point, 'YData', y + length2 * sin(t1 + t2));

        % Update permanent points plot
        current_permanent_points = get(permanent_points, {'XData', 'YData'});
        new_x = [current_permanent_points{1}, x + length2 * cos(t1 + t2)];
        new_y = [current_permanent_points{2}, y + length2 * sin(t1 + t2)];
        set(permanent_points, 'XData', new_x, 'YData', new_y);

        xlim([-15,15]);
        ylim([0,20]);
        drawnow;
        pause(0.1);
    end

end





