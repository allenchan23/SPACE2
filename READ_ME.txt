%%%%%%%%%%%%%%%%%%%% READ ME DOCUMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%

1) To operate code, please run MAIN.M

2) Choose your variables and Inputs
 - Select Origin [y, x]  ->  0 < y < 5 | 0 < x < 15 
 - Select Destination [y, x]  -> 0 < y < 5 | 0 < x < 15 
 - Select Heading deg -> 0 < deg < 2pi
 - Select destinationHeading deg -> 0 < deg < 2pi

3) Enable Path Planning Mode 
 - 'GLOBAL' - Global Path planning mode - runs A* search
	- use any map, runs relatively quick
 - 'LOCAL' - Adpative Path planning mode - runs D* search
        - use lowest quality map, runs very slow

4) To enable live plotting
  - A* -> go to aStarSearch.m
	- LIVEPLOT - set to true
  - D* -> go to DStartLiteSearch.m
	- LIVEPLOT - set to true

5) To test and experiment with algorithm, use either
	Astar\aStarSearchMain.m
	DstarLite\dStarSearchMain.m