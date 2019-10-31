function wayPointsXYZ = getWaypointsElevation(wayPointsXY, X, Y, surface)


    wayPointsXYZ = zeros(length(wayPointsXY), 3);
    for ind = 1:length(wayPointsXY)
    
        xxx = wayPointsXY(ind,1);
        yyy = wayPointsXY(ind,2);
        zzz = interp2( X, Y, surface, xxx, yyy) ;

        wayPointsXYZ(ind,:) = [wayPointsXY(ind,:) zzz];
    end