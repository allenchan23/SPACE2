%%%%%%%%%%%%%%%%%%%%%%% MAIN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variables
% x-y coordinates for and YAW origin and destination 
Origin = [3,1];
Destination = [4,10];


%% Read Map 
% Read and generate map
pitchLim = 30;
rollLim = 30;
yardBright = imread('pls.png');
yardBright = yardBright(:,:,1);
[imHeight, imWidth] = size(yardBright);
aspectRatio = imWidth/imHeight;
height=0.4; % [m]
yardWidth = 15; % [m]
yardHeight=yardWidth/aspectRatio;
RES = yardHeight/imHeight;

yardElev = double(yardBright)/255*height;
XYZ_MAP = imgaussfilt(yardElev,4);
G_MAP = getTerrainBinary2(height, yardWidth, yardHeight, yardBright,pitchLim,rollLim);

%% Generate Path
% - select algorithm :
%       - A*
%       - D* lite
% waypoints = algorithm(XYZ_MAP,G_MAP,RES)
% waypoints = [x,y] n * 2 x-y coordinates
wayPoints = generatePath_ASTAR(XYZ_MAP,G_MAP,RES,Origin,Destination);

%% Simulate
% TBD

%% Animation
% ""