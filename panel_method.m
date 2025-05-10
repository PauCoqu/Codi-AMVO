%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes, Marc Fernandes, Victor Savall
%//////////////////////////////////////////////////////////////////////////
function [gamma_vec, Q_inf, Q_inf_m, X_c] = panel_method(X, angles_rad, salphaj, calphaj, lpanj, Tc, N)

% Inicialización
b = zeros(N, 1);
a = zeros(N, N);
X_c = zeros(N, 2);

% Cálculo de los puntos medios de cada panel
for k = 1:N
    X_c(k, :) = (X(k, :) + X(k + 1, :)) / 2;
end

U_inf = 1;
Q_inf = zeros(length(angles_rad), 2);
Q_inf_m = zeros(length(angles_rad), 1);
gamma_vec = zeros(N, length(angles_rad));

for l = 1:length(angles_rad)
    Q_inf(l, 1) = U_inf * cos(angles_rad(l));
    Q_inf(l, 2) = U_inf * sin(angles_rad(l));
    Q_inf_m(l) = norm(Q_inf(l, :));

    for i = 1:N
        Q_inf_p = Q_inf(l, :);
        b(i) = -dot(Q_inf_p, Tc(i, :)); % Producto escalar con tangente

        for j = 1:N
            if j == i
                a(i, j) = -0.5;
            else
                % Coordenadas del centro del panel i respecto al panel j
                X_cpanj = (X_c(i, 1) - X(j, 1)) * calphaj(j) - (X_c(i, 2) - X(j, 2)) * salphaj(j);
                Z_cpanj = (X_c(i, 1) - X(j, 1)) * salphaj(j) + (X_c(i, 2) - X(j, 2)) * calphaj(j);

                r_1 = sqrt(X_cpanj^2 + Z_cpanj^2);
                r_2 = sqrt((X_cpanj - lpanj(j))^2 + Z_cpanj^2);

                theta_1 = atan2(Z_cpanj, X_cpanj);
                theta_2 = atan2(Z_cpanj, X_cpanj - lpanj(j));

                wpanj = (1 / (4 * pi)) * log(r_2^2 / r_1^2);
                upanj = (theta_2 - theta_1) / (2 * pi);

                u_ij = upanj * calphaj(j) + wpanj * salphaj(j);
                w_ij = -upanj * salphaj(j) + wpanj * calphaj(j);

                a(i, j) = u_ij * Tc(i, 1) + w_ij * Tc(i, 2);
            end
        end
    end

    % Imposición de la condición de Kutta
    kutta_index = round(N / 4);
    a(kutta_index, :) = 0;
    a(kutta_index, 1) = 1;
    a(kutta_index, N) = 1;
    b(kutta_index) = 0;

    % Resolver el sistema lineal
    gamma = a \ b;
    gamma_vec(:, l) = gamma(:);
end

end
