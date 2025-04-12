
function taylor_maccoll_analysis()
    % Taylor-Maccoll Solver for Supersonic Flow Over a Cone
    % ------------------------------------------------------
    % Computes compressible, axisymmetric flow over a cone using
    % oblique shock relations and Taylor-Maccoll ODEs integrated with RK4.
    % Performs grid convergence study for Δψ = 0.1°, 0.2°, 0.4°.
    % Generates flow plots and exports CSV data for ∆ψ = 0.2°.

    % ----------------------- Input Parameters ---------------------------
    gamma = 1.405;                % Specific heat ratio for air
    M1 = 1.80;                    % Freestream Mach number
    theta_s_deg = 45;            % Shock wave angle (degrees)
    dpsi_deg_array = [0.1, 0.2, 0.4];  % Angular step sizes for convergence

    theta_s = deg2rad(theta_s_deg);   % Convert shock angle to radians

    % Allocate for results from each step size
    num_cases = numel(dpsi_deg_array);
    psi_deg_all = cell(1, num_cases);
    M_all = cell(1, num_cases);
    p_p1_all = cell(1, num_cases);
    labels = cell(1, num_cases);

    % --------------------- Main Loop for Step Sizes ----------------------
    for idx = 1:num_cases
        dpsi_deg = dpsi_deg_array(idx);    % Current angular step (deg)
        dpsi = deg2rad(dpsi_deg);          % Convert to radians

        % Compute post-shock flow state using oblique shock theory
        [M2, p02_p01] = compute_post_shock_conditions(M1, theta_s, gamma);

        % Initialize Taylor-Maccoll state at shock
        Vr0 = M2 * cos(theta_s);           % Radial velocity
        Vpsi0 = -M2 * sin(theta_s);        % Angular velocity
        psi0 = theta_s;                    % Initial angle (shock)

        % Integrate ODEs using RK4 to get flow field
        [psi_array, Vr_array, Vpsi_array] = integrate_taylor_maccoll(Vr0, Vpsi0, psi0, dpsi, gamma);

        % Compute flow properties at each point
        M_array = sqrt(Vr_array.^2 + Vpsi_array.^2);  % Mach number
        p_p1_array = ((1 + (gamma - 1)/2 * M1^2) ./ ...
                     (1 + (gamma - 1)/2 * M_array.^2)).^(gamma/(gamma - 1)); % Static pressure ratio
        T_T1_array = ((1 + (gamma - 1)/2 * M1^2) ./ ...
                     (1 + (gamma - 1)/2 * M_array.^2));                      % Temperature ratio
        rho_rho1_array = p_p1_array ./ T_T1_array;                           % Density ratio

        % Extract cone surface quantities (final step)
        delta_c = rad2deg(psi_array(end));           % Cone angle (degrees)
        Mc = M_array(end);                           % Surface Mach number
        Cp = (2 / (gamma * M1^2)) * (p_p1_array(end) - 1); % Pressure coefficient

        % Display to command window
        fprintf('\n=== Δψ = %.1f° ===\n', dpsi_deg);
        fprintf('Cone angle δc  = %.5f deg\n', delta_c);
        fprintf('Surface Mach Mc = %.5f\n', Mc);
        fprintf('Pressure Coeff. Cp = %.5f\n', Cp);
        fprintf('p₀₂/p₀₁ = %.5f\n', p02_p01);

        % Store for plotting
        psi_deg_all{idx} = rad2deg(psi_array);
        M_all{idx} = M_array;
        p_p1_all{idx} = p_p1_array;
        labels{idx} = sprintf('Δψ = %.1f°', dpsi_deg);

        % Export data table for Δψ = 0.2°
        if abs(dpsi_deg - 0.2) < 1e-6
            results_table = table(rad2deg(psi_array(:)), Vr_array(:), Vpsi_array(:), ...
                M_array(:), p_p1_array(:), T_T1_array(:), rho_rho1_array(:), ...
                'VariableNames', {'psi_deg', 'Vr', 'Vpsi', 'Mach', 'p_over_p1', 'T_over_T1', 'rho_over_rho1'});
            writetable(results_table, 'flow_data_dpsi_0_2.csv');
            fprintf('Exported flow data to "flow_data_dpsi_0_2.csv"\n');
        end
    end

    % Plot Mach number and pressure ratio vs ψ for all resolutions
    plot_grid_convergence(psi_deg_all, M_all, p_p1_all, labels);
end

% -------------------- Helper Functions ----------------------------

function [M2, p02_p01] = compute_post_shock_conditions(M1, theta_s, gamma)
    % Compute post-shock Mach and stagnation pressure ratios
    Mn1 = M1 * sin(theta_s);
    Mn2_sq = (1 + (gamma - 1)/2 * Mn1^2) / ...
             (gamma * Mn1^2 - (gamma - 1)/2);
    Mn2 = sqrt(Mn2_sq);
    M2 = Mn2 / sin(theta_s);  % Tangential Mach after shock
    p2_p1 = 1 + 2 * gamma / (gamma + 1) * (Mn1^2 - 1);
    p02_p01 = ((1 + (gamma - 1)/2 * M1^2) / ...
               (1 + (gamma - 1)/2 * M2^2))^(gamma/(gamma - 1)) * p2_p1^(-1);
end

function [psi_array, Vr_array, Vpsi_array] = integrate_taylor_maccoll(Vr0, Vpsi0, psi0, dpsi, gamma)
    % Integrate Taylor-Maccoll ODEs using 4th-order Runge-Kutta method
    Vr = Vr0; Vpsi = Vpsi0; psi = psi0;

    psi_array = psi; Vr_array = Vr; Vpsi_array = Vpsi;

    while abs(Vpsi) > 1e-5 && psi > 0
        % RK4 Step 1
        [dVr1, dVpsi1] = taylor_maccoll_rhs(Vr, Vpsi, gamma);
        % RK4 Step 2
        [dVr2, dVpsi2] = taylor_maccoll_rhs(Vr + 0.5*dpsi*dVr1, Vpsi + 0.5*dpsi*dVpsi1, gamma);
        % RK4 Step 3
        [dVr3, dVpsi3] = taylor_maccoll_rhs(Vr + 0.5*dpsi*dVr2, Vpsi + 0.5*dpsi*dVpsi2, gamma);
        % RK4 Step 4
        [dVr4, dVpsi4] = taylor_maccoll_rhs(Vr + dpsi*dVr3, Vpsi + dpsi*dVpsi3, gamma);

        % Update solution
        Vr = Vr + (dpsi/6)*(dVr1 + 2*dVr2 + 2*dVr3 + dVr4);
        Vpsi = Vpsi + (dpsi/6)*(dVpsi1 + 2*dVpsi2 + 2*dVpsi3 + dVpsi4);
        psi = psi - dpsi;

        psi_array(end+1) = psi;
        Vr_array(end+1) = Vr;
        Vpsi_array(end+1) = Vpsi;
    end
end

function [dVr, dVpsi] = taylor_maccoll_rhs(Vr, Vpsi, gamma)
    % Taylor-Maccoll right-hand side function
    M_sq = Vr^2 + Vpsi^2;
    dVr = Vpsi;
    dVpsi = -((Vr^2 - Vpsi^2)/Vr + ((gamma - 1)/2)*(M_sq - 1)*Vpsi/Vr);
end

function plot_grid_convergence(psi_deg_all, M_all, p_p1_all, labels)
    % Generate Mach number and pressure plots vs psi angle
    figure;
    subplot(2,1,1); hold on;
    for i = 1:numel(M_all)
        plot(psi_deg_all{i}, M_all{i}, 'LineWidth', 1.5);
    end
    xlabel('\psi (deg)'); ylabel('Mach Number');
    title('Mach Number vs \psi'); legend(labels, 'Location', 'southwest');
    grid on; set(gca, 'XDir', 'reverse');

    subplot(2,1,2); hold on;
    for i = 1:numel(p_p1_all)
        plot(psi_deg_all{i}, p_p1_all{i}, 'LineWidth', 1.5);
    end
    xlabel('\psi (deg)'); ylabel('p/p_1');
    title('Static Pressure Ratio vs \psi'); legend(labels, 'Location', 'southwest');
    grid on; set(gca, 'XDir', 'reverse');
end
