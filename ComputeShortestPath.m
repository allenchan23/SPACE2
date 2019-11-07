%% FUNCTION - Find the Shortest Path and compute Costs in map
% Given a Destination and Orign look for shortest path using D* algorithm
% Dest - Destination Node
% Orig - Original Node
% k - look ahead cost
% Return: void - Updates global map
% Author: Allen Chan

function ComputeShortestPath(Dest,Orig,k)    

    global MAP;
    global QUEUE;
    
    % Get index of origin
    Orig_i = Orig.i;
    Orig_j = Orig.j;
    
    % Continue until the queue is empty, or the origin is found
    while ((compareKeys(topKey(),calculateKey(Orig,Orig,k)) < 0) || (MAP{Orig_j,Orig_i}.rhs ~= MAP{Orig_j,Orig_i}.g))
        
        % Pop the top key from the the queu
        keyOld = topKey();
        vKey = queuePop();
        
        % If the queue is empty end
        if isempty(vKey)
            break;
        end
        
        % Get entry matrix indexes
        j = vKey(3);
        i = vKey(4);
        V = MAP{j,i};
        
        % If found break.
        if (Orig_j == j) && (Orig_i == i)
            break;
        end
       
        % If there is a key change, readd to the open list
        if (compareKeys(keyOld,calculateKey(V,Orig,k)) < 0)
            newEntry = [calculateKey(V,Orig,k),j,i];
            queueInsert(newEntry);
            queueSort();
        
        % If under consistent update, make consistent and update all
        % surrounding nodes
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
            
            %% ------------------------- N ---------------------------------
            if isValid(j-1,i)              
                thisNode = MAP{j-1,i};
                updateVertex(thisNode,Orig,Dest,k);
            end

            %% ------------------------- S ---------------------------------
            if isValid(j+1,i)              
                thisNode = MAP{j+1,i};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            %% ------------------------- E ---------------------------------
            if isValid(j,i-1)              
                thisNode = MAP{j,i-1};
                updateVertex(thisNode,Orig,Dest,k);         
            end

            %% ------------------------- W ---------------------------------
            if isValid(j,i+1)              
                thisNode = MAP{j,i+1};
                updateVertex(thisNode,Orig,Dest,k);          
            end
 
            %% ------------------------- SE ---------------------------------
            if isValid(j+1,i+1)
                thisNode = MAP{j+1,i+1};
                updateVertex(thisNode,Orig,Dest,k);        
            end

            %% ------------------------- SW ---------------------------------
            if isValid(j-1,i+1)              
                thisNode = MAP{j-1,i+1};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            %% ------------------------- NW ---------------------------------
            if isValid(j-1,i-1)              
                thisNode = MAP{j-1,i-1};
                updateVertex(thisNode,Orig,Dest,k);        
            end

            %% ------------------------- SE ---------------------------------
            if isValid(j+1,i-1)              
                thisNode = MAP{j+1,i-1};
                updateVertex(thisNode,Orig,Dest,k);          
            end
        
        % If over consistent update, set node cost to Inf and update all
        % surrounding nodes
        else
            MAP{j,i}.g = Inf;
            updateVertex(V,Orig,Dest,k);
            
            %% ------------------------- N ---------------------------------
            if isValid(j-1,i)              
                thisNode = MAP{j-1,i};
                updateVertex(thisNode,Orig,Dest,k);
            end

            %% ------------------------- E ---------------------------------
            if isValid(j+1,i)              
                thisNode = MAP{j+1,i};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            %% ------------------------- S ---------------------------------
            if isValid(j,i-1)              
                thisNode = MAP{j,i-1};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            %% ------------------------- W ---------------------------------
            if isValid(j,i+1)              
                thisNode = MAP{j,i+1};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            %% ------------------------- SE ---------------------------------
            if isValid(j+1,i+1)              
                thisNode = MAP{j+1,i+1};
                updateVertex(thisNode,Orig,Dest,k);        
            end

            %% ------------------------- NE ---------------------------------
            if isValid(j-1,i+1)              
                thisNode = MAP{j-1,i+1};
                updateVertex(thisNode,Orig,Dest,k);          
            end

            %% ------------------------- NW ---------------------------------
            if isValid(j-1,i-1)              
                thisNode = MAP{j-1,i-1};
                updateVertex(thisNode,Orig,Dest,k);        
            end

            %% ------------------------- SW ---------------------------------
            if isValid(j+1,i-1)              
                thisNode = MAP{j+1,i-1};
                updateVertex(thisNode,Orig,Dest,k);        
            end
        end        
    end
end