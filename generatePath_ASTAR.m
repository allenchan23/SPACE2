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
            Map{j,i} = makeNode(i,j,x,maxY-y,z,traversible,false,0,Inf,Inf);
        end
    end

    %% Set Origin
    Orig_i = round(Orig(2)/RES);
    Orig_j = round((maxY-Orig(1))/RES);
    OrigNode = Map{Orig_j,Orig_i};

    %% Set Destination
    Dest_i = round(Dest(2)/RES);
    Dest_j = round((maxY-Dest(1))/RES);
    DestNode = Map{Dest_j,Dest_i};

    
    %% Begin Search
    newMap = aStarSearch(Map,OrigNode,DestNode);
    wayPoints = tracePath(newMap,OrigNode,DestNode);
end