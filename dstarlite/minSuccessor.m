function minRhs = minSuccessor(V)
    
    global MAP;
    i = V.i;
    j = V.j;
    currentx = V.x;
    currenty = V.y;
    minRhs = Inf;
    
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
        
        if isValid(j-1,i)
            thisNode = MAP{j-1,i};
            if thisNode.trav
                thisx = thisNode.x;
                thisy = thisNode.y;
                dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
                minRhs = min([minRhs,MAP{j-1,i}.g+dist]); 
            end
        end
        
        if isValid(j+1,i)              
            thisNode = MAP{j+1,i};
            if thisNode.trav
                thisx = thisNode.x;
                thisy = thisNode.y;
                dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
                minRhs = min([minRhs,MAP{j+1,i}.g+dist]); 
            end           
        end
        
        if isValid(j,i-1)              
            thisNode = MAP{j,i-1};
            if thisNode.trav
                thisx = thisNode.x;
                thisy = thisNode.y;
                dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
                minRhs = min([minRhs,MAP{j,i-1}.g+dist]); 
            end          
        end
        
        if isValid(j,i+1)              
            thisNode = MAP{j,i+1};
            if thisNode.trav 
                thisx = thisNode.x;
                thisy = thisNode.y;
                dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
                minRhs = min([minRhs,MAP{j,i+1}.g+dist]); 
            end          
        end
        
        if isValid(j+1,i+1)              
            thisNode = MAP{j+1,i+1};
            if thisNode.trav 
                thisx = thisNode.x;
                thisy = thisNode.y;
                dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
                minRhs = min([minRhs,MAP{j+1,i+1}.g+dist]); 
            end          
        end
        
        if isValid(j-1,i+1)              
            thisNode = MAP{j-1,i+1};
            if thisNode.trav 
                thisx = thisNode.x;
                thisy = thisNode.y;
                dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
                minRhs = min([minRhs,MAP{j-1,i+1}.g+dist]); 
            end         
        end
        
        if isValid(j-1,i-1)              
            thisNode = MAP{j-1,i-1};
            if thisNode.trav
                thisx = thisNode.x;
                thisy = thisNode.y;
                dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
                minRhs = min([minRhs,MAP{j-1,i-1}.g+dist]); 
            end           
        end
        
        if isValid(j+1,i-1)              
            thisNode = MAP{j+1,i-1};
            if thisNode.trav
                thisx = thisNode.x;
                thisy = thisNode.y;
                dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
                minRhs = min([minRhs,MAP{j+1,i-1}.g+dist]); 
            end          
        end
     
end