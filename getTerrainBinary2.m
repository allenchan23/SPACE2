function Z = getTerrainBinary2(height, yardWidth, yardHeight, yardBright, pitchLim,rollLim)

%% this was the rounding to 20 heights one
[imHeight, imWidth] = size(yardBright);

temp = imgaussfilt(yardBright,4);
height=0.4;
yardElev = double(temp)/255*height;
figure(1)
axis equal
hold on
targets = linspace(0,height,20);
vRounded = interp1(targets,targets,yardElev,'nearest');
[C,H] = contourf(yardElev,20);
image = ones(imHeight,imWidth);
figure(2)
imshow(yardElev);
grid=20;
tic
for row = 2*grid:grid:imHeight-grid
    for col = 2*grid:grid:imWidth-grid

        z = vRounded(row-grid:row,col-grid:col);
        risesY = diff(z);
        risesX = diff(z');
        runX = yardWidth/imWidth;
        runY = yardHeight/imHeight;
        maxDy = max(max(atand(risesY/runY)));
        maxDx = max(max(atand(risesX/runX)));


        if abs(maxDx) > (pitchLim) || abs(maxDy) > (rollLim)
           image(row-grid:row,col-grid:col) = 0;
        end
        
    end
end
toc
image(:,1:grid,1) = 0;
image(:,end-grid:end,1) = 0;
image(1:grid,: ,1) = 0;
image(end-grid:end,: ,1) = 0;
figure(2)

% image=~bwareaopen(image,1000);
% image=imfill(image,'holes');
D = imfuse(image,yardBright, 'blend');
imshow(D)

Z=image;
