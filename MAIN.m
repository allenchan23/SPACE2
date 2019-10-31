%%%%%%%%%%%%%%%%%%%%%%% MAIN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variables
% x-y coordinates for origin and destination
Origin = [];
Destination = [];


%% Read Map 
% Read and generate map
% [XYZ_MAP, G_MAP, RES] = getMAP()
%   - XYZ_MAP - XY Matrix storing Z coordinates for the map
%   - G_MAP - Binary Matrix storing Z coordinates for the map
%           - 1 traversable
%           - 0 not traverable
%   - RES - resolution between each cell

%% Generate Path
% - select algorithm :
%       - A*
%       - D* lite
% waypoints = algorithm(XYZ_MAP,G_MAP,RES)
% waypoints = [x,y] n * 2 x-y coordinates

%% Simulate
% TBD

%% Animation
% ""