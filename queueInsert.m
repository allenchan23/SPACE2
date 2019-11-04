function queueInsert(entry)
    
    global QUEUE;
    QUEUE = [entry; QUEUE];
    queueSort();
    
end