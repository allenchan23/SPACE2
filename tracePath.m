function path = tracePath(Map,Orig,Dest)
    
    i = Dest.i;
    j = Dest.j;
    
    stack = [];
    path = [];
    
    while (Map{j,i}.parent_i ~= 0) && (Map{j,i}.parent_j ~= 0)
        
        entry = [j,i];
        coordinate = [Map{j,i}.y, Map{j,i}.x];
        
        stack = [stack;entry];
        path = [coordinate;path];
        
        parent_i = Map{j,i}.parent_i;
        parent_j = Map{j,i}.parent_j;
        
        i = parent_i;
        j = parent_j;
    end
    
    o = [Orig.y,Orig.x];
    d = [Dest.y,Dest.x];
    
    path = [o;path;d];
    
end