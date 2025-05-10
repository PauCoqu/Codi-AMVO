%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes , Marc Fernandes , Victor Savall
%//////////////////////////////////////////////////////////////////////////
function [Cl, Cp, Vi_ext, Cm14, Cm0, F, M14] = Coefficients_calc_Fowler(gamma, lpanj, Q_inf, N, X, X_c)

    % Inicialización de variables
    Cl = 0;
    Cp = zeros(N, 1);
    Vi_ext = zeros(N, 1);
    c = 1; % Cuerda de referencia (para NACA0010)
    Q_inf_Fowler = Q_inf(1); % Componente horizontal del vector velocidad
    rho = 1.225;

    F = 0;
    Cm0 = 0;
    Cm14 = 0;

    % Eliminar la fila 401 correspondiente al panel de corte entre flap y ala
    lpanj(401) = [];

    for i = 1:N
        if i == 401
            continue; % Saltar iteración en el panel de unión flap-ala
        end

        partf = gamma(i) * lpanj(i);
        Vi_ext(i) = abs(gamma(i));
        Cp(i) = 1 - (gamma(i) / Q_inf_Fowler)^2;

        F = F + partf;

        % Cálculo de momento respecto al centro aerodinámico (c/4)
        Cm0 = Cm0 + Cp(i) * ((X_c(i, 1) * (X(i+1, 1) - X(i, 1)) + X_c(i, 2) * (X(i+1, 2) - X(i, 2))) / c^2);
        Cm14 = Cm14 + Cp(i) * (((X_c(i, 1) - 0.25 * c) * (X(i+1, 1) - X(i, 1)) + X_c(i, 2) * (X(i+1, 2) - X(i, 2))) / c^2);
    end

    Cl = 2 * F / (Q_inf_Fowler * c);
    M14 = 0.5 * rho * Q_inf_Fowler^2 * Cm14;

end
