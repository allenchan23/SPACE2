function Z = getTerrainBinary1(height, yardWidth, yardHeight, yardBright, pitchLim,rollLim)

% get size
[imHeight, imWidth] = size(yardBright);

% median filtering to try fix our shithouse data
smooth=1;
if smooth==1
    yardBright = medfilt2(yardBright,[5 5]);
end

% convert image file to height array by normalising and multiplying by
% height
yardElev = double(yardBright)/255*height;

% convert to surface
figure(2)
Y = (1:imHeight)/imHeight*yardHeight;
X = (1:imWidth)/imWidth*yardWidth;
[X,Y] = meshgrid(X,Y);
surf(X,Y,yardElev)
set(gca,'YDir','reverse')
colorbar


% have a looksie
figure(3)
imcontour(yardBright,20)

% initialise binary map
image=ones(imHeight, imWidth); 

tic
% variable grid size for the swath you wanna look at 
sizer = 10;
% iterate through who image, moving up by "sizer" each time
for row = 2*sizer:sizer:size(yardElev,1)-sizer
    for col = 2*sizer:sizer:size(yardElev,2)-sizer
        
        % grab the sizerXsizer swath we're analysing
        z = yardElev(row-sizer:row,col-sizer:col);
        % take the differences in height moving in the X and Y directions
        risesY = diff(z);
        risesX = diff(z');
        % divide by pixel width and height to get slope moving in X and Y
        % directions over the entire swath
        runX = yardWidth/imWidth;
        runY = yardHeight/imHeight;
        % grab the max angle going both directions
        maxDy = max(max(atand(risesY/runY)));
        maxDx = max(max(atand(risesX/runX)));

        
        % check if the max within that swath is above the roll or pitch
        % limit. set that swath of the binary image to zero if there are
        % any above the limit as an "exclusion zone" type thing
        if maxDy > pitchLim || maxDx > rollLim
            image(row-sizer:row,col-sizer:col)=0;
        end
    end
end
toc
% fuse iamges with brightness one to vibe how shit it is
C = imfuse(image,yardBright, 'blend');
imshow(C)

Z = image;