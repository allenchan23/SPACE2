%% FUNCTION - Check if node index is traversable
% Given a node determine if we can traverse into that position, or if there
% is an obstacle
% V - Node
% Return bool - T - Traversable | F - Non-Traversable

% Author: Allen Chan

function bool = isTraversable(V)    
    % Check if we are going into a obstacle
    if (V.trav == true)
        bool = true;
    else
        bool = false;
    end
    
    return;
end