%% FUNCTION - Calculate Heuristics
% Function used to determine the cost between two points
% V - Start Node
% D - Destination Node
% Return: h - heuristic result -> straight line distance between 2 points

% Author: Allen Chan

function h = calculateH(V,D)    

    % return H value
    h = sqrt((D.x-V.x)^2+(D.y-V.y)^2);
    return;
    
end
