%% FUNCTION - Initializing nodes for A * Algorithm
% Given a set of inputs create a node data structure for the given cell
% i - Cell i position
% j - Cell j position
% x - x coordinate
% y - y coordinate
% z - z coordinate
% T - traverability (F - not traversable, T - traversable)
% closed - on closed list for A star algorithm
% visited - has been visited? (F - not visited, T - visited)
% h - heuristic value
% g - cost from start to current node
% f - total cost of current node
% Return: V - node data structure

% Author: Allen Chan

function V = makeNode_ASTAR(i,j,x,y,z,T,closed,f,h,g)   
    V.i = i;               % matrix x position
    V.j = j;               % matrix y position
    V.x = x;               % [m] x coordinate  
    V.y = y;               % [m] y coordinate
    V.z = z;               % [m] z coordinate
    V.trav = T;            % Boolean - is Traversable?
    V.closed = closed;     % Boolean - has been Visited
    V.visited = false;
    V.h = h;               % Double - cost to move from the starting point 
    V.g = g;               % Double -  the estimated movement cost to move from that given square on the grid to the final destination
    V.f = h + g;           % Double - sum of cost
    V.parent_i = -1;
    V.parent_j = -1;
end