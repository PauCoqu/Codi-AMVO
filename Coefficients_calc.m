%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes, Marc Fernandes, Victor Savall
%//////////////////////////////////////////////////////////////////////////
function [Cl, Cp, Vi_ext, Cm14, Cm0] = Coefficients_calc(gamma_vec, lpanj, Q_inf_m, angles_rad, N, X, X_c)

Cl = zeros(length(angles_rad), 1);
Cp = zeros(N, length(angles_rad));
Vi_ext = zeros(N, length(angles_rad));
Cm14 = zeros(length(angles_rad), 1);
Cm0 = zeros(length(angles_rad), 1);

c = 1; % Chord length (for NACA0010 or any constant-chord airfoil)

for l = 1:length(angles_rad)
    F = 0;
    Cm0_sum = 0;

    for i = 1:N
        partf = gamma_vec(i, l) * lpanj(i);
        Vi_ext(i, l) = abs(gamma_vec(i, l));
        Cp(i, l) = 1 - (gamma_vec(i, l) / Q_inf_m(l))^2;
        F = F + partf;

        deltaX = X(i+1,1) - X(i,1);
        deltaZ = X(i+1,2) - X(i,2);
        Cm0_sum = Cm0_sum + Cp(i, l) * ((X_c(i, 1) * deltaX + X_c(i, 2) * deltaZ) / c^2);
    end

    Cl(l) = 2 * F / (Q_inf_m(l) * c);
    Cm14(l) = Cm0_sum + 0.25 * Cl(l);
    Cm0(l) = Cm0_sum;
end

end
