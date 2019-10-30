function [Z] = getTerrainSlope(Z)


[rows,cols] = size(Z);

for row = 2:rows-1
    
   for col = 2:cols-1
       
       % basic trig (change in elevation/change in distance)
       slopeNorth = Z{row,col}(4)-Z{row+1,col}(4);
       d = Z{row,col}(3)-Z{row+1,col}(3);
       slopeNorth = atand(slopeNorth/d);
       
       slopeEast = Z{row,col}(4)-Z{row,col+1}(4);
       d = Z{row,col}(2)-Z{row,col+1}(2);
       slopeEast= atand(slopeEast/d);

       slopeWest = Z{row,col}(4)-Z{row,col-1}(4);
       d = Z{row,col}(2)-Z{row,col-1}(2);
       slopeWest= atand(slopeWest/d);
       
       slopeSouth = Z{row,col}(4)-Z{row-1,col}(4);
       d = Z{row,col}(3)-Z{row-1,col}(3);
       slopeSouth= atand(slopeSouth/d);
       
       
       Z{row,col} = [Z{row,col} slopeNorth slopeEast slopeSouth slopeWest];
   end
end






