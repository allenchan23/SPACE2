%% ---------------------------- MAIN -----------------------------------
clear;clc;close all;
%% Variables and Inputs
% x-y coordinates for and YAW origin and destination 
Origin = [3,0.1];
Destination = [2,10];
originHeading = deg2rad(0);
destinationHeading = deg2rad(0);


% Path finding Strategy - [GLOBAL] || [LOCAL]
% [GLOBAL] - Information provided of entire geographic location
% [LOCAL] - Information discovered locally
strat = 'GLOBAL';


%% Read Map 
% Read and generate map
pitchLim = 30;
rollLim = 30;
yardBright = imread('plsLower.PNG');
yardBright = yardBright(:,:,1);
[imHeight, imWidth] = size(yardBright);
aspectRatio = imWidth/imHeight;
height=0.4; % [m]
yardWidth = 15; % [m]
yardHeight=yardWidth/aspectRatio;
RES = yardHeight/imHeight;
x = linspace(0,yardWidth, imWidth);
y = linspace(0,yardHeight, imHeight);
[X,Y] = meshgrid(x,y);


yardElev = double(yardBright)/255*height;
XYZ_MAP = imgaussfilt(yardElev,4);
G_MAP = getTerrainBinary1(height, yardWidth, yardHeight, yardBright,pitchLim,rollLim);
wayPoints = [];
%% Generate Path
% Determine Path finding strategy
if strcmp(strat,'GLOBAL')
    % For Global seach, used A* Search
    wayPoints = generatePath_ASTAR(XYZ_MAP,G_MAP,RES,Origin,Destination);
elseif strcmp(strat,'LOCAL')
    % For Local seach, used D* Lite Search
    wayPoints = generatePath_DSTAR(XYZ_MAP,G_MAP,RES,Origin,Destination);disp(1);
else
    disp('Invalid Operation');
    return;
end
% If no waypoints generated, terminate
if (isempty(wayPoints))
    return;
end

% Plot waypoints
figure(10)
axis equal;
hold on;
ter = imread('realTerrain.PNG');
xlim([0 yardWidth])
ylim([0 yardHeight])
image([0 yardWidth],[yardHeight 0],ter);
plot(wayPoints(:,2),wayPoints(:,1),'o');


% make waypoints more concise
wayPoints = duplicateRemover(wayPoints);

%% Simulate
animateFlag=1;
simulation(wayPoints, X, Y, XYZ_MAP, RES, animateFlag, yardWidth, yardHeight, originHeading, destinationHeading)

%% Animation
% ""