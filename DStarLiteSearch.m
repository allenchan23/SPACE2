%% FUNCTION - Perform D* Lite Search
% Given a Destination and Orign look for shortest path using D* algorithm
% Dest - Destination Node
% Orig - Original Node
% k - look ahead cost
% Return: path [y x] - set of waypoints coordiantes

% Author: Allen Chan

function path = DStarLiteSearch(Dest,Orig,k)

    % Apporove access to global variables
    global CELLH;
    global CELLL;
    global maxY;
    global maxX;
    global QUEUE;
    global MAP;
    global OBSTACLES;
    
    % Set live simulation
    LIVEPLOT = false;
    
    % Call compute shortest path to calculate cost on global map
    ComputeShortestPath(Dest,Orig,k)  
    
    % Obtain Origin Node Information
    is = Orig.i;        % Successor i
    js = Orig.j;        % Successor j
    
    % Obtain Destination Node Information
    iDest = Dest.i;
    jDest = Dest.j;
    
    % Obtain previous indexes
    jp = js;          % Previous j
    ip = is;          % previous i
    path = [];
    
    % Iterate until the desintation is found
    while ~isDestination(is,js,iDest,jDest)
        
        % Find next position to trace towards
        [js, is] = nextPos(js,is); 
        jll = jp;
        ill = ip;
        
        % Update previous nodes
        jp = js;
        ip = is;
        
        % Track if a change in cost in the global map has occured
        change = false;
        
        % Add coordinates to the path
        coord = [MAP{js,is}.y, MAP{js,is}.x];
        path = [path;coord];
        
        % Initialize  live plot array
        current = [];
        ic = ip;
        jc = jp;
        current = [jc,ic];
        
        % Plot live if set
        if LIVEPLOT
            
            % Iterate until destination is reached
            while ~isDestination(ic,jc,iDest,jDest)
                
                % The code will explore all possible successors surrounding the
                % current node:
                %   NW  N  NE
                %     \ | /
                %   W - O - E
                %     / | \
                %   SW  S  NE
                %
                % [N] - (j-1,i)         [NE] - (j-1,i+1)
                % [E] - (j,i+1)         [NW] - (j-1,i-1)
                % [S] - (j+1,i)         [SE] - (j+1,i+1)
                % [W] - (j,i-1)         [SW] - (j+1,i-1)
                
                % Set min val
                minVal = inf;
                
                %% ------------------------- N ---------------------------------
                % Check for min value and add to plot array
                if isValid(jc-1,ic)
                    if MAP{jc-1,ic}.rhs < minVal
                        minVal = MAP{jc-1,ic}.rhs;
                        in = ic;
                        jn = jc-1;
                    end
                end

                %% ------------------------- S ---------------------------------
                % Check for min value and add to plot array
                if isValid(jc,ic-1)
                    if MAP{jc,ic-1}.rhs < minVal
                        minVal = MAP{jc,ic-1}.rhs;
                        in = ic-1;
                        jn = jc;
                    end
                end   

                %% ------------------------- W ---------------------------------
               % Check for min value and add to plot array
                if isValid(jc+1,ic)
                    if MAP{jc+1,ic}.rhs < minVal
                        minVal = MAP{jc+1,ic}.rhs;
                        in = ic;
                        jn = jc+1;
                    end
               end

                %% ------------------------- E ---------------------------------
               % Check for min value and add to plot array
                if isValid(jc,ic+1)
                    if MAP{jc,ic+1}.rhs < minVal
                        minVal = MAP{jc,ic+1}.rhs;
                        in = ic+1;
                        jn = jc;
                    end
                end  

                %% ------------------------- SE ---------------------------------
                % Check for min value and add to plot array
                if isValid(jc-1,ic+1)
                    if MAP{jc-1,ic+1}.rhs < minVal
                        minVal = MAP{jc-1,ic+1}.rhs;
                        in = ic+1;
                        jn = jc-1;
                    end
                end

                %% ------------------------- NE ---------------------------------
                % Check for min value and add to plot array
                if isValid(jc+1,ic-1)
                    if MAP{jc+1,ic-1}.rhs < minVal
                        minVal = MAP{jc+1,ic-1}.rhs;
                        in = ic-1;
                        jn = jc+1;
                    end
                end   

                %% ------------------------- SW ---------------------------------
               % Check for min value and add to plot array
                if isValid(jc+1,ic+1)
                    if MAP{jc+1,ic+1}.rhs < minVal
                        minVal = MAP{jc+1,ic+1}.rhs;
                        in = ic+1;
                        jn = jc+1;
                    end
               end

               %% ------------------------- NW ---------------------------------
              % Check for min value and add to plot array
               if isValid(jc-1,ic-1)
                    if MAP{jc-1,ic-1}.rhs < minVal
                        minVal = MAP{jc-1,ic-1}.rhs;
                        in = ic-1;
                        jn = jc-1;
                    end
                end 

                next = [jn, in];
                current = [current;next];
                ic = in;
                jc = jn;            
            end
            
            hold on;
            % Plot Predicted Path
            p1 = plot(current(:,2),30-current(:,1)+1,'--r','linewidth',2);
            % Plot live track
            p2 = plot(path(:,2),30-path(:,1)+1,'-b','linewidth',5);
            % Plot current position
            p3 = plot(is,30-js+1,'ok','MarkerSize',10);
            drawnow;
            delete(p1);
            delete(p3);
        end
        
        % The code will explore all possible successors surrounding the
                % current node:
                %   NW  N  NE
                %     \ | /
                %   W - O - E
                %     / | \
                %   SW  S  NE
                %
                % [N] - (j-1,i)         [NE] - (j-1,i+1)
                % [E] - (j,i+1)         [NW] - (j-1,i-1)
                % [S] - (j+1,i)         [SE] - (j+1,i+1)
                % [W] - (j,i-1)         [SW] - (j+1,i-1)
        %% ------------------------- N --------------------------------- 
        % Check if there is an obstacle at this position
        if isValid(js-1,is)
            if ~OBSTACLES(js-1,is)
                
                % If found, mark this obstacle
                change = true;
                MAP{js-1,is} = makeObstacle(MAP{js-1,is});
                MAP{js-1,is}.rhs = Inf;
                MAP{js-1,is}.g = Inf;
                
                % Add to plot
                if LIVEPLOT
                    plot(MAP{js-1,is}.x,MAP{js-1,is}.y,'ks','MarkerFaceColor','k');
                end
                
                % Update surrounding vertex costs
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end
        end
        
        %% ------------------------- S ---------------------------------
        % Check if there is an obstacle at this position
        if isValid(js+1,is)     
            
            % If found, mark this obstacle
            if ~OBSTACLES(js+1,is)
                change = true;
                MAP{js+1,is} = makeObstacle(MAP{js+1,is});
                MAP{js+1,is}.rhs = Inf;
                MAP{js+1,is}.g = Inf;
                
                % Add to plot
                if LIVEPLOT
                    plot(MAP{js+1,is}.x,MAP{js+1,is}.y,'ks','MarkerFaceColor','k');
                end
                
                % Update surrounding vertex costs
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end          
        end
        
        %% ------------------------- W ---------------------------------
        % Check if there is an obstacle at this position
        if isValid(js,is-1)   
            
            % If found, mark this obstacle
            if ~OBSTACLES(js,is-1)
                change = true;
                MAP{js,is-1} = makeObstacle(MAP{js,is-1});
                MAP{js,is-1}.rhs = Inf;
                MAP{js,is-1}.g = Inf;  
                
                % Add to plot
                if LIVEPLOT
                    plot(MAP{js,is-1}.x,MAP{js,is-1}.y,'ks','MarkerFaceColor','k');
                end
                
                % Update surrounding vertex costs
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end        
        end
        
        %% ------------------------- E ---------------------------------
        % Check if there is an obstacle at this position
        if isValid(js,is+1) 
            
            % If found, mark this obstacle
            if ~OBSTACLES(js,is+1)
                change = true;
                MAP{js,is+1} = makeObstacle(MAP{js,is+1});
                MAP{js,is+1}.rhs = Inf;
                MAP{js,is+1}.g = Inf; 
                
                % Add to plot
                if LIVEPLOT
                    plot(MAP{js,is+1}.x,MAP{js,is+1}.y,'ks','MarkerFaceColor','k');
                end 
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end          
        end
        
        %% ------------------------- SE ---------------------------------
        % Check if there is an obstacle at this position
        if isValid(js+1,is+1) 
            
            % If found, mark this obstacle
            if ~OBSTACLES(js+1,is+1)
                change = true;
                MAP{js+1,is+1} = makeObstacle(MAP{js+1,is+1});
                MAP{js+1,is+1}.rhs = Inf;
                MAP{js+1,is+1}.g = Inf;
                
                % Add to plot
                if LIVEPLOT
                    plot(MAP{js+1,is+1}.x,MAP{js+1,is+1}.y,'ks','MarkerFaceColor','k');
                end
                
                % Update surrounding vertex costs
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end         
        end
        
        %% ------------------------- NE ---------------------------------
        % Check if there is an obstacle at this position
        if isValid(js-1,is+1) 
            
            % If found, mark this obstacle
            if ~OBSTACLES(js-1,is+1)
                change = true;
                MAP{js-1,is+1} = makeObstacle(MAP{js-1,is+1});
                MAP{js-1,is+1}.rhs = Inf;
                MAP{js-1,is+1}.g = Inf;
                
                % Add to plot
                if LIVEPLOT
                    plot(MAP{js-1,is+1}.x,MAP{js-1,is+1}.y,'ks','MarkerFaceColor','k');
                end
                
                % Update surrounding vertex costs
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end        
        end
        
        %% ------------------------- NW ---------------------------------
        % Check if there is an obstacle at this position
        if isValid(js-1,is-1)    
            
            % If found, mark this obstacle
            if ~OBSTACLES(js-1,is-1)
                change = true;
                MAP{js-1,is-1} = makeObstacle(MAP{js-1,is-1});
                MAP{js-1,is-1}.rhs = Inf;
                MAP{js-1,is-1}.g = Inf; 
                
                % Add to plot
                if LIVEPLOT
                    plot(MAP{js-1,is-1}.x,MAP{js-1,is-1}.y,'ks','MarkerFaceColor','k');
                end
                
                % Update surrounding vertex costs
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end          
        end
        
        %% ------------------------- SW ---------------------------------
        % Check if there is an obstacle at this position
        if isValid(js+1,is-1)   
            
            % If found, mark this obstacle
            if ~OBSTACLES(js+1,is-1)
                change = true;
                MAP{js+1,is-1} = makeObstacle(MAP{js+1,is-1});
                MAP{js+1,is-1}.rhs = Inf;
                MAP{js+1,is-1}.g = Inf;
                
                % Add to plot
                if LIVEPLOT
                    plot(MAP{js+1,is-1}.x,MAP{js+1,is-1}.y,'ks','MarkerFaceColor','k');
                end
                
                % Update surrounding vertex costs
                updateVertex(MAP{js,is},MAP{js,is},Dest,k);
            end        
        end
        
        % If no change, continue
        if (~change)
            jp = jll;
            ip = ill;
        end
        
        % Compute new shortest path
        ComputeShortestPath(Dest,Orig,k);
    end
        
end