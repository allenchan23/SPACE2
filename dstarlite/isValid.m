%% Function for checking validity of a node
% Function used update vertex cost for D* Lite Algorithm
% [i j] - matrix index
% Return: F - not Valid | T - Valid

% Author: Allen Chan

function bool = isValid(j,i)   
    
    % get maximum matrix dimensions
    global CELLL;
    global CELLH; 
    
    % Check if we are going to a valid cell
    if (i >= 1 && i <= CELLL) && (j >= 1 && j <= CELLH)
        bool = true;
        return;
    else
        bool = false;
        return;
    end
end