clear;close all;clc;

% addpath('')



%% Rover specs
% WHEEL dimensions;
%  ~ i = 1: right front	 ~ i = 2: left front
%  ~ i = 3: left back    ~ i = 4: right back
n    = 4;                % number of wheels       (i)
D    = 0.2286;           % diameter               (m)
R    = D/2;              % radius                 (m)
lata = 0.450;            % length axle to axle    (m)
wata = 0.382;            % width axle to axle     (m)
c2w  = 0.034;            % width chassis to wheel (m)
ba   = [1, -1, -1, 1];   % x-wise position        (i)
bb   = [1, 1, -1, -1];   % y-wise position        (i)
% HOMOGENOUS dimensions
la = wata/2;    % reference to axle (X)
lb = la;        % reference to axle (Y)
lc = R*3;       % reference to axle (Z)
% WHEEL JACOBIAN (3 x 4)
J    = (R/4)*[-1, 1, -1, 1; 1, 1, 1, 1; ...
          1/(la + lb), -1/(la + lb), -1/(la + lb), 1/(la + lb)];   



%% set up waypoints
gridSpacing = 0.1;
% setup 2d array
x = -1:gridSpacing:5;
y = x';
% mesh for 3d
[X,Y] = meshgrid(x,y);
% add z points for testing
Z = (sin(4*Y))/8;
% Z = zeros(length(x), length(y));
% set some of the points to zero to check wheel velocities are changing
% correctly
Z(:,1:10)=0;

% plot surface
surfFlag = 0;
if surfFlag == 1
    figure(1)
    surf(X,Y,Z)
    axis equal
    hold on
end


wayPointsXY = [
    0,0;
%     1,2;
%     4,4;
%     3,0
    0,4;
];

% get X locations of the XY waypoint pairs
wayPointsXYZ = getWaypointsElevation(wayPointsXY, X, Y, Z);

% do geometry to get the headings for each path
headings = getWaypointsHeadings(wayPointsXY);



%% INITIAL
% set initial heading
headingPrevious = deg2rad(0);
% set initial waypoint/position
XYPrevious = wayPointsXY(1,:);
% roverVel = 0.5; % m/s constant velocity
% set initial velocities
xDotPrevious=0;
yDotPrevious=0;
% length of time of heading and position simulation
tLengthHeading=50;
tLengthPos = 50;
% start time of sim
tStart=0;
% end time of first sim
tEnd = tStart+tLengthHeading;
% timestep
tStep=0.01;


figure(1);
hold on


%% SIM
tic
for ind = 1:length(wayPointsXY)-1
    
    % grab desired heading
    headingCurrent = headings(ind);
    
    % run sim
    a = sim('headingAlignment');

    % i did something weird with the negatives so thats why thats there
    % (still works tho)
    headingPrevious=-headingCurrent;

    
    
    % update 'new' end time of next sim
    tStart=tEnd;
    tEnd=tEnd + tLengthPos;
    %store sim data
    sims(ind)=a;
   
    % grab desired waypoint in XY
    XYCurrent = wayPointsXY(ind+1,:);
    %calculate path length from current waypoint to next waypoint
    pathLength = sqrt((XYCurrent(1)-XYPrevious(1))^2 + (XYCurrent(2)-XYPrevious(2))^2);

    
    % run sim moving backwrads and forwards to waypoints
    a = sim('positionAlignment');
    pause
    %store
    simsPos(ind) = a;
    %update waypoint we just made it to as the previous one
    XYPrevious=XYCurrent;
      
    % update times
    tStart = tEnd;
    tEnd = tEnd + tLengthHeading;
end
toc


%% POST PROCESSING
% for ind = 1:length(simsPos)
%     heading = deg2rad(headings(ind));
%     sim = simsPos(ind);
%     XY = [sim.xPos.Data';
%         sim.yPos.Data'];
%     dcm = [cos(heading) -sin(heading);
%         sin(heading) cos(heading)];
%     XYPrime = dcm*XY;
% 
%     XYPrime = XYPrime + [wayPointsXY(ind,1);wayPointsXY(ind,2)];
%     sim.xPos.Data(:) = XYPrime(1,:);
%     sim.yPos.Data(:) = XYPrime(2,:);
%     simRot(ind) = sim;
% end





%% ANIMATION
close all
animateFlag = 1;

if animateFlag == 1
    figure(4)
    axis([-1 5 -1 5 -0.5 0.5])
    axis equal
    hold on
    surf(X,Y,Z)
    plot3(wayPointsXYZ(:,1), wayPointsXYZ(:,2), wayPointsXYZ(:,3), 'rx', 'Linewidth', 3)
    view(45,45)
    for simInd = 1:length(wayPointsXY)
        a = sims(simInd);
        
        for ind= 1:100:length(a.thetaPos.data)
            title(a.thetaPos.time(ind))

            heading = -deg2rad(a.thetaPos.data(ind));

            pMaster = drawRover(wayPointsXY(simInd,1),wayPointsXY(simInd,2),...
                0, 0, 0, heading, 1);
            pause(0.2)
            delete(pMaster)
        end
        
        posSim = simsPos(simInd);
        XY = [posSim.xPos.Data';
                posSim.yPos.Data'];
        dcm = [cos(-heading) -sin(-heading);
                sin(-heading) cos(-heading)];
        XYPrime = dcm*XY;
        XYPrime = XYPrime + [wayPointsXY(simInd,1);wayPointsXY(simInd,2)];

        for ind = 1:100:length(XYPrime)
            
            title(posSim.xPos.time(ind))
            
            pMaster = drawRover(XYPrime(1,ind), XYPrime(2,ind),...
                0, 0, 0, heading, 1);
            pause(0.2)
            delete(pMaster)                      
        end

    end
end










