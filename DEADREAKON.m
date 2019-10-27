% AERO3760: Space Engineering 2
% Assignment 3: Traversability Analysis, Path Planning & Control of a
% a Simulated Mars Rover on Rough Terrain
% Kinematic & Dynamic Model of the Rover 'The Red Phantom', 
% which emulates the URANUS OMNIDIRECTIONAL WHEELED MOBILE ROBOT 

% Author: Caroline Hamilton Smith (SID: 450592230)

% FUNCTION to perform DEAD REAKONING: real-time calculation of the WMR
% position in WORLD coordinates using INTEGRATION from the URANUS 
% velocity as calculated from the wheel sensor measurements. 

% INPUT: 
% ~ URANUS reference VELOCITY (Udot): previous (Udot0) & current (Udot) 
% ~ URANUS reference POSITION (U):    previous (U0)    & current (U)
% ~ TIME STAMP (t):                   previous (t0)    & current (t) 

% OUTPUT: URANUS reference POSITION (U)

% ASSUMPTIONS: 
%  1. uranus reference velocity (Udot) was computed using the exact 
%     forward sensed solution which uses LEAST-SQUARES. 
%  2. NO WHEEL SLIP
%  3. ADEQUATE SENSING CRITERION as a pre-requisite for implementing the
%     dead reckoning solution 

% METHOD: DEAD REAKONING of the ROBOT
% ~ determine positon in real-time by integrating velocity (Udot)
%   over each sampling period.
% ~ dead reakoning is erroneous, when wheel slip ocurs thus neglected.
% ~ integration begins from the initial sensed rest velocity Udot = 0

function U = DEADREAKON(Udot0, Udot, U0, t0, t)

    % MOTION MATRIX V (3x3): depends on robot position (U) in WORLD
    % coordinates w.r.t the ROBOT (reference) coordinate: 
    % ~ U0(6) is the heading angle at the previous time stamp
    V    = [cos(U0(6)), -sin(U0(6)), 0; sin(U0(6)), cos(U0(6)), 0; 0,0,1];

    % POSITION using DEAD REAKONING update caluclation
    U = U0 + ((t-t0)/2)*V*(Udot0 - Udot);
        
end