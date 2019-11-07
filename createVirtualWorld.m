[n,w] = vrimport(which('Rover_1.stl'));
w.Rover_Transform.rotation = [1 0 0 -pi/2];
w.Rover_Transform.scale = [0.0028 0.0028 0.0028];
%w.Rover_Transform.translation = [-0.2 0.12 1];
w.Rover_Transform.translation = [1000 1000 1000];


% Read and generate map
yardBright = imread('pls.png');
yardBright = yardBright(:,:,1);
[imHeight, imWidth] = size(yardBright);
aspectRatio = imWidth/imHeight;
height=0.4; % [m]
yardWidth = 15; % [m]
yardHeight=yardWidth/aspectRatio;
Z = double(yardBright)/255*height;
demdata=Z;
[xdim, zdim] = size(demdata);
xspace = yardHeight/xdim; % scaling in meters for x dimension
zspace = yardWidth/zdim; % scaling in meters for z dimension
% reshape the data into a one-dimensional array
demdata=flip(demdata);
demdata = demdata(:);
%demdata=flip(demdata);

% create a handle to a node VRTerrain, the node that will contain the DEM data
Terrain_node = vrnode(w,'VRTerrain','Transform');
% create a child of VRTerrain - shape
newShape = vrnode(Terrain_node, 'children', 'Terrain_Shape', 'Shape');
% create appearance field for the shape
newAppear = vrnode(newShape, 'appearance', 'Terrain_Appearance', 'Appearance');
% create material field for the appearance
newMat = vrnode(newAppear, 'material', 'Terrain_Material','Material');
% assign properties for the material field
newMat.ambientIntensity = 0.25;
newMat.diffuseColor = [0.9 0.6 0.6];
newMat.shininess = 0.078125;
newMat.specularColor = [0.0955906 0.0955906 0.0955906];
% create geometry field for the shape
newEGrid = vrnode(newShape, 'geometry', 'DEM_EGrid','ElevationGrid');
% assign properties for the geometry field - use DEM data
newEGrid.creaseAngle = 3.14;
newEGrid.xDimension = xdim;
newEGrid.zDimension = zdim;
newEGrid.xSpacing = xspace;
newEGrid.zSpacing = zspace;
newEGrid.height = demdata;


%saving and stuff
save(w, 'vrterrain_marsyardrover.wrl');
close(w);
delete(w);