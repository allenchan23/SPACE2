function updateVertex(V,Orig,Dest,k)
    
    global QUEUE;
    global MAP;
    
    i = V.i;
    j = V.j;
    iDest = Dest.i;
    jDest = Dest.j;
    
    if ~isDestination(i,j,iDest,jDest)
        if MAP{j,i}.trav
            MAP{j,i}.rhs = minSuccessor(V);
        end
    end
    
    if ~isempty(QUEUE)
        for n = 1:length(QUEUE(:,1))
            
            if n > length(QUEUE(:,1))
                break;
            end
            
            if j == QUEUE(n,3) && i == QUEUE(n,4)
                QUEUE(n,:) = [];
            end
        end
    end
    
    if MAP{j,i}.rhs ~= MAP{j,i}.g
        newEntry =[calculateKey(MAP{j,i},Orig,k),j,i];
        QUEUE = [newEntry;QUEUE];
    end
end