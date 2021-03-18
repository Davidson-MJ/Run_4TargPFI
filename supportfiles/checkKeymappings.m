
%% check if the pressed key requires any change to system.
%Note that the key mappings are listed in menu.m, as well as the How to use
%PFI-BCI.doc

% key1        = KbName('leftarrow'); Decrease eccentricity
% key2        = KbName('rightarrow'); Increase eccentricity
% key3        = KbName('downarrow'); Decrease background density
% key4        = KbName('uparrow'); Increase background densitiy
% quitkey     = KbName('Q');
% ESC         = KbName('ESCAPE');
% space       = KbName('space');
% TopLeft      = KbName('r');    TopLeft PFI
% TopRight     = KbName('i'); % TopRight PFI
% BottomLeft     = KbName('f'); Bottom Left PFI
% BottomRight    = KbName('j'); Bottom Right PFI
% Return      = KbName('Return');% 40; Bakground on/off
% shift       = KbName('rightshift'); Target design (disc/wedge)
%% responses for disappearance (PFI):
if any(find(keyCode)==TopLeft)
    respoTopLeft(frame) = 1;
end
if any(find(keyCode)==TopRight)
    respoTopRight(frame) = 1;
end
if any(find(keyCode)==BottomLeft)
    respoBottomLeft(frame) = 1;
end
if any(find(keyCode)==BottomRight)
    respoBottomRight(frame) = 1;
end
%% send trigger
if params.inEEGroom
    io64(ioObj,portcode, bitshift(respoTopLeft(frame),3)+bitshift(respoTopRight(frame),2)+bitshift(respoBottomLeft(frame),1)+respoBottomRight(frame));
end
%% adjust parameters?
if sum (currKeyCode ~= pastKeyCode)
    
    if ~params.IsWedgeExperiment
        if keyCode(key1) %adjust target eccentricity
            params.eccy = params.eccy - 10;
            params.eccx = params.eccx - 10;
            if  params.eccy<(params.targetSize/2)
                params.eccy=(params.targetSize/2);
            end
            if  params.eccx<(params.targetSize/2)
                params.eccx=(params.targetSize/2);
            end
            
        elseif keyCode(key2)
            params.eccy = params.eccy + 10;
            params.eccx = params.eccx + 10;
            if params.eccx>min(win.Center(2)-(params.targetSize/2),win.Center(1)-(params.targetSize/2))
                params.eccx=min(win.Center(2)-(params.targetSize/2),win.Center(1)-(params.targetSize/2));
            end
            if params.eccy>min(win.Center(2)-(params.targetSize/2),win.Center(1)-(params.targetSize/2))
                params.eccy=min(win.Center(2)-(params.targetSize/2),win.Center(1)-(params.targetSize/2));
            end
        end
    end
%% toggle background    
    if any(keyCode==Return(1)) || any(keyCode==Return(2))               
        system_mode = system_mode + 1;
        if (system_mode > 25)
            system_mode = 20;
        end
    end
 %%   
    if keyCode(shift) %change target design (disc  / wedge)
        params.IsWedgeExperiment = ~params.IsWedgeExperiment;
    end
    
    if (params.IsWedgeExperiment == 1)
        if keyCode(key1)
            angle = angle - 1;
            if  angle<=1
                angle=1;
            end
        elseif keyCode(key2)
            angle = angle + 1;
            if angle>=10
                angle=10;
            end
        end
    end
    
    %% adjust target size
    if keyCode(F1)
        
        cir_size = cir_size - 1;
        if  cir_size<=1
            cir_size=1;
        end
    elseif keyCode(F2)
        cir_size = cir_size + 1;
        if cir_size>=6
            cir_size=6;
        end
    end
    %% Update R,G,B colour values of the target:
    if keyCode(F3)
        params.disccolour(1) = params.disccolour(1)+ 5;
        if (params.disccolour(1)> 255)
            params.disccolour(1) = 180;
        end
    end
    
    if keyCode(F4)
        params.disccolour(2)= params.disccolour(2)+ 5;
        if (params.disccolour(2)> 255)
            params.disccolour(2)= 180;
        end
    end
    
    if keyCode(F5)
        params.disccolour(3)= params.disccolour(3)+ 5;
        if (params.disccolour(3) > 255)
            params.disccolour(3) = 180;
        end
    end
    
    %% Increase  flicker frequency of targets at each location:
    if keyCode(F9)
        TL_index = TL_index + 1;
        if (TL_index > 4)
            TL_index = 1;
        end
    end
    
    if keyCode(F10)
        TR_index = TR_index + 1;
        if (TR_index > 4)
            TR_index = 1;
        end
    end
    
    if keyCode(F11)
        BL_index = BL_index + 1;
        if (BL_index > 4)
            BL_index = 1;
        end
    end
    
    if keyCode(F12)
        BR_index = BR_index + 1;
        if (BR_index > 4)
            BR_index = 1;
        end
    end
    
    %% density index of background textures (preloaded)
    %Decrease:
    if keyCode(key3) %
        params.denindex = params.denindex - 1;
        if  params.denindex<=1
            params.denindex=1;
        end
      % increase:  
    elseif keyCode(key4)
        params.denindex = params.denindex + 1;
        if params.denindex>=17
            params.denindex=17;
        end
    end
    
end

