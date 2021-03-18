%% Here is the main branching script. 
% We either run a calibration procedure to define experimental parameters,
% or launch the main experiment based on predefined params.
system_mode = 1;
% ListenChar(2)
while (system_mode>0)
    %% Keyboard sanity check
    % draw text prompt
    Screen('TextSize', win.Number, 30);
    DrawFormattedText(win.Number, ['Dear participant, please press', ...
    ' "R" "I" "F" "J" to respond during the experiment.\n\n',...
    '(Please press these buttons firmly to make sure your response is recorded)\n\n',...
    'Thanks for your participation '],win.Center(1)-600,win.Center(2)-350);
    
    %% menu select options:
    DrawFormattedText(win.Number, ['Select menu option: \n\n',...
        '1. Calibration \n\n',...
        '2. All Targets with 15 Hz\n\n',...
        '3. 4 Targets with different frequencies'], ...
        win.Center(1)-220,win.Center(2)-60);

    Screen('Flip',win.Number);
    
        
    [currkeyIsDown, ~, keyCode] = KbCheck(-1);
    
    currKeyCode = keyCode;
    if ~exist('pastKeyCode')
        pastKeyCode = currKeyCode;
    end
    
    %% Retrieve menu selection:
    if currkeyIsDown
        if sum (currKeyCode ~= pastKeyCode)
            if keyCode(num1)
                system_mode = 10;
            elseif keyCode(num2)
                system_mode = 20;
            elseif keyCode(num3)
                system_mode = 30;
            end
            
            % check for quit key1
            if any(find(keyCode)==ESC)
                system_mode = 0;
                error('User ended program.')
                % sca
            end
        end
        
        pastKeyCode = currKeyCode;
    end
    
    switch system_mode 
        case 10
            Calibration;
        case 20
            ComputeCatchTrials;
            AllTargets15Hz;
        case 30
            ComputeCatchTrials;
            TargetsDiffFre;
    end

end