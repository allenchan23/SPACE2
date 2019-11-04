%% FUNCTION - Generate Path for Rover
% Return set of waypoints for the path using A* seach algorithm
% XYZ_MAP - grid map containing z coordinatge
% G_MAP - goodness map of traverabilities 
% RES - resolution of grid space (distance between each grid cell)
% Orig - Origin Node
% Dest - Destiona Node
% Return: wayPoints - set of [y x] coordinates of path

% Author: Allen Chan

function wayPoints = generatePath_DSTAR(XYZ_MAP,G_MAP,RES,Orig,Dest)

    % Define Global Variables
    global CELLH;
    global CELLL;
    global maxY;
    global maxX;
    global QUEUE;
    global MAP;
    global OBSTACLES;
    
    % Set Map Dimension
    CELLH = length(XYZ_MAP(:,1));               % table height
    CELLL = length(XYZ_MAP(1,:));               % table length
    maxY = length(XYZ_MAP(:,1))*RES;            % map height
    maxX = length(XYZ_MAP(1,:))*RES;            % map length
    
    % Initialize Map
    MAP = {};
    % Initialize Queue
    QUEUE = [];
    
    % Set Map values
    for i = 1:CELLL
        for j = 1:CELLH
            x = i*RES;
            y = j*RES;
            z = XYZ_MAP(j,i);
            OBSTACLES(j,i) = G_MAP(j,i);
            MAP{j,i} = makeNode_DSTAR(i,j,x,maxY-y,z,true,Inf,Inf);
        end
    end

    %% Set Origin
    Orig_i = round(Orig(2)/RES);
    Orig_j = round((maxY-Orig(1))/RES);
    % Create Origin Node
    MAP{Orig_j,Orig_i}
    OrigNode = MAP{Orig_j,Orig_i};

    %% Set Destination
    Dest_i = round(Dest(2)/RES);
    Dest_j = round((maxY-Dest(1))/RES);
    % Create Destination Node
    MAP{Dest_j,Dest_i}.g = Inf;
    MAP{Dest_j,Dest_i}.rhs = 0;
    DestNode = MAP{Dest_j,Dest_i};

    %% Initialize Seach
    k = 1;   
    firstEntry = [calculateKey(DestNode,OrigNode,k),Dest_j,Dest_i];
    queueInsert(firstEntry);

    
    %% Begin Search
    wayPoints = DStarLiteSearch(DestNode,OrigNode,k);
end