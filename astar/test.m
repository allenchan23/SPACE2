%% Main
% Define Global Variables
global CELLH
global CELLL
global maxH
global maxL
global vals

% Set Map Dimension
CELLL = 100;           % map height
CELLH = 100;           % map length
maxH = 100;
maxL = 100;

% Initialize Map
Map = [];

% Set Map values
for xCell = 1:CELLL
    for yCell = 1:CELLH
        % Initialize Map
        z = rand()
        Map(xCell,yCell) = makeNode(xCell,yCell,xCell,yCell,z,false,Inf,Inf);
    end
end

% Initiaize Optimal Path Stack
Path = []
Path_length = 0;

% Send Origin and Destination Points
Orig = Map(5,5);
Dest = Map(81,87);

%% Function for initializing nodes
function V = makeNode(xCell,yCell,x,y,z,T,visited,f,h,g)   
    V.xCell = xCell;       % matrix x position
    V.yCell = yCell;       % matrix y position
    V.x = x;               % [m] x coordinate  
    V.y = y;               % [m] y coordinate
    V.z = z;               % [m] z coordinate
    V.T = T;               % Boolean - is Traversable?
    V.visited = visited;   % Boolean - has been Visited
    V.h = h;               % Double - cost to move from the starting point 
    V.g = g;               % Double -  the estimated movement cost to move from that given square on the grid to the final destination
    V.f = h + g;           % Double - sum of cost
    V.parent_i = -1;
    V.parent_j = -1;
end

%% Function for checking validity of a node
function bool = isValid(V)   
    global CELLH
    global CELLL  
    % Check if we are going to a valid cell
    if (V.xCell >= 0 && V.xCell <= CELLL) && (V.yCell >= 0 && V.yCell <= CELLH)
        return true;
    else
        return false;
    end
end

%% Function to check if a node is not blocked by an obstacle
function bool = isTraversable(V)    
    % Check if we are going to a valid cell
    if (V.T == true)
        return true;
    else
        return false;
    end
end

%% Function to check if we have reached the final destination
function bool = isDestiantion(V,D)    
    % Check if we are going to a valid cell
    if (V.xCell == D.xCell) && (V.yCell == D.yCell)
        return true;
    else
        return false;
    end
end

%% Function to Calculate Heuristics
function h = calculateH(V,D)    
    % return H value
    h = sqrt((D.x-V.x)^2+(D.y-V.y));
    return h;
end

%% Trace Path from Origin to Destination
function tracePath()
    
end

%% A * Optimal Path Finding Algorithm
function path = findPath(Map,Orig,Dest)
    
    % Check the validity of the input origin
    if isValid(Orig) && ~isValid(Dest)
        printf("Error: Destination Out of Bounds");
        return;
    end
    % Check the validity of the input dest
    if ~isValid(Orig) && isValid(Dest)
        printf("Error: Origin Out of Bounds")
    end
    % Check if Destination is at the Origin
    if isDestination(Orig)
        printf("Destination Found")
    end
    
    % Obtain the start Node positions
    xStart = Orig.xCell;
    yStart = Orig.yCell;
    
    % Create  stacl to store all seen nodes
    visitedlist = [Map(xStart,yStart)];
    % Boolean - Set false until found
    found = false;
    
    % initiate path
    path = []

    % Iterate through the visited list
    while (length(visitedlist) != 0)
        
        % Pop from the stack
        curretNode = visitedlist(end);
        visitedlist(end) = []
        
        % Obtain the current cell positions
        i = currentNode.xCell;
        j = currentNode.yCell;
        
        % Mark the curret position as seen
        Map(i,j).visited = true;
        
        % store the heuristica values fro successors
        gNew = 0;
        hNew = 0;
        fNew = 0;
        
        % Check all successors
        
        % --------------Check 1st successors -> North-------------------
        % Check if this cell is valid
        if isValid(Map(i-1,j))
           
            % Check if we have reached the destination
            if (isDestiantion(Map(i-1,j),dest)
                Map(i-1,j).parent_i = i;
                Map(i,j-1).parent_j = j;
                path = tracePath(Map,Dest);
                found = true;
                return path;
            end
        end
    end
    
    
end
