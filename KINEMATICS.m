% AERO3760: Space Engineering 2
% Assignment 3: Traversability Analysis, Path Planning & Control of a
% a Simulated Mars Rover on Rough Terrain
% Kinematic & Dynamic Model of the Rover 'The Red Phantom', 
% which emulates the URANUS OMNIDIRECTIONAL WHEELED MOBILE ROBOT 

% Author: Caroline Hamilton Smith (SID: 450592230)

% Dimensions:
%  - metres (m) 
%  - radians (rad)

clear; clc; close all;

% WORLD coordinate: ORIGIN (X,Y,Z) = (0,0,0) is LHS BOTTOM CORNER 
% X-AXIS is RIGHT ~ Y-AXIS is FORWARD ~ Z-AXIS is UP

%% INITIALISATION

% URANUS SPECIFICATIONS:
% ~ n    = number of wheels (i)
% ~ J    = wheel jacobian matrix (3 x 4)
% ~ T_HC = homogenous transformation matrix (4 x 4) from contact pt to hip
% ~ T_RH = homogenous transformation matrix (4 x 4) from hip to reference
[n, J, T_HC, T_RH] = URANUS();
   
% INITIAL POSITION and ORIENTATION U0 = [X, Y, Z, roll, pitch, yaw];
X0    = 0;           Y0    = 0;           Z0    = 0;     
phiX0 = deg2rad(0);  phiY0 = deg2rad(0);  phiZ0 = deg2rad(0);

U(:,1)     = [X0; Y0; Z0; phiX0; phiY0; phiZ0]; % actual position
Udot(:,1)  = [0; 0; 0; 0; 0; 0];                % actual rates 
Uest(:,1)  = [X0; Y0; Z0; phiX0; phiY0; phiZ0]; % estimated position
OMEGA(:,1) = [0; 0; 0; 0];                      % wheel angular velocities
E(:,1)     = [0; 0; 0; 0; 0; 0; 0];             % position error

%% TIME 

time = 1:10;          % time vector
sim	 = time(end);	  % simulation time
res	 = length(time);  % number of time steps
dt   = sim/res;       % time step size
t(1) = dt;            % first time step

%% SIMULATION

for i = 2:res
    
    % time stamp (s)
    t(i) = i*dt;
    
    % CONTROL FUNCTION for WHEEL ANGULAR VELOCITIES (OMEGA)
    [OMEGA(:,i), Uest(:,i)] = CONTROL(U(:,i-1), Udot(:,i-1), E(:,i-1)); 

    % URANUS REFERENCE VELOCITY from WHEEL ANGULAR VELOCITIES 
    % exact solution using least-squares sensed forward solution, under 
    % the no-slip and adequate wheel sensing structure assumption
    Udot(:,i) = J*{OMEGA(:,i)};
    
    % PERFORM DEAD-REAKONING: to determine URANUS positon in real-time 
    % by integrating velocity (Udot) over the current sampling period.
    U(:,i)    = DEADREAKON(Udot(i-1), Udot(i), U(i-1), t(i), t(i-1));  
    
    % POSITION ERROR
    E(:,i)    = abs(U(:,i) - Uest(:,i));
   
end



