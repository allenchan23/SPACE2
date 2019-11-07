%% FUNCTION - Update Vertex
% Function used update vertex cost for D* Lite Algorithm
% V - Node to Evaluate
% Dest - Destination Node
% Orig - Origin Node
% Return: void (updates global MAP and QUEUE)

% Author: Allen Chan

function updateVertex(V,Orig,Dest,k)
    
    % Approve acces to queue and map
    global QUEUE;
    global MAP;
    
    % Get matrix index of current node
    i = V.i;
    j = V.j;
    
    % Get matrix index of Destination node
    iDest = Dest.i;
    jDest = Dest.j;
    
    % Check to see if detination is reached
    if ~isDestination(i,j,iDest,jDest)
        if MAP{j,i}.trav
            
            % If not update the RHS key with minimum cost destination
            MAP{j,i}.rhs = minSuccessor(V);
        end
    end
    
    % Check if the queue is empty
    if ~isempty(QUEUE)
        for n = 1:length(QUEUE(:,1))          
            if n > length(QUEUE(:,1))
                break;
            end
            % If not, remove the current entry from the queue
            if j == QUEUE(n,3) && i == QUEUE(n,4)
                QUEUE(n,:) = [];
            end
        end
    end
    
    % Calculate new key of current node and place back intro queu
    if MAP{j,i}.rhs ~= MAP{j,i}.g
        newEntry =[calculateKey(MAP{j,i},Orig,k),j,i];
        QUEUE = [newEntry;QUEUE];
        queueSort();
    end
end