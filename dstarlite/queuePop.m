function entry = queuePop()
    
    global QUEUE;
    
    if length(QUEUE(:,1)) > 0
        entry = QUEUE(1,:);
        QUEUE(1,:) = [];
    else
        entry = [];
    end
    
end