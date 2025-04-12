data = readtable('flow_data_dpsi_0_2.csv');
psi = data.psi_deg;

figure;
subplot(2,2,1);
plot(psi, data.Vr); title('V_r vs \psi'); xlabel('\psi (deg)'); ylabel('V_r'); grid on;

subplot(2,2,2);
plot(psi, data.Vpsi); title('V_\psi vs \psi'); xlabel('\psi (deg)'); ylabel('V_\psi'); grid on;

subplot(2,2,3);
plot(psi, data.Mach); title('Mach vs \psi'); xlabel('\psi (deg)'); ylabel('Mach'); grid on;

subplot(2,2,4);
plot(psi, data.p_over_p1, psi, data.T_over_T1, psi, data.rho_over_rho1);
title('Thermodynamic Ratios vs \psi');
xlabel('\psi (deg)');
ylabel('Ratio'); 
legend('p/p_1','T/T_1','\rho/\rho_1');
grid on;

% Save entire 2x2 plot as PNG
exportgraphics(gcf, 'flow_distribution_plots.png', 'Resolution', 300);
