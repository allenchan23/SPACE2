function key = topKey()
    
    global QUEUE;
    
    if length(QUEUE(:,1)) > 0
        queueSort();
        key = QUEUE(1,1:2);
        return
    else
        key = [Inf, Inf];
    end
    
end

