%% Function to Calculate Heuristics
function h = calculateH(V,D)    
    % return H value
    h = sqrt((D.x-V.x)^2+(D.y-V.y)^2);
    return;
end
