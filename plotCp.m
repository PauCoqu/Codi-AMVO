%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes, Marc Fernandes, Victor Savall
%//////////////////////////////////////////////////////////////////////////
function plotCp(X, X_c, Nc, Cp, scale)
    figure;
    hold on;

    % Plot pressure vectors
    for i = 1:length(Cp)
        norm_Nc = Nc(i, :) / norm(Nc(i, :));

        % Scale vector by the absolute value of Cp for length representation
        scaled_Nc = abs(Cp(i)) * norm_Nc * scale;

        % Print Cp vectors according to their sign
        if Cp(i) < 0
            quiver(X_c(i, 1), X_c(i, 2), scaled_Nc(1), scaled_Nc(2), ...
                   'AutoScale', 'off', 'Color', 'b');
        else
            quiver(X_c(i, 1), X_c(i, 2), scaled_Nc(1), scaled_Nc(2), ...
                   'AutoScale', 'off', 'Color', 'r');
        end
    end

    axis equal;

    % Profile plot
    for j = 1:size(X, 1) - 1
        if j ~= 401  % Asegura que no se plotea un segmento específico (por diseño)
            plot([X(j, 1), X(j + 1, 1)], [X(j, 2), X(j + 1, 2)], 'k-');
        end
    end

    title('Pressure Coefficients on Panel Centers');
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
    grid on;
    hold off;
end
