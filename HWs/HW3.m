%% HW3

%% Problem 1 (7.7)
clf(figure(1));
xdd_plant = @(alpha1, alpha2, x, v) [x(2), -alpha1*abs(x(1))*x(2)^2-alpha2*x(1)^3*cos(2*x(1))+v];

syms x1 x2 v
dt=1e-3;
ts = 0:dt:pi/100;
xs = [];
alpha1s = [-1, 0, 1, 2*(rand(1)-0.5)];
alpha2s = [-1, 2, 5, 6*(rand(1)-0.5)];
i1 = 0;

%trajectory -- pos->acc
% x_des = sin(ts)';
% % x_des = ts';
% xd_des = diff(x_des)/dt; xd_des = [xd_des; xd_des(end)];
% xdd_des = diff(xd_des)/dt; xdd_des = [xdd_des; xdd_des(end)];

%acceleration -- acc->pos
xdd_des = sin(pi/2*ts)';
xd_des = cumsum(dt*xdd_des);
x_des = cumsum(dt*xd_des);

trajectory = [x_des, xd_des, xdd_des];
subplot(3,2,1)
plot(ts, x_des, 'rx')
subplot(3,2,2)
plot(ts, xd_des, 'rx')

% contoller constants
% v = 5*ud + u
eta = 1e-1;
lambda = 200;
phi = 0.1;
k_func = @(x) abs(x(1))*x(2)^2 + 3*x(1)^3*cos(2*x(1)) + eta;
s_func = @(x,x_des) x(2)-x_des(2) + lambda*(x(1) - x_des(1));
v_func = @(x,x_des) -2*x(1)^3*cos(2*x(1)) + x_des(3) - lambda*(x(2)-x_des(2)) - k_func(x)*sign(s_func(x,x_des));
v_func = @(x,x_des) -2*x(1)^3*cos(2*x(1)) + x_des(3) - lambda*(x(2)-x_des(2)) - k_func(x)*min(1, max(-1, s_func(x,x_des)/phi)); %saturation function
vs = [];

% test different plants
for alpha1 = alpha1s
    i1 = i1 + 1;
    i2 = 0;
    for alpha2 = alpha2s
        xdd = @(x, v) xdd_plant(alpha1, alpha2, x, v);
        fprintf('Alpha 1: %0.4f, Alpha2: %0.4f \n', alpha1, alpha2)
        plant = xdd([x1, x2], v);
        fprintf('Actual Plant: %s \n', plant(2))
        
        i2 = i2 + 1;
        x_temp = [];
        v_temp = [];
        s_temp = [];
        it = 1;
        t_last = 0;
        x = trajectory(it,1:2);
        for t = ts
            s = s_func(x, trajectory(it,:));
            v = v_func(x, trajectory(it,:));
            v_temp = [v_temp; v];
            dt = t-t_last;
            x_new = x + dt*xdd(x, v);
            x_temp = [x_temp; x_new];
            s_temp = [s_temp; s];
            x = x_new;
            it= it+1;
        end
        xs = cat(3, xs, x_temp);
        vs = cat(3, vs, v_temp);
        
        % position
        subplot(3,2,1)
        hold on
        plot(ts, x_temp(:,1), 'bo')
        title('Position')
        legend('Ref', 'Actual')
        
        % position error
        subplot(3,2,3)
        hold on
        plot(ts, x_temp(:,1) - trajectory(:,1), 'kx-')
        title('Position Tracking Error')
        
        % velocity
        subplot(3,2,2)
        hold on
        plot(ts, x_temp(:,2), 'bo')
        title('Velocity')
        legend('Ref', 'Actual')
        
        % velocity error
        subplot(3,2,4)
        hold on
        plot(ts, x_temp(:,2) - trajectory(:,2), 'kx-')
        title('Position Tracking Error')
        
        % control input
        subplot(3,2,5)
        plot(ts, v_temp, 'kx-')
        title('Control Input')
        
        % s plot
        subplot(3,2,6)
        plot(ts, s_temp, 'kx-')
        title('S Plot')
        
    end
end
