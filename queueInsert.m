%% FUNCTION - Insert Queue
% Function to insert into queue
% Entry - [K1 K1 i j] containing two keys and matrix indexes
% Return: Void - Updates global queue

% Author: Allen Chan
function queueInsert(entry)
    
    global QUEUE;
    
    % Sort queue
    QUEUE = [entry; QUEUE];
    queueSort();
    
end