%% CODI PROJECT PART 1
%---------------------------------------------
% Data: 25/04/2025
% Membres: Antonio Luque, Pau Cornudella i Alex Aleñà
% Assignatura: AERODINÀMICA, MECÀNICA DE VOL I ORBITAL
% Grup: 6
% ---------------------------------------------
clc; clear; close all;

function X_rotated = rotateCoordinates(X, angle_deg)
    % Convierte el ángulo de grados a radianes
    angle_rad = angle_deg * pi / 180;

    % Matriz de rotación 2D
    R = [cos(angle_rad), sin(angle_rad);
        -sin(angle_rad), cos(angle_rad)];

    % Aplica la rotación a todos los puntos
    X_rotated = (R * X')';
end
