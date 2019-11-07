%% FUNCTION - Check for next best position to trace back in D * Lite
% Given a node determine the cheapest cost successor
% [j i] - Current Matrix position
% Return [j_next i_next] -  matrix position of next best position to explor

% Author: Allen Chan

function [j_next i_next] = nextPos(j,i)

    global MAP;
    
    % Preset minium cost values
    minVal = Inf;
    val = 0;
    
    % Obtain current node information
    currentx = MAP{j,i}.x;
    currenty = MAP{j,i}.y;
    
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
        
        % Get potential node information
        thisNode = MAP{j-1,i};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
        
        % Calculate  Cost
        val = dist + thisNode.g;   
        
        % If min cost, set indexes
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end
    end
    
    %% ------------------------- S ---------------------------------
    if isValid(j+1,i)    
        
        % Get potential node information
        thisNode = MAP{j+1,i};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);

        % Calculate  Cost
        val = dist + thisNode.g; 
        
        % If min cost, set indexes
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end        
    end
    
    %% ------------------------- W ---------------------------------
    if isValid(j,i-1)     
        
        % Get potential node information
        thisNode = MAP{j,i-1};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);

        % Calculate  Cost
        val = dist + thisNode.g; 
        
        % If min cost, set indexes
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end
    end
    
    %% ------------------------- E ---------------------------------
    if isValid(j,i+1) 
        
        % Get potential node information
        thisNode = MAP{j,i+1};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);

        % Calculate  Cost
        val = dist + thisNode.g; 
        
        % If min cost, set indexes
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end   
    end

    %% ------------------------- SE ---------------------------------
    if isValid(j+1,i+1)  
        
        % Get potential node information
        thisNode = MAP{j+1,i+1};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);

        % Calculate  Cost
        val = dist + thisNode.g;   
        
        % If min cost, set indexes
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end
    end

    %% ------------------------- NE ---------------------------------
    if isValid(j-1,i+1)  
        
        % Get potential node information
        thisNode = MAP{j-1,i+1};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
 
        % Calculate  Cost
        val = dist + thisNode.g;  
        
        % If min cost, set indexes
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end
    end

    %% ------------------------- SW ---------------------------------
    if isValid(j-1,i-1) 
        
        % Get potential node information
        thisNode = MAP{j-1,i-1};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);

        % Calculate  Cost
        val = dist + thisNode.g;  
        
        % If min cost, set indexes
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end
    end

    %% ------------------------- NW ---------------------------------
    if isValid(j+1,i-1) 
        
        % Get potential node information
        thisNode = MAP{j+1,i-1};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
 
        % Calculate  Cost
        val = dist + thisNode.g;  
        
        % If min cost, set indexes
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end
    end

end