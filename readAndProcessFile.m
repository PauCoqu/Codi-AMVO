%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes, Marc Fernandes, Victor Savall
%//////////////////////////////////////////////////////////////////////////
function [X, N, choice, angleChoice] = readAndProcessFile(fileOptions, angles, a)

% Inicialización
choice = 0;
angleChoice = 0;

% Mostrar menú de selección de archivo
choice = menu('Choose a file to load:', fileOptions);

% Obtener el nombre del archivo seleccionado
filename = fileOptions{choice};

% Leer los datos del archivo
data = readmatrix(filename);

% Extraer coordenadas X y Z (asumiendo que están en las columnas 2 y 3)
X = data(:, 2:3);

% Calcular el número de paneles (N = número de nodos - 1)
N = size(X, 1) - 1;

% Convertir los ángulos a strings para mostrarlos en un menú
angleOptions = arrayfun(@(x) num2str(x), angles, 'UniformOutput', false);

% Si a == 0, permitir selección del ángulo de ataque
if a == 0
    angleChoice = menu('Choose an angle of attack:', angleOptions{:});
end

end
