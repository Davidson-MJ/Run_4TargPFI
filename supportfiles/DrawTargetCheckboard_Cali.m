
% We will scale our texure up to 90 times its current size be defining a
% larger screen destination rectangle
if (~exist('pream1counter'))||(~exist('pream2counter'))||(~exist('pream3counter'))||(~exist('pream4counter'))
    pream1counter=0;
    pream2counter=0;
    pream3counter=0;
    pream4counter=0;
end

waitframe = params.waitframes;

%assign frequencies to targets:

F_TL = waitframe(TL_index);
F_TR = waitframe(TR_index);
F_BL = waitframe(BL_index);
F_BR = waitframe(BR_index);

% Top left

if (mod(frame,F_TL)==0)||(frame==1)
    am1counter=randi([1 99],1,1);
    if (am1counter == pream1counter)
        am1counter = am1counter+1;
    end
    pream1counter = am1counter;
end

% Top right

if (mod(frame,F_TR)==0)||(frame==1)
    am2counter=randi([1 99],1,1);
    if (am2counter == pream2counter)
        am2counter = am2counter+1;
    end
    pream2counter = am2counter;
end

% Bottom left

if (mod(frame,F_BL)==0)||(frame==1)
    am3counter=randi([1 99],1,1);
    if (am3counter == pream3counter)
        am3counter = am3counter+1;
    end
    pream3counter = am3counter;
end

% Bottom right

if (mod(frame,F_BR)==0)||(frame==1)
    am4counter=randi([1 99],1,1);
    if (am4counter == pream4counter)
        am4counter = am4counter+1;
    end
    pream4counter = am4counter;
end




%%%%%%%%%%%%%%%%%%%%%%%%%
rect = [0 0 (cir_size-1)*20+100 (cir_size-1)*20+100];

Xloc1=-1;
Xloc2=1;
Xloc3=-1;
Xloc4=1;

Yloc1=-1;
Yloc2=-1;
Yloc3=1;
Yloc4=1;


xcoordLoc1 = win.Center(1)+Xloc1*params.eccx;
xcoordLoc2 = win.Center(1)+Xloc2*params.eccx;
xcoordLoc3 = win.Center(1)+Xloc3*params.eccx;
xcoordLoc4 = win.Center(1)+Xloc4*params.eccx;

ycoordLoc1 = win.Center(2)+Yloc1*params.eccy;
ycoordLoc2 = win.Center(2)+Yloc2*params.eccy;
ycoordLoc3 = win.Center(2)+Yloc3*params.eccy;
ycoordLoc4 = win.Center(2)+Yloc4*params.eccy;

targetlocation1 = CenterRectOnPoint(rect,xcoordLoc1,ycoordLoc1);
targetlocation2 = CenterRectOnPoint(rect,xcoordLoc2,ycoordLoc2);
targetlocation3 = CenterRectOnPoint(rect,xcoordLoc3,ycoordLoc3);
targetlocation4 = CenterRectOnPoint(rect,xcoordLoc4,ycoordLoc4);

%%%%%%%%%%%%%%%%%%%%%%%%%


%%
% if (system_mode == 10)||(system_mode == 11)
%         Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am1counter), [], targetlocation1, [],[],[],disccolour); 
%         Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am2counter), [], targetlocation2, [],[],[],disccolour); 
%         Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am3counter), [], targetlocation3, [],[],[],disccolour); 
%         Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am4counter), [], targetlocation4, [],[],[],disccolour); 
if (TL_on == 1)
    Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am1counter), [], targetlocation1, [],[],[],params.disccolour);
end
if (TR_on == 1)
    Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am2counter), [], targetlocation2, [],[],[],params.disccolour); %[], [], c_rampval
end
if (BL_on == 1)
    Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am3counter), [], targetlocation3, [],[],[],params.disccolour); %[], [], c_rampval
end
if (BR_on == 1)
    Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am4counter), [], targetlocation4, [],[],[],params.disccolour); %[], [], c_rampval
end