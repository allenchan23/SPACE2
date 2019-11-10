function path = tracePath(Map,Orig,Dest)
    
    i = Dest.i;
    j = Dest.j;
    
    stack = [];

    while (Map{j,i}.parent_i ~= 0) && (Map{j,i}.parent_j ~= 0)
        entry = [j,i];
        stack = [stack;entry];
        parent_i = Map{j,i}.parent_i;
        parent_j = Map{j,i}.parent_j;
        i = parent_i;
        j = parent_j;
    end
    
    o = [Orig.j,Orig.i];
    d = [Dest.j,Dest.i];
    path = [d;stack;o];
    
end