%% FUNCTION - Trace Path for A* Derivation
% Function used to trace path for A* path finding algorithm
% Map - New map with parents node updated for traceback
% Dest - Destination Node
% Orig - Original Node
% Return: Path [y x] - List of waypoint coordiantes from Orig to Dest

% Author: Allen Chan

function path = tracePath(Map,Orig,Dest)
    
    % Obtain matrix indicies
    i = Dest.i;
    j = Dest.j;
    
    % Initialize Stack and Path
    stack = [];         % Traces matrix positions
    path = [];          % Traces waypoint positions
    
    % Iterate until the parent is found
    while (Map{j,i}.parent_i ~= 0) && (Map{j,i}.parent_j ~= 0)
        
        % Obtain the index and coordinates
        entry = [j,i];
        coordinate = [Map{j,i}.y, Map{j,i}.x];
        
        % Add to list
        stack = [stack;entry];
        path = [coordinate;path];
        
        % Obtain parent indexes
        parent_i = Map{j,i}.parent_i;
        parent_j = Map{j,i}.parent_j;
        
        % Update Indicies
        i = parent_i;
        j = parent_j;
    end
    
    % add origin and destination and return path
    o = [Orig.y,Orig.x];
    d = [Dest.y,Dest.x];  
    path = [o;path;d];
    
end