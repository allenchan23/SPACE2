% AERO3760: Space Engineering 2
% Assignment 3: Traversability Analysis, Path Planning & Control of a
% a Simulated Mars Rover on Rough Terrain
% Kinematic & Dynamic Model of the Rover 'The Red Phantom', 
% which emulates the URANUS OMNIDIRECTIONAL WHEELED MOBILE ROBOT 

% Author: Caroline Hamilton Smith (SID: 450592230)

% FUNCTION: defines URANUS SPECIFICATIONS or do 

function [n, J, T_HC, T_RH, Zlim] = URANUS()

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
     
    % HOMOGENOUS TRANSFORMATION MATRICES (4 x 4)
    T_HC = eye(4,4);                                 % contact pt to hip
    for i = 1:n
        T_RH{i} = [1,0,0,la*ba(i);0,1,0,lb*bb(i);... % hip to reference
                   0,0,1,-lc; 0,0,0,1];
    end
    
    %% HEIGHT LIMIT
    %  the kinematic model of omni-directional wheels requires all wheels
    %  are in contact with the ground at all times, suspension provides
    %  compensation, however operating to a limit
    
    Zlim = D/4;  % allowable wheel displacement for compensatation 
    
end

