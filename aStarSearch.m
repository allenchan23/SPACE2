% FUNCNTION: A* seach algorithm
function path = aStarSearch(Map,Orig,Dest)
    
    % TRUE - Live plot // FALSE - Live plot
    LIVE_PLOT = false;
    
    % Check if the destination is a valid coordiante
    if isValid(Dest.j,Dest.i) == false
        disp('Invalid Destination');
        return
    end
    
    % Check if the origin is a valid coordiante
    if isValid(Orig.j,Orig.i) == false
        disp('Invalid Origin');
        return
    end
    
    % Obtain the start cell positions
    i = Orig.i;
    j = Orig.j;
    
    % Obtain the destination cell positions
    iDest = Dest.i
    jDest = Dest.j
    
    % Initialize the cost of the starting Node
    Map{j,i}.f = 0;
    Map{j,i}.g = 0;
    Map{j,i}.h = 0;
    Map{j,i}.parent_i = 0;      % (0,0) - not existent parent
    Map{j,i}.parent_j = 0;
    
    % Initialize open-list to store f values for each coordinate
    openList = [];
    % Store the first node
    openList(1,1) = 0;       % f - total cost
    openList(1,2) = j;       % i - matrix y position
    openList(1,3) = i;       % j - matrix x position
    
    % Variable to determine if the destination has been found
    found = false;
    
    % Iterate until path has been found or all nodes have been exhuasted
    while ~isempty(openList)
        
        % Find the node of minimum cost and erase from list
        [minval,index] = min(openList(:,1));
        currentList = openList(index,:);
        openList(index,:) = [];
        
        % Obtain the matrix positions for the current node
        j = currentList(2);
        i = currentList(3);
        
        % Close the poisition
        Map{j,i}.closed = true;
        thisx = Map{j,i}.x;
        thisy = Map{j,i}.y;
        
        % Variables to store current cost of node
        gNew = 0;       % g - cost to move to current position
        hNew = 0;       % h - cost of current distance to destination
        fNew = 0;       % f - total cumulative cost
        
        % The code will explore all possible successors surrounding the
        % current node:
        %   NW  N  NE
        %     \ | /
        %   N - O - E
        %     / | \
        %   SW  S  NE
        %
        % [N] - (j-1,i)         [NE] - (j-1,i+1)
        % [E] - (j,i+1)         [NW] - (j-1,i-1)
        % [S] - (j+1,i)         [SE] - (j+1,i+1)
        % [W] - (j,i-1)         [SW] - (j+1,i-1)
        
        %% ------------------ 1st Successor (N) --------------------
        % Check if current node is valid
        if isValid(j-1,i)         
            currentNode = Map{j-1,i};
            currentx = currentNode.x;
            currenty = currentNode.y;
            
            % Check if the destination has been reached
            if isDestination(currentNode.i,currentNode.j,iDest,jDest)
                Map{j-1,i}.parent_i = i;
                Map{j-1,i}.parent_j = j;
                path = Map;
                
                % Plot the point
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % Return found
                disp('Path Found');
                found = true; 
                return; 
            
            % Otherwise calculate the cost of traversing to that point
            elseif isTraversable(currentNode) && (~currentNode.closed)
                dist = sqrt((thisx - currentx)^2 + (thisy - currenty)^2);
                gNew = Map{j,i}.g + dist;
                hNew = calculateH(currentNode,Dest);
                fNew = gNew + hNew;
                
                % Plot the point
                if ~currentNode.visited && LIVE_PLOT
                    figure(1)
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % If the current node has not been visited yet or the
                % cost is lower, append to open list
                if (currentNode.f == Inf || currentNode.f > fNew)
                    new = [fNew, j-1,i];
                    openList = [new; openList];
                    Map{j-1,i}.f = fNew;
                    Map{j-1,i}.g = gNew;
                    Map{j-1,i}.h = hNew;
                    Map{j-1,i}.parent_i = i;
                    Map{j-1,i}.parent_j = j;
                end
            end
        end
        
        %% ------------------ 2nd Successor (S) --------------------
        % Check if current node is valid
        if isValid(j+1,i)         
            currentNode = Map{j+1,i}; 
            currentx = currentNode.x;
            currenty = currentNode.y;
            
            % Check if the destination has been reached
            if isDestination(currentNode.i,currentNode.j,iDest,jDest)
                Map{j+1,i}.parent_i = i;
                Map{j+1,i}.parent_j = j;
                path = Map;
                
                % Otherwise calculate the cost of traversing to that point
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % Plot the point
                disp('Path Found');
                found = true; 
                return; 
            
            % Otherwise calculate the cost of traversing to that point
            elseif isTraversable(currentNode) && (~currentNode.closed)
                dist = sqrt((thisx - currentx)^2 + (thisy - currenty)^2);
                gNew = Map{j,i}.g + dist;
                hNew = calculateH(currentNode,Dest);
                fNew = gNew + hNew;
                
                % Plot the point
                if ~currentNode.visited && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % If the current node has not been visited yet or the
                % cost is lower, append to open list
                if (currentNode.f == Inf || currentNode.f > fNew)
                    new = [fNew, j-1,i];
                    openList = [new; openList];
                    Map{j+1,i}.f = fNew;
                    Map{j+1,i}.g = gNew;
                    Map{j+1,i}.h = hNew;
                    Map{j+1,i}.parent_i = i;
                    Map{j+1,i}.parent_j = j;
                end
            end
        end
        
        
        %% ------------------ 3rd Successor (E) --------------------
        % Check if current node is valid
        if isValid(j,i+1)         
            currentNode = Map{j,i+1};  
            currentx = currentNode.x;
            currenty = currentNode.y;
            
            % Check if the destination has been reached
            if isDestination(currentNode.i,currentNode.j,iDest,jDest)
                Map{j,i+1}.parent_i = i;
                Map{j,i+1}.parent_j = j;
                path = Map;
                
                % Plot the point
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % Return found
                disp('Path Found');
                found = true; 
                return; 
                
            % Otherwise calculate the cost of traversing to that point    
            elseif isTraversable(currentNode) && (currentNode.closed == false)
                dist = sqrt((thisx - currentx)^2 + (thisy - currenty)^2);
                gNew = Map{j,i}.g + dist;
                hNew = calculateH(currentNode,Dest);
                fNew = gNew + hNew;
                
                % Plot the point
                if ~currentNode.visited && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % If the current node has not been visited yet or the
                % cost is lower, append to open list
                if (currentNode.f == Inf || currentNode.f > fNew)
                    new = [fNew, j,i+1];
                    openList = [new; openList];
                    Map{j,i+1}.f = fNew;
                    Map{j,i+1}.g = gNew;
                    Map{j,i+1}.h = hNew;
                    Map{j,i+1}.parent_i = i;
                    Map{j,i+1}.parent_j = j;
                end
            end
        end
        
        %% ------------------ 4th Successor (W) --------------------
        % Check if current node is valid
        if isValid(j,i-1)         
            currentNode = Map{j,i-1};   
            currentx = currentNode.x;
            currenty = currentNode.y;
            
            % Check if the destination has been reached
            if isDestination(currentNode.i,currentNode.j,iDest,jDest)
                Map{j,i-1}.parent_i = i;
                Map{j,i-1}.parent_j = j;
                path = Map;
                
                % Plot the point
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % Return found
                disp('Path Found');
                found = true; 
                return; 
                
            % Otherwise calculate the cost of traversing to that point
            elseif isTraversable(currentNode) && (currentNode.closed == false)
                dist = sqrt((thisx - currentx)^2 + (thisy - currenty)^2);
                gNew = Map{j,i}.g + dist;
                hNew = calculateH(currentNode,Dest);
                fNew = gNew + hNew;
                
                % Plot the point
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % If the current node has not been visited yet or the
                % cost is lower, append to open list
                if (currentNode.f == Inf || currentNode.f > fNew)
                    new = [fNew, j,i+1];
                    openList = [new; openList];
                    Map{j,i-1}.f = fNew;
                    Map{j,i-1}.g = gNew;
                    Map{j,i-1}.h = hNew;
                    Map{j,i-1}.parent_i = i;
                    Map{j,i-1}.parent_j = j;
                end
            end
        end
        
        %% ------------------ 5th Successor (NE) --------------------
        % Check if current node is valid
        if isValid(j-1,i+1)         
            currentNode = Map{j-1,i+1};  
            currentx = currentNode.x;
            currenty = currentNode.y;
            
            % Check if the destination has been reached
            if isDestination(currentNode.i,currentNode.j,iDest,jDest)
                Map{j-1,i+1}.parent_i = i;
                Map{j-1,i+1}.parent_j = j;
                path = Map;
                 
                % Check if the destination has been reached
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % Return found
                disp('Path Found');
                found = true; 
                return; 
                
            % Otherwise calculate the cost of traversing to that point
            elseif isTraversable(currentNode) && (currentNode.closed == false)
                dist = sqrt((thisx - currentx)^2 + (thisy - currenty)^2);
                gNew = Map{j,i}.g + dist;
                hNew = calculateH(currentNode,Dest);
                fNew = gNew + hNew;
                
                % Plot the point
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % If the current node has not been visited yet or the
                % cost is lower, append to open list
                if (currentNode.f == Inf || currentNode.f > fNew)
                    new = [fNew, j-1,i+1];
                    openList = [new; openList];
                    Map{j-1,i+1}.f = fNew;
                    Map{j-1,i+1}.g = gNew;
                    Map{j-1,i+1}.h = hNew;
                    Map{j-1,i+1}.parent_i = i;
                    Map{j-1,i+1}.parent_j = j;
                end
            end
        end
        
        %% ------------------ 6th Successor (SE) --------------------
        % Check if current node is valid
        if isValid(j+1,i+1)         
            currentNode = Map{j+1,i+1};   
            currentx = currentNode.x;
            currenty = currentNode.y;
            
            % Check if the destination has been reached
            if isDestination(currentNode.i,currentNode.j,iDest,jDest)
                Map{j+1,i+1}.parent_i = i;
                Map{j+1,i+1}.parent_j = j;
                path = Map;
                
                % Plot the point
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % Return found
                disp('Path Found');
                found = true; 
                return; 
                
            % Otherwise calculate the cost of traversing to that point
            elseif isTraversable(currentNode) && (currentNode.closed == false)
                dist = sqrt((thisx - currentx)^2 + (thisy - currenty)^2);
                gNew = Map{j,i}.g + dist;
                hNew = calculateH(currentNode,Dest);
                fNew = gNew + hNew;
                
                % Plot the point
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % If the current node has not been visited yet or the
                % cost is lower, append to open list
                if (currentNode.f == Inf || currentNode.f > fNew)
                    new = [fNew, j+1,i+1];
                    openList = [new; openList];
                    Map{j+1,i+1}.f = fNew;
                    Map{j+1,i+1}.g = gNew;
                    Map{j+1,i+1}.h = hNew;
                    Map{j+1,i+1}.parent_i = i;
                    Map{j+1,i+1}.parent_j = j;
                end
            end
        end
        
        %% ------------------ 7th Successor (SW) --------------------
        % Check if current node is valid
        if isValid(j+1,i-1)         
            currentNode = Map{j+1,i-1};   
            currentx = currentNode.x;
            currenty = currentNode.y;
            
            % Check if the destination has been reached
            if isDestination(currentNode.i,currentNode.j,iDest,jDest)
                Map{j+1,i-1}.parent_i = i;
                Map{j+1,i-1}.parent_j = j;
                path = Map;
                
                % Plot the point
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % Return found
                disp('Path Found');  
                found = true; 
                return; 
            
            % Otherwise calculate the cost of traversing to that point
            elseif isTraversable(currentNode) && (currentNode.closed == false)
                dist = sqrt((thisx - currentx)^2 + (thisy - currenty)^2);
                gNew = Map{j,i}.g + dist;
                hNew = calculateH(currentNode,Dest);
                fNew = gNew + hNew;
                
                % Plot the point
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % If the current node has not been visited yet or the
                % cost is lower, append to open list
                if (currentNode.f == Inf || currentNode.f > fNew)
                    new = [fNew, j+1,i-1];
                    openList = [new; openList];
                    Map{j+1,i-1}.f = fNew;
                    Map{j+1,i-1}.g = gNew;
                    Map{j+1,i-1}.h = hNew;
                    Map{j+1,i-1}.parent_i = i;
                    Map{j+1,i-1}.parent_j = j;
                end
            end
        end
        
        %% ------------------ 8th Successor (NW) --------------------
        % Check if current node is valid
        if isValid(j-1,i-1)         
            currentNode = Map{j-1,i-1};  
            currentx = currentNode.x;
            currenty = currentNode.y;
            
            % Check if the destination has been reached
            if isDestination(currentNode.i,currentNode.j,iDest,jDest)
                Map{j-1,i-1}.parent_i = i;
                Map{j-1,i-1}.parent_j = j;
                path = Map;
                
                % Plot the point
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % Return Found
                disp('Path Found');
                found = true; 
                return; 
                
            % Otherwise calculate the cost of traversing to that point
            elseif isTraversable(currentNode) && (currentNode.closed == false)
                dist = sqrt((thisx - currentx)^2 + (thisy - currenty)^2);
                gNew = Map{j,i}.g + dist;
                hNew = calculateH(currentNode,Dest);
                fNew = gNew + hNew;
                
                % Plot the point
                if ~currentNode.visited && currentNode.f > fNew && LIVE_PLOT
                    figure(1)
                    plot([thisx,currentNode.x],[thisy,currentNode.y],'-k');
                    plot(currentNode.x,currentNode.y,'ok')
                    currentNode.visited = true;
                    drawnow;
                end
                
                % If the current node has not been visited yet or the
                % cost is lower, append to open list
                if (currentNode.f == Inf || currentNode.f > fNew)
                    new = [fNew, j+1,i-1];
                    openList = [new; openList];
                    Map{j-1,i-1}.f = fNew;
                    Map{j-1,i-1}.g = gNew;
                    Map{j-1,i-1}.h = hNew;
                    Map{j-1,i-1}.parent_i = i;
                    Map{j-1,i-1}.parent_j = j;
                end
            end
        end
        
        global CELLL;
        global CELLH;
        x = [];
        y = [];
        z = []
        
        % Traverse through each node
        for i = 1:CELLL
            for j = 1:CELLH        
                currentNode = Map{j,i};
                if currentNode.parent_i > 0 && currentNode.parent_j > 0
                    % Obtain current node and cost
                    parentNode = Map{currentNode.parent_j,currentNode.parent_i};
                    x = [x,Map{j,i}.x];
                    y = [y,Map{j,i}.y];
                    c = [z,Map{j,i}.f];
                    plot([currentNode.x,parentNode.x],[currentNode.y,parentNode.y],'-k')
                end
            end
        end
        
        % Plot heat map of cost function costs at each explored node
        sz = 20;
        c = linspace(1,10,length(x));
        scatter(x,y,sz,c,'filled')
        plot(Orig.x,Orig.y,'ob','MarkerSize',20,'linewidth',3);
        plot(Dest.x,Dest.y,'xr','MarkerSize',20,'linewidth',3);
        drawnow;
        pause(0.0001);
    end 
    
    % return map
    path = Map
end