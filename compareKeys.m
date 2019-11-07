%% FUNCTION - Compare set of Keys
% Return a boolean to compare the value of two keys
% Return -1 | 0 | 1
%  K1 == K2 = 0
%  K1 > K1 = 1
%  K1 < K2 = -1

% Author: Allen Chan

function res = compareKeys(K1, K2)

    %  K1 > K2
    % Compare primary Key
    if (K1(1) < K2(1))
        res = -1;
        return;
        
     % Compare secondary Key
    elseif (K1(1) > K2(1))
        res = 1;
        return;
    end
   
    %  K1 < K2
    % Compare primary Key
   if (K1(2) < K2(2))
        res = -1;
        return;
     % Compare secondary Key
    elseif (K1(2) > K2(2))
        res = 1;
        return;
   end
    
   % Equivalennt case
   res = 0;
   return;
end