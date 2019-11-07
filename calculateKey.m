%% FUNCTION - Compute Key Value 
% Compute the cost value based on the cost the current node
% V - Current Node
% S - Start Node
% k - overhead cost

% Author - Allen Chan
function key = calculateKey(V,S,k)
    key = [min([V.g,V.rhs]) + calculateH(V,S) + k, min([V.g,V.rhs])];
end