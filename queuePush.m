%% FUNCTION - Push Queue
% Adds a new entry into the queue
% Entry: new entry [K1 K1 i j]

function queuePush(entry)
    
    % add Entry into queue
    global QUEUE;
    QUEUE = [entry; QUEUE]
    
end