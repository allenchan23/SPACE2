%% FUNCTION - For initializing nodes for D* Lite Algorithm
% Given a set of inputs create a node data structure for the given cell
% i - Cell i position
% j - Cell j position
% x - x coordinate
% y - y coordinate
% z - z coordinate
% T - traverability (F - not traversable, T - traversable)
% closed - on closed list for A star algorithm
% g - cost from start to current node
% rhs - rhs cost
% Return: V - node data structure

% Author: Allen Chan

function V = makeNode_DSTAR(i,j,x,y,z,T,g,rhs)   
    V.i = i;               % matrix x position
    V.j = j;               % matrix y position
    V.x = x;               % [m] x coordinate  
    V.y = y;               % [m] y coordinate
    V.z = z;               % [m] z coordinate
    V.trav = T;     % Boolean - is Traversable?
    V.visited = false;
    V.g = g;               % Double - cost to move from the starting point 
    V.rhs = rhs;           % Double -  the estimated movement cost to move from that given square on the grid to the final destination
end