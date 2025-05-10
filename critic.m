%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes, Marc Fernandes, Victor Savall
%//////////////////////////////////////////////////////////////////////////
function [Cp_lai_rule, Cp_sonic, M_crit, M_inf] = critic(gamma_air, N, Cp)

angles = [0, 2, 4, 6];
angles_rad = angles .* pi / 180; % Convert angles to radians
M_inf = linspace(0.1, 1, N);     % Mach number discretization from 0.1 to 1

Cp_lai_rule = zeros(N, length(angles_rad));
Cp_sonic = zeros(N, length(angles_rad));
M_crit = zeros(length(angles_rad), 1);

for l = 1:length(angles_rad)
    Cp_0 = min(Cp(:, l)); % Minimum Cp for each angle

    for j = 1:length(M_inf)
        Mj = M_inf(j);
        sqrt_term = sqrt(1 - Mj^2);

        % Laitone's rule for Cp
        num = Cp_0;
        denom = sqrt_term + (Cp_0 / 2) * Mj^2 / sqrt_term * (1 + (gamma_air - 1)/2 * Mj^2);
        Cp_lai_rule(j, l) = num / denom;

        % Sonic Cp (isentropic flow)
        Cp_sonic(j, l) = (2 / (gamma_air * Mj^2)) * ...
            (((2 + (gamma_air - 1) * Mj^2) / (1 + gamma_air))^(gamma_air / (gamma_air - 1)) - 1);
    end
end

% Find intersection between Cp_sonic and Cp_lai_rule for each angle
for i = 1:length(angles_rad)
    M_crit(i) = find_intersection(M_inf, Cp_sonic(:, i), Cp_lai_rule(:, i));
end

end
