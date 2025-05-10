%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes, Marc Fernandes, Victor Savall
%//////////////////////////////////////////////////////////////////////////
function X_rotated = rotateCoordinates(X, angle_deg)
    % Convierte el ángulo de grados a radianes
    angle_rad = angle_deg * pi / 180;

    % Matriz de rotación 2D
    R = [cos(angle_rad), sin(angle_rad);
        -sin(angle_rad), cos(angle_rad)];

    % Aplica la rotación a todos los puntos
    X_rotated = (R * X')';
end
