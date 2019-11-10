function bool = isTraversable(V)    
    % Check if we are going to a valid cell
    if (V.trav == true)
        bool = true;
    else
        bool = false;
    end
    
    return;
end