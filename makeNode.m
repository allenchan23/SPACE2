%% Function for initializing nodes
function V = makeNode(i,j,x,y,z,T,closed,f,h,g)   
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