
%Draws a fixation cross to external screen 
% Arm width
fixCrossDimPix = 16;
% Now we set the coordinates (these are all relative to zero we will let
% the drawing routine center the cross in the center of our monitor for us)
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];

% Set the line width for our fixation cross
lineWidthPix = 5;
crossColour = [255 255 255]; %white

% Draw the fixation cross in white, set it to the center of our screen and
% set good quality antialiasing
% Screen('DrawLines', win.Number, allCoords, lineWidthPix, [255 0 0], win.Center, 2);

baseRect = [0 0 25 25];
maxDiameter = max(baseRect);
centeredRect = CenterRectOnPointd(baseRect, win.Center(1), win.Center(2));
rectColor = [255 0 0];
Screen('FillOval', win.Number, rectColor, centeredRect, maxDiameter);