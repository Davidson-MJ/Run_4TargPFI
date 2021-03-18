
% set the counters, which determine when the target images will be
% refreshed. (after 'waitframes')
if (~exist('pream1counter'))||(~exist('pream2counter'))||(~exist('pream3counter'))||(~exist('pream4counter'))
    pream1counter=0;
    pream2counter=0;
    pream3counter=0;
    pream4counter=0;
end

F_TL = params.waitframes(TL_index);
F_TR = params.waitframes(TR_index);
F_BL = params.waitframes(BL_index);
F_BR = params.waitframes(BR_index);

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
disccolour = params.disccolour; 

%%
if (system_mode == 20)||(system_mode == 21) 
    %if before or after catch, show Target
    if (frame < catchTrials(options(trialdata{trial}.condition,1),6))||(frame > catchTrials(options(trialdata{trial}.condition,1),7))
        Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am1counter), [], targetlocation1, [],[],[],disccolour); 
        Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am2counter), [], targetlocation2, [],[],[],disccolour); 
        Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am3counter), [], targetlocation3, [],[],[],disccolour); 
        Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am4counter), [], targetlocation4, [],[],[],disccolour); 
    else
        %if within catch, see if it should be absent:
%         (based on location designated in catchTrials).
        if (catchTrials(options(trialdata{trial}.condition,1),1)==0)
            Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am1counter), [], targetlocation1, [],[],[],disccolour);
        end
        if (catchTrials(options(trialdata{trial}.condition,1),2)==0)
            Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am2counter), [], targetlocation2, [],[],[],disccolour);
        end
        if (catchTrials(options(trialdata{trial}.condition,1),3)==0)
            Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am3counter), [], targetlocation3, [],[],[],disccolour);
        end
        if (catchTrials(options(trialdata{trial}.condition,1),4)==0)
            Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am4counter), [], targetlocation4, [],[],[],disccolour);
        end
    end
    
elseif (system_mode == 22) %other conds. (system_modes determined by calibration. 20 is main exp.)
    Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am1counter), [], targetlocation1, [],[],[],disccolour);
elseif (system_mode == 23)
    Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am2counter), [], targetlocation2, [],[],[],disccolour);
elseif (system_mode == 24)
    Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am3counter), [], targetlocation3, [],[],[],disccolour);
elseif (system_mode == 25)
    Screen('DrawTexture', win.Number, MyTargetTexture(cir_size,am4counter), [], targetlocation4, [],[],[],disccolour);
end
