%% Function to check if we have reached the final destination
%%
function bool = isDestination(i,j,iDest,jDest)    
    % Check if we are going to a valid cell
    if (i == iDest) && (j == jDest)
        bool = true;
    else
        bool = false;
    end
end