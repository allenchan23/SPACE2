%% FUNCTION - Check if node index is within map
% Given a set of matrix coordinates, determine if it is a valid position in
% the given map
% j - Map matrix j position
% j - Map matrix j position
% Return bool - T/F

% Author: Allen Chan

function bool = isValid(j,i)   
    
    global CELLL   % Get map length
    global CELLH   % Get map height
    
    % Check if we are going to a valid cell
    if (i >= 1 && i <= CELLL) && (j >= 1 && j <= CELLH)
        bool = true;
        return;
    else
        bool = false;
        return;
    end
end