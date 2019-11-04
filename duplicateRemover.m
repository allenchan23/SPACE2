function wayPoints = duplicateRemover(wayPoints)

    ind=1;
    removeCount=0;
    while ind < length(wayPoints)-removeCount
        if (wayPoints(ind,1) == wayPoints(ind+1,1) && wayPoints(ind+1,1) == wayPoints(ind+2,1)) || (wayPoints(ind,2) == wayPoints(ind+1,2) && wayPoints(ind+1,2) == wayPoints(ind+2,2))
            wayPoints(ind+1,:) = [];
            removeCount=removeCount+1;
            ind=ind-1;
        end



        ind=ind+1;
    end

