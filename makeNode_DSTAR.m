%% Function for initializing nodes
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