%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes, Marc Fernandes, Victor Savall
%//////////////////////////////////////////////////////////////////////////
function [Nc, Tc, salphaj, calphaj, lpanj] = calculNcTc_Fowler(X, N)
    salphaj = zeros(N, 1);
    calphaj = zeros(N, 1);
    lpanj = zeros(N, 1);
    Nc = zeros(N, 2); % Vectores normales
    Tc = zeros(N, 2); % Vectores tangenciales

    for j = 1:N
        lpanj(j) = sqrt((X(j+1, 1) - X(j, 1))^2 + (X(j+1, 2) - X(j, 2))^2);
        salphaj(j) = -(X(j+1, 2) - X(j, 2)) / lpanj(j);
        calphaj(j) = (X(j+1, 1) - X(j, 1)) / lpanj(j);
        Nc(j, 1) = salphaj(j);
        Nc(j, 2) = calphaj(j);
        Tc(j, 1) = calphaj(j);
        Tc(j, 2) = -salphaj(j);
    end
end
