%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes, Marc Fernandes, Victor Savall
%//////////////////////////////////////////////////////////////////////////
function [M_crit, Cp_intersect] = find_intersection(M_inf, Cp_sonic, Cp_lai_rule)

% Calcula la diferencia entre ambas curvas
delta = Cp_sonic - Cp_lai_rule;

% Encuentra el primer cruce de signo (posible punto de intersección)
idx = find(delta(1:end-1) .* delta(2:end) < 0, 1, 'first');

if isempty(idx)
    M_crit = NaN;          % No se encontró intersección
    Cp_intersect = NaN;
else
    % Interpolación lineal para obtener M_crit más preciso
    M_crit = interp1(delta(idx:idx+1), M_inf(idx:idx+1), 0, 'linear');
    Cp_intersect = interp1(M_inf, Cp_sonic, M_crit);
end

end
