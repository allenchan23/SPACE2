%% FUNCTION - Pop Queue
% Function to remove entry on the top of the queue
% Return Entry [K1 K1 i j] - contains the two keys and matrix coordinates

% Author: Allen Chan

function entry = queuePop()
    
    % Obtain access to queue
    global QUEUE;
    
    % If queue is occupied, remove top key
    if length(QUEUE(:,1)) > 0
        entry = QUEUE(1,:);
        QUEUE(1,:) = [];
    else
        % Other return empty array
        entry = [];
    end
    
end