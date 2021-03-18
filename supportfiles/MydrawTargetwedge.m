%%
if (~exist('pream1counter'))||(~exist('pream2counter'))||(~exist('pream3counter'))||(~exist('pream4counter'))
    pream1counter=0;
    pream2counter=0;
    pream3counter=0;
    pream4counter=0;
end

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
%%
% baseRect = [0 0 win.Center(2) win.Center(2)];
% 
% xcoordLoc1 = win.Center(1)+win.Center(2)/2;
% xcoordLoc2 = win.Center(1)-win.Center(2)/2;
% xcoordLoc3 = win.Center(1)+win.Center(2)/2;
% xcoordLoc4 = win.Center(1)-win.Center(2)/2;
% 
% ycoordLoc1 = win.Center(2)-win.Center(2)/2;
% ycoordLoc2 = win.Center(2)-win.Center(2)/2;
% ycoordLoc3 = win.Center(2)+win.Center(2)/2;
% ycoordLoc4 = win.Center(2)+win.Center(2)/2;
% 
% targetlocation1 = CenterRectOnPoint(baseRect,xcoordLoc1,ycoordLoc1);
% targetlocation2 = CenterRectOnPoint(baseRect,xcoordLoc2,ycoordLoc2);
% targetlocation3 = CenterRectOnPoint(baseRect,xcoordLoc3,ycoordLoc3);
% targetlocation4 = CenterRectOnPoint(baseRect,xcoordLoc4,ycoordLoc4);



%%
% if (sysmode == 0)||(sysmode == 1)
%     
%     Screen('DrawTexture', win.Number, wedgeTexture_TR(angle,am2counter), [], targetlocation1wedge, [],[],[],disccolour); %[], [], c_rampval
%     Screen('DrawTexture', win.Number, wedgeTexture_TR(angle,am1counter), [], targetlocation2wedge, 270,[],[],disccolour); %[], [], c_rampval
%     Screen('DrawTexture', win.Number, wedgeTexture_TR(angle,am4counter), [], targetlocation3wedge, 90,[],[],disccolour); %[], [], c_rampval
%     Screen('DrawTexture', win.Number, wedgeTexture_TR(angle,am3counter), [], targetlocation4wedge, 180,[],[],disccolour); %[], [], c_rampval
%     
if (TL_on == 1)
    Screen('DrawTexture', win.Number, wedgeTexture_TR(angle,am1counter), [], targetlocation2wedge, 270,[],[],params.disccolour); %[], [], c_rampval
end
if (TR_on == 1)
    Screen('DrawTexture', win.Number, wedgeTexture_TR(angle,am2counter), [], targetlocation1wedge, [],[],[],params.disccolour); %[], [], c_rampval
end
if (BL_on == 1)
    Screen('DrawTexture', win.Number, wedgeTexture_TR(angle,am3counter), [], targetlocation4wedge, 180,[],[],params.disccolour); %[], [], c_rampval
end
if (BR_on == 1)
    Screen('DrawTexture', win.Number, wedgeTexture_TR(angle,am4counter), [], targetlocation3wedge, 90,[],[],params.disccolour); %[], [], c_rampval
end
