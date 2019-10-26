%% Function for checking validity of a node
function bool = isValid(j,i)   
    
    global CELLL
    global CELLH  
    
    % Check if we are going to a valid cell
    if (i >= 1 && i <= CELLL) && (j >= 1 && j <= CELLH)
        bool = true;
        return;
    else
        bool = false;
        return;
    end
end