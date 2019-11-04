function ComputeShortestPath(Dest,Orig,k)    

    global MAP;
    global QUEUE;
    
    Orig_i = Orig.i;
    Orig_j = Orig.j;
    
    while ((compareKeys(topKey(),calculateKey(Orig,Orig,k)) < 0) || (MAP{Orig_j,Orig_i}.rhs ~= MAP{Orig_j,Orig_i}.g))
        
        keyOld = topKey();
        vKey = queuePop();
        if isempty(vKey)
            break;
        end
        
        j = vKey(3)
        i = vKey(4)
        V = MAP{j,i};
        
        if (Orig_j == j) && (Orig_i == i)
            break;
        end
        
        if (compareKeys(keyOld,calculateKey(V,Orig,k)) < 0)
            newEntry = [calculateKey(V,Orig,k),j,i];
            queueInsert(newEntry);
            queueSort();
            
        elseif MAP{j,i}.g > MAP{j,i}.rhs
            
            MAP{j,i}.g = MAP{j,i}.rhs;
            
            % The code will explore all possible successors surrounding the
            % current node:
            %   NW  N  NE
            %     \ | /
            %   W - O - E
            %     / | \
            %   SW  S  NE
            %
            % [N] - (j-1,i)         [NE] - (j-1,i+1)
            % [E] - (j,i+1)         [NW] - (j-1,i-1)
            % [S] - (j+1,i)         [SE] - (j+1,i+1)
            % [W] - (j,i-1)         [SW] - (j+1,i-1)
            
            if isValid(j-1,i)              
                thisNode = MAP{j-1,i};
                updateVertex(thisNode,Orig,Dest,k);
            end

            if isValid(j+1,i)              
                thisNode = MAP{j+1,i};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            if isValid(j,i-1)              
                thisNode = MAP{j,i-1};
                updateVertex(thisNode,Orig,Dest,k);         
            end

            if isValid(j,i+1)              
                thisNode = MAP{j,i+1};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            if isValid(j+1,i+1)              
                thisNode = MAP{j+1,i+1};
                updateVertex(thisNode,Orig,Dest,k);        
            end

            if isValid(j-1,i+1)              
                thisNode = MAP{j-1,i+1};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            if isValid(j-1,i-1)              
                thisNode = MAP{j-1,i-1};
                updateVertex(thisNode,Orig,Dest,k);        
            end

            if isValid(j+1,i-1)              
                thisNode = MAP{j+1,i-1};
                updateVertex(thisNode,Orig,Dest,k);          
            end
            
        else
            MAP{j,i}.g = Inf;
            updateVertex(V,Orig,Dest,k);
            
            if isValid(j-1,i)              
                thisNode = MAP{j-1,i};
                updateVertex(thisNode,Orig,Dest,k);
            end

            if isValid(j+1,i)              
                thisNode = MAP{j+1,i};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            if isValid(j,i-1)              
                thisNode = MAP{j,i-1};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            if isValid(j,i+1)              
                thisNode = MAP{j,i+1};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            if isValid(j+1,i+1)              
                thisNode = MAP{j+1,i+1};
                updateVertex(thisNode,Orig,Dest,k);        
            end

            if isValid(j-1,i+1)              
                thisNode = MAP{j-1,i+1};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            if isValid(j-1,i-1)              
                thisNode = MAP{j-1,i-1};
                updateVertex(thisNode,Orig,Dest,k);        
            end

            if isValid(j+1,i-1)              
                thisNode = MAP{j+1,i-1};
                updateVertex(thisNode,Orig,Dest,k);        
            end
        end    
        QUEUE      
    end
end