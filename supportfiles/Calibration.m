
%% Begin Calibration Presentation
%% Code by Chunkai Qiu
trial = 0;
denindex = params.denindex; % start at specified BG density index.

while (system_mode>=10)
    % create response vector
    respoTopLeft=zeros(1,empty_nframes);
    respoTopRight=zeros(1,empty_nframes);
    respoBottomLeft=zeros(1,empty_nframes);
    respoBottomRight=zeros(1,empty_nframes);
    
    ecccenterrecord = zeros(1,empty_nframes);
    TargetSizerecord = zeros(1,empty_nframes);
    Frerecord = zeros(4,empty_nframes);    
    Targets_onrecord = zeros(5,empty_nframes); 

    TL_on = 1;    
    TR_on = 1;    
    BL_on = 1;    
    BR_on = 1;
    BG_on = 1;
                
    %% start animation

    trial = trial + 1;
    iTest = -1;
    InitialTime = GetSecs;
    i = ceil((GetSecs-InitialTime)*win.RefreshRate);
    vbl = Screen('Flip', win.Number);
    startTime = clock;
    
    %% begin this trial:
    for frame = 1:trialduration
        
        % Breaks if we finished
        if frame > trialduration(end)
            % Just in case final frame is not recorded, because that would
            % break the frame fixing function
            if isnan(respo(end, 3))
                respo(end, :) = [1, 0, GetSecs - InitialTime];
            end
            break
        end
        
        % Waits for the next frame if we are getting ahead of ourselves
        if frame > iTest
            pause(((frame+1)/win.RefreshRate) - GetSecs);
            i = i + 1;
        end
        iTest = frame;
        
        % Triggers for EEG
        if params.inEEGroom
            if frame ==1
                io64(ioObj,portcode, 10); %% trigger for Calibration start
                %% 88 is trial ended
            end
        end
        
        %% %% %% %% %% %% %% %% %% %% %%
        %% draw targets  %%
        %% %% %% %% %% %% %% %% %% %% %%
        
        if (BG_on == 1)
            dynamicBackgr;
        end
        
        
        if (params.IsWedgeExperiment == 0)
            DrawTargetCheckboard_Cali;
        else
            MydrawTargetwedge;
        end
        
        FixationCross;
        %% draw photodiode square:
%         drawSquare;
        
        %%
        startFlip(frame) = GetSecs;
        vbl = Screen('Flip', win.Number, vbl + (waitframes-0.5)*ifi);
        endFlip(frame)=GetSecs;
        
        % collect button responses
        
        ecccenterrecord(frame) = params.eccy;
        TargetSizerecord(frame) = cir_size;
        Frerecord(1,frame) = TL_index;
        Frerecord(2,frame) = TR_index;
        Frerecord(3,frame) = BL_index;
        Frerecord(4,frame) = BR_index;
        
        Targets_onrecord(1,frame) = TL_on;
        Targets_onrecord(2,frame) = TR_on;
        Targets_onrecord(3,frame) = BL_on;
        Targets_onrecord(4,frame) = BR_on;
        Targets_onrecord(5,frame) = BG_on;
        
        % Get the current position of the mouse
        [mx, my, buttons] = GetMouse(win.Number);
       
        mx = min(mx, win.Width);
        my = min(my, win.Height);
        
        currbuttons = buttons;
        
        if ~exist('pastbuttons')
            pastbuttons = currbuttons;
        end
        
        if any(buttons) && sum(currbuttons ~= pastbuttons)
            if (mx<win.Center(1)) && (my<win.Center(2))
                TL_on = ~TL_on;
            elseif (mx>win.Center(1)) && (my<win.Center(2))
                TR_on = ~TR_on;
            elseif (mx<win.Center(1)) && (my>win.Center(2))
                BL_on = ~BL_on;
            elseif (mx>win.Center(1)) && (my>win.Center(2))
                BR_on = ~BR_on;
            end
        end
        
        pastbuttons = currbuttons;
        
        [currkeyIsDown, ~, keyCode] = KbCheck(-1);
        
        currKeyCode = keyCode;
        if ~exist('pastKeyCode')
            pastKeyCode = currKeyCode;
        end
        if ~exist('pastkeyIsDown')
            pastkeyIsDown = currkeyIsDown;
        end
        
        if currkeyIsDown
            
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
            %only use to send portcodes.
            if params.inEEGroom
            io64(ioObj,portcode, bitshift(respoTopLeft(frame),3)+bitshift(respoTopRight(frame),2)+bitshift(respoBottomLeft(frame),1)+respoBottomRight(frame));
            end
            if sum (currKeyCode ~= pastKeyCode)
                
                if (params.IsWedgeExperiment == 0)
                    if keyCode(key1)
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
                
                if any(find(keyCode)==Return)
                    BG_on = ~BG_on;
                end
                
                if keyCode(shift)
                    IsWedgeExperiment = ~IsWedgeExperiment;
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
                
                if keyCode(F3)
                    params.disccolour(1,1) = params.disccolour(1,1) + 5;
                    if (params.disccolour(1,1)> 255)
                        params.disccolour(1,1) = 180;
                    end
                end
                
                if keyCode(F4)
                    params.disccolour(1,2) = params.disccolour(1,2) + 5;
                    if (params.disccolour(1,2)> 255)
                        params.disccolour(1,2) = 180;
                    end
                end
                
                if keyCode(F5)
                    params.disccolour(1,3) = params.disccolour(1,3) + 5;
                    if (params.disccolour(1,3)> 255)
                        params.disccolour(1,3) = 180;
                    end
                end
                
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
                
                if keyCode(key3)
                    denindex = denindex - 1;
                    if  denindex<=1
                        denindex=1;
                    end
                elseif keyCode(key4)
                    denindex = denindex + 1;
                    if denindex>=17
                        denindex=17;
                    end
                end
                
            end
            
            % check for quit key
            if any(find(keyCode)==quitkey)
                if params.inEEGroom
                    io64(ioObj,portcode, 80);
                end
                system_mode = 1;
                break;
            end
        end
        if (pastkeyIsDown == 1)&&(currkeyIsDown == 0)&& params.inEEGroom==1
            if params.inEEGroom
                io64(ioObj,portcode,77);
            end
        end
        
        pastKeyCode = currKeyCode;
        pastkeyIsDown = currkeyIsDown;
        
    end
    
    %%
    if system_mode ~= 1
        endTime = clock;
        if EEG
        io64(ioObj,portcode, 88);
        end
        buttonpressTopLeft = respoTopLeft;
        buttonpressTopRight = respoTopRight;
        buttonpressBottomLeft = respoBottomLeft;
        buttonpressBottomRight = respoBottomRight;
        
        dataTopLeft = [nan(1,14) buttonpressTopLeft];
        dataTopRight = [nan(1,14) buttonpressTopRight];
        dataBottomLeft = [nan(1,14) buttonpressBottomLeft];
        dataBottomRight = [nan(1,14) buttonpressBottomRight];
        
        datam(1,1:size(dataTopLeft,2)) = dataTopLeft; % backup to save as .mat file at end of experiment
        datam(2,1:size(dataTopRight,2)) = dataTopRight;
        datam(3,1:size(dataBottomLeft,2)) = dataBottomLeft;
        datam(4,1:size(dataBottomRight,2)) = dataBottomRight;
        
        %% save trial output.
        filename = ['Calibration_Trial' num2str(trial) '_data.mat'];
        save(filename, 'datam', 'dataTopLeft', 'dataTopRight', 'dataBottomLeft', 'dataBottomRight','endFlip', ... 
            'ecccenterrecord','endTime','startTime','TargetSizerecord','Frerecord','Targets_onrecord')
      
        clearvars datam dataBottomLeft dataBottomRight dataTopLeft dataTopRight vblTimes startFlip endFlip ecccenterrecord ...
            TargetSizerecord Frerecord endTime startTime
    end
end