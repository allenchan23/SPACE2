clear;close all;clc;


%% set up
% read image file
yardBright = imread('pls.png');
% imagefile is 3d for some reason but its only greyscale so 2 dimensions 
% of the iamge are actually useless (only top one has data)
yardBright = yardBright(:,:,1);
% read colour image cause why not
yardCol = imread('marsYard.png');
% grab size
[imHeight, imWidth] = size(yardBright);
% dimensions of the mars yard and height of maximum obstacle
yardHeight = 6; % [m]
height=0.4; % [m]
yardWidth = 20; % [m]
% calculate width and height of each pixel in [m]
pixelWidth = yardWidth/imWidth;
pixelHeight = yardHeight/imHeight;
% convert image to elevation map but normalsising and then mulktiplying by
% the maximum height
yardElev = double(yardBright)/255*height;
% filter image lightly to smooth out this shithouse data
yardElev = imgaussfilt(yardElev,4);

% pitch and roll limits (in degrees)
rollLim = 30;
pitchLim = 30;

%% Terrain fitlering
% i made 2, both take same arguments are a broadly built the same way. Z is
% a matrix with only a binary 1 or 0 for traversability

% Z = getTerrainBinary1(height, yardWidth, yardHeight, yardBright, pitchLim, rollLim);
Z = getTerrainBinary2(height, yardWidth, yardHeight, yardBright,pitchLim,rollLim);

% have a look
close all
imshow(Z)

% convertarray to cell arrray cause we wanna put more stuff in it
ZCell = mat2cell(Z, ones(1,size(Z,1)), ones(1,size(Z,2)));


%% assigning XYZ coordiantes to each cell in the array
for row = 1:size(ZCell,1)
   for col = 1:size(ZCell,2)
       
        ZCell{row,col} = [ZCell{row,col} (col-1)*pixelWidth (row-1)*pixelHeight yardElev(row,col)]; 
       
   end
end



%% SLope
% for each point in the terrain, get the slope in degrees moving one 
% increment in each direction (ie. slope if moving north/east/south/west)
ZSlope = getTerrainSlope(ZCell);

% by end of this, each point in the cell array looks like this:
% Z{row,col} = [(Binary 0 or 1), X, Y, Z, Slope North, Slope East, Slope 
%                   South, Slope West]
















