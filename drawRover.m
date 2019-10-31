function pMaster = drawRover(x,y,z, roll, pitch, yaw, flag)

    length = 0.450;
    width = 0.382;
    D    = 0.2286;           % diameter            (m)
    R    = D/2;              % radius              (m)
    height = R;

    dcm = angle2dcm(-yaw, roll, pitch);

    
    
    xVec = [-width/2 +width/2 +width/2 -width/2 -width/2];
    yVec = [-length/2 -length/2 +length/2 +length/2 -length/2];
    zVec = [0 0 0 0 0] + height;
    xyzVec = [xVec', yVec', zVec']*dcm;
    xyzVec = [xyzVec(:,1)+x xyzVec(:,2)+y xyzVec(:,3)+z];

    
    p1 = patch(xyzVec(:,1),xyzVec(:,2),xyzVec(:,3), 'b');
    
    
    theta = 0:0.1:2*pi;
    zPoints = R*sin(theta)+R+z;

    y1Points = R*cos(theta)+length/2+y;
    x1Points = zeros(size(y1Points))+width/2+x;
    xyzWheel1 = [x1Points'-x, y1Points'-y, zPoints'-z]*dcm;
    xyzWheel1 = [xyzWheel1(:,1)+x, xyzWheel1(:,2)+y, xyzWheel1(:,3)+z];
    
    y2Points = R*cos(theta)-length/2+y;
    x2Points = zeros(size(y2Points))+width/2+x;
    xyzWheel2 = [x2Points'-x, y2Points'-y, zPoints'-z]*dcm;
    xyzWheel2 = [xyzWheel2(:,1)+x, xyzWheel2(:,2)+y, xyzWheel2(:,3)+z];

    

    y3Points = R*cos(theta)-length/2+y;
    x3Points = zeros(size(y3Points))-width/2+x;
    xyzWheel3 = [x3Points'-x, y3Points'-y, zPoints'-z]*dcm;
    xyzWheel3 = [xyzWheel3(:,1)+x, xyzWheel3(:,2)+y, xyzWheel3(:,3)+z];

    
    
    y4Points = R*cos(theta)+length/2+y;
    x4Points = zeros(size(y4Points))-width/2+x;
    xyzWheel4 = [x4Points'-x, y4Points'-y, zPoints'-z]*dcm;
    xyzWheel4 = [xyzWheel4(:,1)+x, xyzWheel4(:,2)+y, xyzWheel4(:,3)+z];
    
    p2 = patch(xyzWheel1(:,1), xyzWheel1(:,2), xyzWheel1(:,3), 'b');
    p3 = patch(xyzWheel2(:,1), xyzWheel2(:,2), xyzWheel2(:,3), 'b');
    p4 = patch(xyzWheel3(:,1), xyzWheel3(:,2), xyzWheel3(:,3), 'b');
    p5 = patch(xyzWheel4(:,1), xyzWheel4(:,2), xyzWheel4(:,3), 'b');
    
    
    pMaster = [p1;p2;p3;p4;p5];
    
    
%     
%     if flag==True
%         
%         line([x,],[y y+yaw], 'r-', 'Linewidth', 2)
%         
%     end
%     
    
    
    
    
    
    
    
    
    
    
    
    
