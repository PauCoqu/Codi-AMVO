%//////////////////////////////////////////////////////////////////////////
% Group 3: Marc Codes, Marc Fernandes, Victor Savall
%//////////////////////////////////////////////////////////////////////////
function plotProfile(X, titleStr, nodeRanges, colors)
    % Plotea las coordenadas del perfil NACA
    figure;
    hold on;
    
    for i = 1:length(nodeRanges)
        range = nodeRanges{i};
        plot(X(range, 1), X(range, 2), 'o-', 'Color', colors{i});
    end

    title(titleStr, 'Interpreter', 'none');
    xlabel('X Coordinate');
    ylabel('Z Coordinate');
    axis equal;

    if length(nodeRanges) > 1
        legend('Profile 1', 'Profile 2');
    else
        legend('Profile');
    end

    grid on;
    hold off;
end
