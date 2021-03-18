nprac=1; % the number of practice trials.
%% Begin Stim Presentation
while (system_mode>=20)&&(system_mode<=25)
    isprac=1;
    for trial = 1:ntrials+1 %%+1 so that it repeats the first trial twice
        
        if trial>nprac %%This section makes it repeat npractrials 
            trial=trial-1;%%Allowing a practice trial
            isprac=0;
        end
        
        trialdata{trial}.centricity = params.eccy;
        
        %set parameters for catch trial (where target is removed)
        %CatchParams;
        
        % create response vector
        respoTopLeft=zeros(1,empty_nframes);
        respoTopRight=zeros(1,empty_nframes);
        respoBottomLeft=zeros(1,empty_nframes);
        respoBottomRight=zeros(1,empty_nframes);
        
        ecccenterrecord = zeros(1,empty_nframes);
        TargetSizerecord = zeros(1,empty_nframes);
        Frerecord = zeros(4,empty_nframes);   
        system_moderecord = zeros(1,empty_nframes);
        
        % draw text prompt
        if isprac
        Screen('DrawText',win.Number,['Press any key to start your ' num2str(nprac) ' practice trials'],win.Center(1)-220, win.Center(2)-10);
        else
             Screen('DrawText',win.Number,['Press any key to start experimental trial ' num2str(trial) 'of ' num2str(ntrials)],win.Center(1)-220, win.Center(2)-10);
        end
        Screen('Flip',win.Number);
        
        %turn off key echo
        ListenChar(2)
        
        % WaitSecs(2);
        KbStrokeWait(-1);
        
        %% set modulating wave for flickering target
        if trial == 1
            targetParameters;
        end
        %% start animation
        InitialTime = GetSecs;
        iTest = -1;
        i = ceil((GetSecs-InitialTime)*win.RefreshRate);
        startTime = clock;
        vbl = Screen('Flip', win.Number);
        
        for frame = 1:trialduration
            
            % Breaks if we have finished
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
                    io64(ioObj,portcode, 20); %% trigger for trial start                    
                end
            end
            
          
            %% %% %% %% %% %% %% %% %% %% %%
            %% draw fixation cross and target  %%
            %% %% %% %% %% %% %% %% %% %% %%
            
            if (system_mode == 20) %draw background.
                dynamicBackgr;
            end
            
            if ~params.IsWedgeExperiment
                DrawTargetCheckboard_15Hz;
            else
                MydrawTargetwedge;
            end
            
            FixationCross;
%             drawSquare;
            
            %%
            startFlip(frame) = GetSecs;
            vbl = Screen('Flip', win.Number, vbl + (waitframes-0.5)*ifi);
            endFlip(frame)=GetSecs;
            
            % record screen state, and collect button responses
            
            ecccenterrecord(frame) = params.eccy;
            TargetSizerecord(frame) = cir_size;
            Frerecord(1,frame) = TL_index;
            Frerecord(2,frame) = TR_index;
            Frerecord(3,frame) = BL_index;
            Frerecord(4,frame) = BR_index;
            system_moderecord(frame) = system_mode;
            
            [currkeyIsDown, secs, keyCode] = KbCheck(-1);
            
            currKeyCode = keyCode;
            if ~exist('pastKeyCode')
                pastKeyCode = currKeyCode;
            end
            if ~exist('pastkeyIsDown')
                pastkeyIsDown = currkeyIsDown;
            end
            
            
            if currkeyIsDown
               
              checkKeymappings;
            end
            % check for quit key
            if any(find(keyCode)==quitkey)
%                 io64(ioObj,portcode, 80);
                system_mode = 1;
                break;
            end
            if (pastkeyIsDown == 1)&&(currkeyIsDown == 0) && params.inEEGroom
                io64(ioObj,portcode,77);
            end
            
            pastKeyCode = currKeyCode;
            pastkeyIsDown = currkeyIsDown;
            
          
        end % for each frame in the trial, store the data.
        
      
        %%
        if system_mode ~= 1
            
            endTime = clock;
            if params.inEEGroom %send trigger for trial end.
                io64(ioObj,portcode, 88); % 
            end
            buttonpressTopLeft = respoTopLeft;
            buttonpressTopRight = respoTopRight;
            buttonpressBottomLeft = respoBottomLeft;
            buttonpressBottomRight = respoBottomRight;
            
            dataTopLeft = [options(trialdata{trial}.condition,1) waitframe(TL_index) waitframe(TR_index) waitframe(BL_index) waitframe(BR_index) catchTrials(options(trialdata{trial}.condition,1),1:4) Struct2mat(trialdata{trial}) catchTrials(options(trialdata{trial}.condition,1),6) catchTrials(options(trialdata{trial}.condition,1),7) buttonpressTopLeft];
            dataTopRight = [options(trialdata{trial}.condition,1) waitframe(TL_index) waitframe(TR_index) waitframe(BL_index) waitframe(BR_index) catchTrials(options(trialdata{trial}.condition,1),1:4) Struct2mat(trialdata{trial}) catchTrials(options(trialdata{trial}.condition,1),6) catchTrials(options(trialdata{trial}.condition,1),7) buttonpressTopRight];
            dataBottomLeft = [options(trialdata{trial}.condition,1) waitframe(TL_index) waitframe(TR_index) waitframe(BL_index) waitframe(BR_index) catchTrials(options(trialdata{trial}.condition,1),1:4) Struct2mat(trialdata{trial}) catchTrials(options(trialdata{trial}.condition,1),6) catchTrials(options(trialdata{trial}.condition,1),7) buttonpressBottomLeft];
            dataBottomRight = [options(trialdata{trial}.condition,1) waitframe(TL_index) waitframe(TR_index) waitframe(BL_index) waitframe(BR_index) catchTrials(options(trialdata{trial}.condition,1),1:4) Struct2mat(trialdata{trial}) catchTrials(options(trialdata{trial}.condition,1),6) catchTrials(options(trialdata{trial}.condition,1),7) buttonpressBottomRight];       
            
            datam(1,1:size(dataTopLeft,2)) = dataTopLeft; % backup to save as .mat file at end of experiment
            datam(2,1:size(dataTopRight,2)) = dataTopRight;
            datam(3,1:size(dataBottomLeft,2)) = dataBottomLeft;
            datam(4,1:size(dataBottomRight,2)) = dataBottomRight;
            
%             if debugging<1
                cd(savebasesubject)
             
                
                filename = ['AllTarget15Hz_Trial' num2str(trial) '_data.mat'];
                save(filename, 'datam', 'dataTopLeft', 'dataTopRight', 'dataBottomLeft', 'dataBottomRight','endFlip','ecccenterrecord','endTime','startTime', ...
                    'TargetSizerecord','Frerecord','system_moderecord','trialdata', 'options','catchTrials')
                
                
%             end
         clearvars datam dataBottomLeft dataBottomRight dataTopLeft dataTopRight vblTimes startFlip endFlip ecccenterrecord ...
                    TargetSizerecord freTLrecord freTRrecord freBLrecord freBRrecord system_moderecord
        else
            break;
        end
    end %% for all ntrials +1
    system_mode = 0;
end % while system_mode = experiment