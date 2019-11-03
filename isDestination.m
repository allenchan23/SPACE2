%% FUNCTION - Check if we have reached our final destination
% Given a set of input and destination matrix coordinates, determine if 
% it has reached the destination
% i - Map matrix i position - current
% j - Map matrix j position - current
% iDest - Map matrix i position - destination
% jDest - Map matrix j position - destination
% Return bool - T/F

% Author: Allen Chan

function bool = isDestination(i,j,iDest,jDest)    
    % Check if indexs agree
    if (i == iDest) && (j == jDest)
        bool = true;
    else
        bool = false;
    end
end