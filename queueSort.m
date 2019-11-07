%% FUNCTION - Sort Queue
% Sort a queue from lowerst to highest based on a key values

% Author: Allen Chan
function queueSort()
    
    % Sort queue based on the 1st then 2nd key
    global QUEUE;
    QUEUE = sortrows(QUEUE,[1 2]) ;
    
end