function path = ComputeShortestPath(Map,queue,Dest,Orig)
    
    TK = topKey(queue)
    OK = CalculateKey(V,Orig,k)
    
    while (TK(1) < OK(1) || Orig.rhs ~= Orig.g)
        
        keyOld = topKey(queue);
        [minval,index] = min(queue(:,1));
        
        v = queue(n,:);
        j = v(3);
        i = v(4); 
        V = Map{j,i};        
        queue(n,:) = [];
        
        if (keyOld(1) < calculateKey(V,Orig,k))
            newEntry = [calculateKey,j,i];
            queue = [newEntry;queue]
            
        elseif V.g > V.rhs
            
            Map{j,i}.g = Map{j,i}.rhs
            [Map queue] = updateVertex(Map{j-1,i});
            [Map queue] = updateVertex(Map{j+1,i});
            [Map queue] = updateVertex(Map{j,i-1});
            [Map queue] = updateVertex(Map{j,i+1});
            [Map queue] = updateVertex(Map{j-1,i-1});
            [Map queue] = updateVertex(Map{j-1,i+1});
            [Map queue] = updateVertex(Map{j+1,i-1});
            [Map queue] = updateVertex(Map{j+1,i+1});
        end
        
        
    end
end