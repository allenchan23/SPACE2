function [j_next i_next] = nextPos(j,i)

    global MAP;
    
    minVal = Inf;
    val = 0;
    
    currentx = MAP{j,i}.x;
    currenty = MAP{j,i}.y;
    
    if isValid(j-1,i)              
        thisNode = MAP{j-1,i};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
        
        val = dist + thisNode.g;   
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end
    end

    if isValid(j+1,i)              
        thisNode = MAP{j+1,i};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);

        val = dist + thisNode.g;      
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end        
    end

    if isValid(j,i-1)              
        thisNode = MAP{j,i-1};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);

        val = dist + thisNode.g;    
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end
    end

    if isValid(j,i+1)              
        thisNode = MAP{j,i+1};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);

        val = dist + thisNode.g;       
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end   
    end

    if isValid(j+1,i+1)              
        thisNode = MAP{j+1,i+1};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);

        val = dist + thisNode.g;       
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end
    end

    if isValid(j-1,i+1)              
        thisNode = MAP{j-1,i+1};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
 
        val = dist + thisNode.g;       
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end
    end

    if isValid(j-1,i-1)              
        thisNode = MAP{j-1,i-1};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);

        val = dist + thisNode.g;       
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end
    end

    if isValid(j+1,i-1)              
        thisNode = MAP{j+1,i-1};
        thisx = thisNode.x;
        thisy = thisNode.y;
        dist = sqrt((thisx-currentx)^2+(thisy-currenty)^2);
 
        val = dist + thisNode.g;     
        if val <= minVal && thisNode.trav
            minVal = val;
            i_next = thisNode.i;
            j_next = thisNode.j;
        end
    end

end