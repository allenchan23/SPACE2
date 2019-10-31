function headings = getWaypointsHeadings(wayPointsXY)


    headings = zeros(length(wayPointsXY)-1,1);
    for ind = 1:length(wayPointsXY)-1
    
        rise = wayPointsXY(ind+1,2) - wayPointsXY(ind,2);
        run = wayPointsXY(ind+1,1) - wayPointsXY(ind,1);

        headings(ind) = 90-atan2d(rise,run);    
    end
