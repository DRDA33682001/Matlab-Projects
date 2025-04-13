% File: terminal_velocity_final_fixed.m
% Description: Fixed version with buoyancy and reliable 3D terminal velocity surface.
% Author: [Dron Das Purkayastha]
% Version: 3.5

clear; clc; close all;

%% Physical Constants
micron = 1e-6;
g = 9.81;
rho_water = 997;
mu_air = 1.81e-5;
rho_air = 1.225;

%% Simulation Parameters
dt = 1e-4;
t_max = 10;
v_threshold = 1e-4;

r_micron = 50;
r = r_micron * micron;
V = (4/3) * pi * r^3;
A = pi * r^2;
m = V * rho_water;
Fg = V * (rho_water - rho_air) * g;  % buoyancy corrected

%% Preallocate
n_steps = ceil(t_max / dt);
t_arr = zeros(1, n_steps);
v_arr = zeros(1, n_steps);
Fg_arr = Fg * ones(1, n_steps);
Fd_arr = zeros(1, n_steps);
Fnet_arr = zeros(1, n_steps);

% Initial conditions
v = 0; t = 0; idx = 1;
v_terminal = NaN; converged = false;
v_history = zeros(1, 100); after_converged_steps = 0;
max_after_steps = 1000;

%% Euler Integration
while t < t_max
    Re = rho_air * abs(v) * 2 * r / mu_air;
    if Re < 1e-8, Re = 1e-8; end

    if Re < 1000
        Cd = 24 / Re * (1 + 0.15 * Re^0.687);
    else
        Cd = 0.44;
    end

    Fd = 0.5 * Cd * rho_air * A * v^2 * sign(v);
    Fnet = Fg - Fd;
    a = Fnet / m;

    v = v + a * dt;
    t = t + dt;

    % Store
    t_arr(idx) = t;
    v_arr(idx) = v;
    Fd_arr(idx) = Fd;
    Fnet_arr(idx) = Fnet;

    v_history(mod(idx-1, 100) + 1) = v;
    if idx > 100 && std(v_history) < v_threshold
        if ~converged
            v_terminal = v;
            steady_time = t;
            converged = true;
        end
        after_converged_steps = after_converged_steps + 1;
    end
    if converged && after_converged_steps > max_after_steps
        break;
    end
    idx = idx + 1;
end

% Trim arrays
t_arr = t_arr(1:idx-1);
v_arr = v_arr(1:idx-1);
Fg_arr = Fg_arr(1:idx-1);
Fd_arr = Fd_arr(1:idx-1);
Fnet_arr = Fnet_arr(1:idx-1);

if ~converged
    v_terminal = max(abs(v_arr(end)), 1e-6);
    steady_time = t_arr(end);
end

%% Non-Dimensionalization
t_c = r / v_terminal;
t_star = t_arr / t_c;
v_star = v_arr / v_terminal;
Fd_star = Fd_arr / Fg;
Fg_star = Fg_arr / Fg;
Fnet_star = Fnet_arr / Fg;

%% Plotting
figure('Name','Terminal Velocity Summary', 'Position', [200 100 1000 800]);
tiledlayout(2,2, 'TileSpacing','compact');

% Velocity
nexttile;
plot(t_star, v_star, 'b-', 'LineWidth', 2); hold on;
yline(1, '--k', 'Terminal Velocity');
xlabel('$t^*$', 'Interpreter','latex');
ylabel('$v^* = v / v_t$', 'Interpreter','latex');
title('Non-Dimensional Velocity vs Time'); grid on;

% Forces
nexttile;
plot(t_star, Fg_star, '--k', 'LineWidth', 2); hold on;
plot(t_star, Fd_star, '-r', 'LineWidth', 2);
xlabel('$t^*$', 'Interpreter','latex');
ylabel('$F^* = F / (mg)$', 'Interpreter','latex');
title('Gravitational vs Drag Force'); legend('Fg','Fd'); grid on;

% Net force
nexttile;
plot(t_star, Fnet_star, ':m', 'LineWidth', 2);
xlabel('$t^*$', 'Interpreter','latex');
ylabel('$F^*_{net}$', 'Interpreter','latex');
title('Net Force Driving Acceleration'); grid on;

% Log Net force
nexttile;
semilogy(t_star, abs(Fnet_star), 'g-', 'LineWidth', 2);
xlabel('$t^*$', 'Interpreter','latex');
ylabel('$|F^*_{net}|$', 'Interpreter','latex');
title('Net Force Magnitude (Log Scale)'); grid on;

fprintf('\nTerminal Velocity (Simulated): %.5f m/s\n', v_terminal);
fprintf('Steady-state time: %.5f s\n', steady_time);

%% 3D Plot – Fixed Iterative Solver
[r_vec, rho_vec] = meshgrid(10:5:100, 1.0:0.05:1.5);
v_grid = zeros(size(r_vec));

for i = 1:numel(r_vec)
    r_i = r_vec(i) * micron;
    V_i = (4/3)*pi*r_i^3;
    A_i = pi * r_i^2;
    m_i = V_i * rho_water;
    Fg_i = V_i * (rho_water - rho_vec(i)) * g;

    % Solve terminal velocity via fixed-point iteration
    v = 1e-4;
    for iter = 1:1000
        Re = rho_vec(i) * abs(v) * 2 * r_i / mu_air;
        if Re < 1e-8, Re = 1e-8; end
        if Re < 1000
            Cd = 24 / Re * (1 + 0.15 * Re^0.687);
        else
            Cd = 0.44;
        end
        Fd = 0.5 * Cd * rho_vec(i) * A_i * v^2;
        v = sqrt(2 * Fg_i / (Cd * rho_vec(i) * A_i));
    end
    v_grid(i) = v;
end

% 3D Plot
figure('Name','Terminal Velocity Surface');
surf(r_vec, rho_vec, v_grid, 'EdgeColor','none');
xlabel('Droplet Radius ($\mu$m)', 'Interpreter','latex');
ylabel('Air Density (kg/m$^3$)', 'Interpreter','latex');
zlabel('Terminal Velocity (m/s)', 'Interpreter','latex');
title('Terminal Velocity vs Radius and Air Density');
colorbar; view(135, 30); grid on;
