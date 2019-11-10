clear;
clc;


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
        Map{j,i} = makeNode(i,j,i,maxY-j+1,z,true,false,0,Inf,Inf);
    end
end

%% Set Obstacles
figure(1)
hold on;
axis equal;
xlim([0,maxX])
ylim([0,30])

for i = 5:10
    for j = 21:28
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([5 5 10 10],[10 3 3 10])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 8:10
    for j = 13:16
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([8 8 10 10],[18 15 15 18])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 14:18
    for j = 13:16
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([14 14 18 18],[18 15 15 18])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 20:25
    for j = 17:24
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([20 20 25 25],[14 7 7 14])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 41:42
    for j = 1:10
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([41 41 42 42],[30 21 21 30])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 40:45
    for j = 16:18
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([41 41 42 42],[17 15 15 17])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 20:23
    for j = 23:25
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([20 20 23 23],[8 6 6 8])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);
 
for i = 28:33
    for j = 8:16
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([28 28 33 33],[23 15 15 23])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 41:44
    for j = 10:12
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([41 41 44 44],[21 19 19 21])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 30:33
    for j = 18:21
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([30 33 33 30],[10 10 13 13])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 35:38
    for j = 12:18
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([38 38 35 35],[19 13 13 19])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 12:18
    for j = 23:30
        currentNode = Map{j,i};
        Map{j,i} = makeObstacle(currentNode);
    end
end
pgon = polyshape([18 18 12 12],[0 7 7 0])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);
% 
% for i = 22:25
%     for j = 13:15
%         currentNode = Map{j,i};
%         Map{j,i} = makeObstacle(currentNode);
%     end
% end
% pgon = polyshape([22 22 25 25],[16 18 18 16])
% plot(pgon,'FaceColor',[0.4 0.4 0.4]);

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
            %plot([currentNode.x,parentNode.x],[currentNode.y,parentNode.y],'-k')
        end
    end
end
sz = 20;
c = linspace(1,10,length(x));
%scatter(x,y,sz,c,'filled')
grid on;
grid minor;
plot(Orig.x,Orig.y,'ob','MarkerSize',15,'linewidth',3);
plot(Dest.x,Dest.y,'xr','MarkerSize',15,'linewidth',3);
s5 = plot(path(:,2),30-path(:,1)+1,'color',[0 0.4470 0.7410],'linewidth',3);