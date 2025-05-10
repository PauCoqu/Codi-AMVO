%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes, Marc Fernandes, Victor Savall
%//////////////////////////////////////////////////////////////////////////
close all;
clear all;

% Define rotation angles
angles = [0, 2, 4, 6, 8, 10];
angles_rad = deg2rad(angles);

%% FOR NACA 2412 AIRFOIL
fileOptions = {
    'NACA_22112_N_32.txt', ...
    'NACA_22112_N_64.txt', ...
    'NACA_22112_N_128.txt', ...
    'NACA_22112_N_256.txt', ...
    'NACA_22112_N_512.txt'};

[X_22112, N_22112, choice, angleChoice] = readAndProcessFile(fileOptions, angles, 0);

[Nc_22112, Tc_22112, salphaj_22112, calphaj_22112, lpanj_22112] = calculNcTc(X_22112, N_22112);
[gamma_vec_22112, Q_inf, Q_inf_m, X_c_22112] = panel_method(X_22112, angles_rad, ...
    salphaj_22112, calphaj_22112, lpanj_22112, Tc_22112, N_22112);
[Cl_22112, Cp_22112, Vi_ext_22112, Cm14_22112, Cm0_22112] = ...
    Coefficients_calc(gamma_vec_22112, lpanj_22112, Q_inf_m, ...
    angles_rad, N_22112, X_22112, X_c_22112);

gamma_air = 1.4;
[Cp_lai_rule, Cp_sonic, M_crit, M_inf] = critic(gamma_air, N_22112, Cp_22112);

for l = 1:4
    figure;
    plot(M_inf, Cp_sonic(:, l), 'b');
    set(gca, 'YDir', 'reverse');
    hold on;
    plot(M_inf, Cp_lai_rule(:, l), 'r--');
    hold off;
    if l == 3 || l == 4
        xlim([0.2 0.6]);
    else
        xlim([0.2 0.8]);
    end
    xlabel('$M_\infty$', 'Interpreter', 'latex');
    ylabel('${C_{p}}^{*}$', 'Interpreter', 'latex');
    legend('${C_{p}}^{*}$', '$C_{p_{Laitone}}$', 'Interpreter', 'latex');
end

% Rotate coordinates
X_22112_rotated = rotateCoordinates(X_22112, angles(angleChoice));
Xc_22112_rotated = rotateCoordinates(X_c_22112, angles(angleChoice));

% Plot profile
plotProfile(X_22112_rotated, 'NACA 2412 Profile Coordinates', {1:N_22112+1}, {'b'});

% Correct Cp to remove Kutta condition from plot
scale22112 = [0.8, 1, 0.9, 0.4, 0.25, 0.15];
Cp_22112(N_22112/4, angleChoice) = (Cp_22112(N_22112/4+1, angleChoice) + Cp_22112(N_22112/4-1, angleChoice)) / 2;
plotCp(X_22112_rotated, Xc_22112_rotated, Nc_22112, Cp_22112(:, angleChoice), scale22112(angleChoice));

%% FOR NACA 0010 AIRFOIL
fileOptions = {
    'NACA_0012_N_16.txt', ...
    'NACA_0012_N_32.txt', ...
    'NACA_0012_N_64.txt', ...
    'NACA_0012_N_128.txt', ...
    'NACA_0012_N_256.txt', ...
    'NACA_0012_N_512.txt'};

[X_0012, N_0012, choice, angleChoice] = readAndProcessFile(fileOptions, angles, 0);

[Nc_0012, Tc, salphaj, calphaj, lpanj] = calculNcTc(X_0012, N_0012);
[gamma_vec, Q_inf, Q_inf_m, X_c_0012] = panel_method(X_0012, angles_rad, ...
    salphaj, calphaj, lpanj, Tc, N_0012);

X_0012_rotated = rotateCoordinates(X_0012, angles(angleChoice));
Xc_0012_rotated = rotateCoordinates(X_c_0012, angles(angleChoice));

plotProfile(X_0012_rotated, 'NACA 0012 Profile Coordinates', {1:N_0012+1}, {'b'});

[Cl_0012, Cp_0012, Vi_ext_0012, Cm14_0012, Cm0_0012] = ...
    Coefficients_calc(gamma_vec, lpanj, Q_inf_m, angles_rad, ...
    N_0012, X_0012, X_c_0012);

scale0012 = [0.6, 0.6, 0.5, 0.3, 0.2, 0.1];
Cp_0012(N_0012/4, angleChoice) = (Cp_0012(N_0012/4+1, angleChoice) + Cp_0012(N_0012/4-1, angleChoice)) / 2;
plotCp(X_0012_rotated, Xc_0012_rotated, Nc_0012, Cp_0012(:, angleChoice), scale0012(angleChoice));

%% FOR FOWLER FLAP
fileOptions = {
    'NACA_22112_flap_15deg_401_201.txt', ...
    'NACA_22112_flap_30deg_401_201.txt'};

[X_Fowler, N_Fowler, choice, angleChoice] = readAndProcessFile(fileOptions, angles, 1);

% Plot both flap and main airfoil sections
plotProfile(X_Fowler, 'NACA 2412 with Fowler Flap Coordinates', {1:401, 402:602}, {'r', 'b'});

[Nc, Tc, salphaj, calphaj, lpanj] = calculNcTc_Fowler(X_Fowler, N_Fowler);
[gamma, Q_inf, X_c_Fowler, N_Fowler2] = panel_method_Fowler(X_Fowler, ...
    salphaj, calphaj, lpanj, Tc, N_Fowler);
[Cl_Fowler, Cp_Fowler, Vi_ext_Fowler, Cm14_Fowler, Cm0_Fowler, F, M14] = ...
    Coefficients_calc_Fowler(gamma, lpanj, Q_inf, N_Fowler2, X_Fowler, X_c_Fowler);

% Eliminate Kutta condition from plot
Cp_Fowler(100) = (Cp_Fowler(101) + Cp_Fowler(99)) / 2;
Cp_Fowler(500) = (Cp_Fowler(501) + Cp_Fowler(499)) / 2;

% Plot Cp
if choice == 1
    plotCp(X_Fowler, X_c_Fowler, Nc, Cp_Fowler, 0.3);
elseif choice == 2
    plotCp(X_Fowler, X_c_Fowler, Nc, Cp_Fowler, 0.1);
end
