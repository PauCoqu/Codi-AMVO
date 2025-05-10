%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes, Marc Fernandes, Victor Savallaaa
%//////////////////////////////////////////////////////////////////////////
function [Nc, Tc, salphaj, calphaj, lpanj] = calculNcTc(X, N)
% Esta función calcula los vectores normales y tangenciales,
% así como senos y cosenos del ángulo del panel y su longitud.

% Inicialización de vectores
salphaj = zeros(N, 1);
calphaj = zeros(N, 1);
lpanj   = zeros(N, 1);
Nc      = zeros(N, 2); % Vectores normales
Tc      = zeros(N, 2); % Vectores tangenciales

% Cálculo de los vectores normales y tangenciales para cada panel
for j = 1:N
    dx = X(j+1, 1) - X(j, 1);
    dz = X(j+1, 2) - X(j, 2);
    lpanj(j)   = sqrt(dx^2 + dz^2);
    salphaj(j) = -dz / lpanj(j);
    calphaj(j) =  dx / lpanj(j);
    
    % Normal: perpendicular hacia afuera
    Nc(j, 1) = salphaj(j);
    Nc(j, 2) = calphaj(j);

    % Tangente: dirección del panel
    Tc(j, 1) = calphaj(j);
    Tc(j, 2) = -salphaj(j);
end

end
