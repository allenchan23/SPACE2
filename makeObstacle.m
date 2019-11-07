%% FUNCTION:  for initializing Obstacles
% Change current node into an obstacle making it untraversable

%Author: Allen Chan

function V = makeObstacle(V)   
    V.trav = false;               % Boolean - is Traversable?
end