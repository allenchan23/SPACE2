%% FUNCTION - Generate Path for Rover using A* algorithm
% Return set of waypoints for the path using A* seach algorithm
% XYZ_MAP - grid map containing z coordinatge
% G_MAP - goodness map of traverabilities 
% RES - resolution of grid space (distance between each grid cell)
% Orig - Origin Node
% Dest - Destiona Node
% Return: wayPoints - set of [y x] coordinates of path

% Author: Allen Chan

function wayPoints = generatePath_ASTAR(XYZ_MAP,G_MAP,RES,Orig,Dest)

    % Define Global Variables
    global CELLH;
    global CELLL;
    global maxY;
    global maxX;
    
    % Set Map Dimension
    CELLH = length(XYZ_MAP(:,1));               % table height
    CELLL = length(XYZ_MAP(1,:));               % table length
    maxY = length(XYZ_MAP(:,1))*RES;            % map height
    maxX = length(XYZ_MAP(1,:))*RES;            % map length
    
    % Initialize Map
    Map = {};
    
    % Set Map values
    for i = 1:CELLL
        for j = 1:CELLH
            x = i*RES;
            y = j*RES;
            z = XYZ_MAP(j,i);
            traversible = G_MAP(j,i);
            Map{j,i} = makeNode_ASTAR(i,j,x,maxY-y,z,traversible,false,0,Inf,Inf);
        end
    end

    %% Set Origin
    Orig_i = round(Orig(2)/RES);
    Orig_j = round((maxY-Orig(1))/RES);
    % Create Origin Node
    OrigNode = Map{Orig_j,Orig_i};

    %% Set Destination
    Dest_i = round(Dest(2)/RES);
    Dest_j = round((maxY-Dest(1))/RES);
    % Create Destination Node
    DestNode = Map{Dest_j,Dest_i};

    
    %% Begin Search
    % Obtain updated Map with path embedded
    newMap = aStarSearch(Map,OrigNode,DestNode);
    % Obtain set of waypoints from map
    wayPoints = tracePath(newMap,OrigNode,DestNode);
end