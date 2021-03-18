
%% Begin Stim Presentation
while (system_mode>=20)&&(system_mode<=25)
    
    for trial = 1:ntrials+1; %%+1 so that it repeats the first trial twice
        
        if trial>1 %%This section makes it repeat the first trial twice.
            trial=trial-1;%%Allowing a practice trial
        end
        
        trialdata{trial}.centricity = p.eccy;
        
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
        Screen('DrawText',win.Number,['Press any key to start trial ' num2str(trial) 'of ' num2str(ntrials)],win.Center(1)-220, win.Center(2)-10);
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
            if EEG
                if frame ==1
                    io64(ioObj,portcode, 20); %% trigger for trial start
                    %% 88 is trial ended
                end
            end
            
            % send trigger/event codes to tobii
            %             if usetobii ==1;
            %                 if frame == catchstart
            %                     talk2tobii('EVENT', 'Trial_catch_start', 5 );
            %
            %                 elseif frame == catchend
            %                     talk2tobii('EVENT', 'Trial_catch_end', 5 );
            %                 end
            %             else
            %             end
            
            %% %% %% %% %% %% %% %% %% %% %%
            %% draw fixation cross and target  %%
            %% %% %% %% %% %% %% %% %% %% %%
            
            if (system_mode == 20)
                dynamicBackgr;
            end
            
            % if (IsWedgeExperiment == 0)
                DrawTargetCheckboard_15Hz;
            % else
            %     MydrawTargetwedge;
            % end
            
            FixationCross;
%             drawSquare;
            
            %%
            startFlip(frame) = GetSecs;
            vbl = Screen('Flip', win.Number, vbl + (waitframes-0.5)*ifi);
            endFlip(frame)=GetSecs;
            
            % collect button responses
            
            ecccenterrecord(frame) = p.eccy;
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
                
                if any(find(keyCode)==UpLeft)
                    respoTopLeft(frame) = 1;
                end
                if any(find(keyCode)==UpRight)
                    respoTopRight(frame) = 1;
                end
                if any(find(keyCode)==LowLeft)
                    respoBottomLeft(frame) = 1;
                end
                if any(find(keyCode)==LowRight)
                    respoBottomRight(frame) = 1;
                end
                if EEG
             io64(ioObj,portcode, bitshift(respoTopLeft(frame),3)+bitshift(respoTopRight(frame),2)+bitshift(respoBottomLeft(frame),1)+respoBottomRight(frame));
                end
                if sum (currKeyCode ~= pastKeyCode)
                    
                    if (IsWedgeExperiment == 0)
                        if keyCode(key1)
                            p.eccy = p.eccy - 10;
                            p.eccx = p.eccx - 10;
                            if  p.eccy<(p.targetsize/2)
                                p.eccy=(p.targetsize/2);
                            end
                            if  p.eccx<(p.targetsize/2)
                                p.eccx=(p.targetsize/2);
                            end
                            
                        elseif keyCode(key2)
                            p.eccy = p.eccy + 10;
                            p.eccx = p.eccx + 10;
                            if p.eccx>min(win.Center(2)-(p.targetsize/2),win.Center(1)-(p.targetsize/2))
                                p.eccx=min(win.Center(2)-(p.targetsize/2),win.Center(1)-(p.targetsize/2));
                            end
                            if p.eccy>min(win.Center(2)-(p.targetsize/2),win.Center(1)-(p.targetsize/2))
                                p.eccy=min(win.Center(2)-(p.targetsize/2),win.Center(1)-(p.targetsize/2));
                            end
                        end
                    end
                    
                    if any(find(keyCode)==Return)
                        system_mode = system_mode + 1;
                        if (system_mode > 25)
                            system_mode = 20;
                        end
                    end
                    
                    if keyCode(shift)
                        IsWedgeExperiment = ~IsWedgeExperiment;
                    end
                    
                    if (IsWedgeExperiment == 1)
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
                        disccolour_R = disccolour_R + 5;
                        if (disccolour_R > 255)
                            disccolour_R = 180;
                        end
                    end
                    
                    if keyCode(F4)
                        disccolour_G = disccolour_G + 5;
                        if (disccolour_G > 255)
                            disccolour_G = 180;
                        end
                    end
                    
                    if keyCode(F5)
                        disccolour_B = disccolour_B + 5;
                        if (disccolour_B > 255)
                            disccolour_B = 180;
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
                    io64(ioObj,portcode, 80);
                    system_mode = 1;
                    break;
                end
            end
            
            if (pastkeyIsDown == 1)&&(currkeyIsDown == 0) && EEG
                io64(ioObj,portcode,77);
            end
            
            pastKeyCode = currKeyCode;
            pastkeyIsDown = currkeyIsDown;
            
            
            %             if usetobii ==1
            %
            %                 if frame>1
            %                     if (respo(frame) == 1 && respo(frame-1) == 0)
            %                         talk2tobii('EVENT', 'Trial_button_press', 5 );
            %                     elseif (respo(frame) == 0 && respo(frame-1) == 1)
            %                         talk2tobii('EVENT', 'Trial_button_release', 5 );
            %                     end
            %                 end
            %             else
            %             end
            % Screen('Close', [blobtexLoc1 blobtexLoc2 blobtexLoc3 blobtexLoc4]); %texindexes(backgroundcounter,1)
            % Screen('Close', checkerTexture); %texindexes(backgroundcounter,1)
        end
        
        %         buttonpressTopLeft = respoTopLeft;
        %         buttonpressTopRight = respoTopRight;
        %         buttonpressBottomLeft = respoBottomLeft;
        %         buttonpressBottomRight = respoBottomRight;
        %
        %         dataTopLeft = [options(trialdata{trial}.condition,:) catchTrials(options(trialdata{trial}.condition,1),:) Struct2mat(trialdata{trial}) catchstart catchend buttonpressTopLeft];
        %         dataTopRight = [options(trialdata{trial}.condition,:) catchTrials(options(trialdata{trial}.condition,1),:) Struct2mat(trialdata{trial}) catchstart catchend buttonpressTopRight];
        %         dataBottomLeft = [options(trialdata{trial}.condition,:) catchTrials(options(trialdata{trial}.condition,1),:) Struct2mat(trialdata{trial}) catchstart catchend buttonpressBottomLeft];
        %         dataBottomRight = [options(trialdata{trial}.condition,:) catchTrials(options(trialdata{trial}.condition,1),:) Struct2mat(trialdata{trial}) catchstart catchend buttonpressBottomRight];
        %
        %         datam(1,trial,1:size(dataTopLeft,2)) = dataTopLeft; % backup to save as .mat file at end of experiment
        %         datam(2,trial,1:size(dataTopRight,2)) = dataTopRight;
        %         datam(3,trial,1:size(dataBottomLeft,2)) = dataBottomLeft;
        %         datam(4,trial,1:size(dataBottomRight,2)) = dataBottomRight;
        %
        %         if debugging<1
        %             cd(savebasesubject)
        %             if saveq==1
        %                 SaveToFile(dataTopLeft,'FileName',[subject '_TL_TF_flickerExp.txt']);
        %                 SaveToFile(dataTopRight,'FileName',[subject '_TR_TF_flickerExp.txt']);
        %                 SaveToFile(dataBottomLeft,'FileName',[subject '_BL_TF_flickerExp.txt']);
        %                 SaveToFile(dataBottomRight,'FileName',[subject '_BR_TF_flickerExp.txt']);
        %             end
        %         end
        %         %             cd(taskpath)
        %         %         end
        %
        %         filename = ['Trial' num2str(trial) '_data.mat'];
        %         save(filename, 'datam', 'dataTopLeft', 'dataTopRight', 'dataBottomLeft', 'dataBottomRight', 'trialdata', 'options', 'startFlip', 'endFlip')
        %         clearvars datam dataBottomLeft dataBottomRight dataTopLeft dataTopRight vblTimes startFlip endFlip
        
        %%
        if system_mode ~= 1;
            
            endTime = clock;
            if EEG
            io64(ioObj,portcode, 88);
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
            
            if debugging<1
                cd(savebasesubject)
                if saveq==1
                    %                 SaveToFile(dataTopLeft,'FileName',[subject '_TL_TF_flickerExp.txt']);
                    %                 SaveToFile(dataTopRight,'FileName',[subject '_TR_TF_flickerExp.txt']);
                    %                 SaveToFile(dataBottomLeft,'FileName',[subject '_BL_TF_flickerExp.txt']);
                    %                 SaveToFile(dataBottomRight,'FileName',[subject '_BR_TF_flickerExp.txt']);
                end
            end
            %             cd(taskpath)
            %         end
            
            filename = ['AllTarget15Hz_Trial' num2str(trial) '_data.mat'];
            save(filename, 'datam', 'dataTopLeft', 'dataTopRight', 'dataBottomLeft', 'dataBottomRight','endFlip','ecccenterrecord','endTime','startTime', ...
                'TargetSizerecord','Frerecord','system_moderecord','trialdata', 'options','catchTrials')
            clearvars datam dataBottomLeft dataBottomRight dataTopLeft dataTopRight vblTimes startFlip endFlip ecccenterrecord ...
                TargetSizerecord freTLrecord freTRrecord freBLrecord freBRrecord system_moderecord
        else
            break;
        end
    end
    system_mode = 0;
end