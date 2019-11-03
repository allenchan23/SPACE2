clear;
clc;
clf;

%% Main
% Define Global Variables
global CELLH
global CELLL
global maxY
global maxX
global vals

% Set Map Dimension
CELLH = 30;           % table height
CELLL = 50;           % table length
maxY = 30;            % map height
maxX = 50;            % map length

% Initialize Map
Map = {};

% Set Map values
for i = 1:CELLL
    for j = 1:CELLH
        % Initialize Map
        z = rand();
        Map{j,i} = makeNode_ASTAR(i,j,i,maxY-j+1,z,true,false,0,Inf,Inf);
    end
end

%% Set Obstacles
figure(1)
hold on;
axis equal;
xlim([0,maxX])
ylim([0,maxY])

for i = 5:15
    for j = 18:25
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([5 5 15 15],[13 6 6 13])
plot(pgon);

for i = 20:23
    for j = 23:25
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([20 20 23 23],[8 6 6 8])
plot(pgon);

for i = 28:40
    for j = 8:14
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([28 28 40 40],[17 23 23 17])
plot(pgon);

for i = 40:44
    for j = 20:26
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([40 40 44 44],[11 5 5 11])
plot(pgon);

%% Set Origin
Orig = makeNode(3,25,3,5+1,0,true,false,0,Inf,Inf);

%% Set Destination
Dest = makeNode(47,10,47,20+1,0,true,false,0,Inf,Inf);

%% Begin Search
newMap = aStarSearch(Map,Orig,Dest);
path = tracePath(newMap,Orig,Dest);

x = []
y = []
c = []

% Set Map values
for i = 1:CELLL
    for j = 1:CELLH        
       %Initialize Map
        currentNode = newMap{j,i};
        if currentNode.parent_i > 0 && currentNode.parent_j > 0
            parentNode = newMap{currentNode.parent_j,currentNode.parent_i};
            x = [x,newMap{j,i}.x];
            y = [y,newMap{j,i}.y];
            c = [z,newMap{j,i}.f];
            plot([currentNode.x,parentNode.x],[currentNode.y,parentNode.y],'-k')
        end
    end
end
sz = 20;
c = linspace(1,10,length(x));
scatter(x,y,sz,c,'filled')
plot(Orig.x,Orig.y,'ob','MarkerSize',20,'linewidth',3);
plot(Dest.x,Dest.y,'xr','MarkerSize',20,'linewidth',3);
plot(path(:,2),30-path(:,1)+1,'r','linewidth',3);