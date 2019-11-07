%% FUNCTION - Obtain top key from queue
% Used to return the top queue from a list
% Return Key: [k1 k2] array of secondary and primary keys

% Author: Allen Chan
function key = topKey()
    
    % Obtain access to queue
    global QUEUE;
    
    % For an occupied list
    if length(QUEUE(:,1)) > 0
        
        % Sort and remove top
        queueSort();
        key = QUEUE(1,1:2);
        return
    else
        % Otherwise for empty return Inf key
        key = [Inf, Inf];
    end
    
end

