%% experiment
% code by Chunkai Qiu

params.nreps = 1; %how many repetitions of the experiment

params.startexp = datestr(now,'HH.MM');
params.trialdur = 60; %seconds
waitframes=1; % show new image at each waitframes refresh

simultaneousTargets=0; %1 for multiple targets, 0 for single

switch simultaneousTargets
    case 1
        Targtype= 'MultiTarget';
    case 0
        Targtype= 'SingleTarget';
end

savebasegroup = [outdir filesep Targtype];

if exist([savebasegroup]) ~= 7
    command = ['mkdir -p ' savebasegroup];
    system(command);
end
%% Create target shape
% starting target parameters:
angle = 3; % angle of wedge pieces 
% cir_size = (params.targetSize-100)/20 + 1;
cir_size = (params.targetSize-100)/20 + 1;
%%
TL_index = 1;
TR_index = 1;
BL_index = 1;
BR_index = 1;
params.eccx = 100; %starting eccentricity on x plane
params.eccy = 100; %starting eccentricity on y plane. Measured from origin to target centre.

%% Create wedge shapes.
baseRectwedge = [0 0 win.Center(2) win.Center(2)];

xcoordLoc1wedge = win.Center(1)+win.Center(2)/2;
xcoordLoc2wedge = win.Center(1)-win.Center(2)/2;
xcoordLoc3wedge = win.Center(1)+win.Center(2)/2;
xcoordLoc4wedge = win.Center(1)-win.Center(2)/2;

ycoordLoc1wedge = win.Center(2)-win.Center(2)/2;
ycoordLoc2wedge = win.Center(2)-win.Center(2)/2;
ycoordLoc3wedge = win.Center(2)+win.Center(2)/2;
ycoordLoc4wedge = win.Center(2)+win.Center(2)/2;

targetlocation1wedge = CenterRectOnPoint(baseRectwedge,xcoordLoc1wedge,ycoordLoc1wedge);
targetlocation2wedge = CenterRectOnPoint(baseRectwedge,xcoordLoc2wedge,ycoordLoc2wedge);
targetlocation3wedge = CenterRectOnPoint(baseRectwedge,xcoordLoc3wedge,ycoordLoc3wedge);
targetlocation4wedge = CenterRectOnPoint(baseRectwedge,xcoordLoc4wedge,ycoordLoc4wedge);

pream1counter=0;
pream2counter=0;
pream3counter=0;
pream4counter=0;