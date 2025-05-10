%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes, Marc Fernandes, Victor Savall
%//////////////////////////////////////////////////////////////////////////
function [gamma, Q_inf, X_c, N_Fowler] = panel_method_Fowler(X, salphaj, calphaj, lpanj, Tc, N)
    a = zeros(N, N);
    b = zeros(N, 1);
    Q_inf = [];
    N_Fowler = N - 1;

    % Coordenadas de los centros de los paneles
    X_c = zeros(N, 2);
    for k = 1:N
        X_c(k, :) = (X(k, :) + X(k+1, :)) / 2;
    end

    U_inf = 1; % m/s
    Q_inf = [U_inf * cos(0), U_inf * sin(0)];

    % Vector independiente b
    for i = 1:N
        b(i) = -dot(Q_inf, Tc(i, :));
    end

    % Matriz del sistema a
    for i = 1:N
        for j = 1:N
            if j == i
                a(i, j) = -0.5;
            else
                X_cpanj = (X_c(i, 1) - X(j, 1)) * calphaj(j) - (X_c(i, 2) - X(j, 2)) * salphaj(j);
                Z_cpanj = (X_c(i, 1) - X(j, 1)) * salphaj(j) + (X_c(i, 2) - X(j, 2)) * calphaj(j);

                r_1 = sqrt(X_cpanj^2 + Z_cpanj^2);
                r_2 = sqrt((X_cpanj - lpanj(j))^2 + Z_cpanj^2);

                theta_1 = atan2(Z_cpanj, X_cpanj);
                theta_2 = atan2(Z_cpanj, (X_cpanj - lpanj(j)));

                wpanj = 1 / (4 * pi) * log(r_2^2 / r_1^2);
                upanj = (theta_2 - theta_1) / (2 * pi);

                u_ij = upanj * calphaj(j) + wpanj * salphaj(j);
                w_ij = -upanj * salphaj(j) + wpanj * calphaj(j);

                a(i, j) = u_ij * Tc(i, 1) + w_ij * Tc(i, 2);
            end
        end
    end

    % Correcciones por corte en flap Fowler
    a(401, :) = [];
    a(:, 401) = [];
    b(401) = [];
    X_c(401, :) = [];

    % Condición de Kutta (en borde de salida del ala y del flap)
    for j = 1:600
        a(100, j) = 0;
        a(500, j) = 0;
    end
    a(100, 1) = 1;
    a(100, 400) = 1;
    b(100) = 0;

    a(500, 401) = 1;
    a(500, 600) = 1;
    b(500) = 0;

    % Resolver el sistema
    gamma = a \ b;
end
