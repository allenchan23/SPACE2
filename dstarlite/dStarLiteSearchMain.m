
clear global;
clc;

%% Main
% Define Global Variables
global CELLH
global CELLL
global maxY
global maxX
global QUEUE
global MAP
global OBSTACLES;

% Set Map Dimension
CELLH = 30;           % table height
CELLL = 50;           % table length
maxY = 30;            % map height
maxX = 50;            % map length

% Initialize Map
MAP = {};
QUEUE = [];

% Set Map values
for i = 1:CELLL
    for j = 1:CELLH
        % Initialize Map
        z = rand();
        OBSTACLES(j,i) = 1;
        MAP{j,i} = makeNode_DSTAR(i,j,i,maxY-j+1,z,true,Inf,Inf);
    end
end

%% Set Obstacles
figure(1)
hold on;
axis equal;
xlim([0,maxX])
ylim([0,maxY])

% OBSTACLES(4,3) = 0;
% OBSTACLES(3,3) = 0;
% OBSTACLES(3,2) = 0;

% MAP{4,3} = makeObstacle(MAP{4,3});
% plot(MAP{4,3}.x,MAP{4,3}.y,'o');
% MAP{3,3} = makeObstacle(MAP{3,3});
% plot(MAP{3,3}.x,MAP{3,3}.y,'o');
% MAP{3,2} = makeObstacle(MAP{3,2});
% plot(MAP{4,2}.x,MAP{4,2}.y,'o');
for i = 5:10
    for j = 21:28
        currentNode = MAP{j,i};
        OBSTACLES(j,i) = 0;
    end
end
pgon = polyshape([5 5 10 10],[10 3 3 10])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 8:10
    for j = 13:16
        currentNode = MAP{j,i};
        OBSTACLES(j,i) = 0;
    end
end
pgon = polyshape([8 8 10 10],[18 15 15 18])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 14:18
    for j = 13:16
        currentNode = MAP{j,i};
        OBSTACLES(j,i) = 0;
    end
end
pgon = polyshape([14 14 18 18],[18 15 15 18])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 20:25
    for j = 17:24
        currentNode = MAP{j,i};
        OBSTACLES(j,i) = 0;
    end
end
pgon = polyshape([20 20 25 25],[14 7 7 14])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 41:42
    for j = 1:10
        currentNode = MAP{j,i};
        OBSTACLES(j,i) = 0;
    end
end
pgon = polyshape([41 41 42 42],[30 21 21 30])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 40:45
    for j = 16:18
        currentNode = MAP{j,i};
        OBSTACLES(j,i) = 0;
    end
end
pgon = polyshape([41 41 42 42],[17 15 15 17])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 20:23
    for j = 23:25
        currentNode = MAP{j,i};
        OBSTACLES(j,i) = 0;
    end
end
pgon = polyshape([20 20 23 23],[8 6 6 8])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);
 
for i = 28:33
    for j = 8:16
        currentNode = MAP{j,i};
        OBSTACLES(j,i) = 0;
    end
end
pgon = polyshape([28 28 33 33],[23 15 15 23])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 41:44
    for j = 10:12
        currentNode = MAP{j,i};
        OBSTACLES(j,i) = 0;
    end
end
pgon = polyshape([41 41 44 44],[21 19 19 21])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 30:33
    for j = 18:21
        currentNode = MAP{j,i};
        OBSTACLES(j,i) = 0;
    end
end
pgon = polyshape([30 33 33 30],[10 10 13 13])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 35:38
    for j = 12:18
        currentNode = MAP{j,i};
        OBSTACLES(j,i) = 0;
    end
end
pgon = polyshape([38 38 35 35],[19 13 13 19])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

for i = 12:18
    for j = 23:30
        currentNode = MAP{j,i};
        OBSTACLES(j,i) = 0;
    end
end
pgon = polyshape([18 18 12 12],[0 7 7 0])
plot(pgon,'FaceColor',[0.4 0.4 0.4]);

%% Set Origin
grid on;
grid minor;
MAP{10,47}.g = Inf;
MAP{10,47}.rhs = 0;
Dest = MAP{10,47};
s1 =plot(MAP{10,47}.x,MAP{10,47}.y,'xr','MarkerSize',15,'linewidth',3);
Orig = MAP{25,3};
s2 = plot(MAP{25,3}.x,MAP{25,3}.y,'ob','MarkerSize',15,'linewidth',3);
k = 1;

firstEntry = [calculateKey(Dest,Orig,k),10,47];
queueInsert(firstEntry);
% ComputeShortestPath(Dest,Orig,k)    
path = DStarLiteSearch(Dest,Orig,k)

waypoints = []
for n = 1:length(path(:,1))
    waypoint = [path(n,2), 30-path(n,1)+1];
    waypoints = [waypoint; waypoints] ;
end
s4 = plot(5,1,'color',[0 0.4470 0.7410],'linewidth',3)
s3 =plot(waypoints(:,1),waypoints(:,2),'color',[0.8500 0.3250 0.0980],'linewidth',3);
legend([s1 s2 s3 s4],'Start','End', 'D* Lite','A*')