%% Function to Calculate Heuristics
function h = calculateH(V1,V2)    
    % return H value
    h = sqrt((V1.x-V2.x)^2+(V1.y-V2.y)^2);
end
