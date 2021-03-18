% clear all;clc;

% Here we call some default settings for setting up Psychtoolbox

%% The purpose of this script is to confirm that all four buttons can be
% pressed before beginning the experiment. 
% (owing to some keyboard malfunctions in prev attempts).



% PsychDefaultSetup(2);   %%%%%%%%
% Screen('Preference', 'SkipSyncTests', 1); %%%%%%%%%

% Get the screen numbers
screens = Screen('Screens');  %%%%%%

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);  %%%%%%%

% Define black, white and grey
black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white / 2;

% Open an on screen window and color it grey
% [win.Number, win.Rect] = PsychImaging('OpenWindow', screenNumber, grey, [0 0 1200 1200]);
% [window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
% [win.Number, win.Rect] = Screenq('OpenWindow', screenNumber, grey);

% Set the blend funciton for the screen
% Screen('BlendFunction', window,azazazazazazazazazazazazq 'GL_SRC_ALPHA',
% 'GL_ONE_MINUS_SRC_ALPHA');  %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
% [screenXpixels, screenYpixels] = Screen('WindowSize', window); %%%%%%%%
[screenXpixels, screenYpixels] = Screen('WindowSize', win.Number);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(win.Rect);

Screen('TextSize', win.Number, 100);
Screen('TextFont', win.Number, 'Times');
DrawFormattedText(win.Number, 'Keyboard Check', 'center',...
    screenYpixels * 0.18, white);

Screen('TextSize', win.Number, 30);
% Screen('TextFont', win.Number, 'Times');
DrawFormattedText(win.Number, '\n(press correspondent keys on keyboard and hold for 2 secs)', 'center',...
    screenYpixels * 0.3, white);

Screen('TextSize', win.Number, 100);
% Screen('TextFont', win.Number, 'Times');
DrawFormattedText(win.Number, 'R', screenXpixels * 0.2,...
    screenYpixels * 0.45, [255 0 0]);

Screen('TextSize', win.Number, 100);
% Screen('TextFont', win.Number, 'Times');
DrawFormattedText(win.Number, 'F', screenXpixels * 0.25,...
    screenYpixels * 0.7, [255 0 0]);

Screen('TextSize', win.Number, 100);
% Screen('TextFont', win.Number, 'Times');
DrawFormattedText(win.Number, 'I', screenXpixels * 0.8,...
    screenYpixels * 0.45, [255 0 0]);
                
Screen('TextSize', win.Number, 100);
% Screen('TextFont', win.Number, 'Times');
DrawFormattedText(win.Number, 'J', screenXpixels * 0.75,...
    screenYpixels * 0.7, [255 0 0]);

Screen('Flip', win.Number, 0, 1, 0, 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% collect button responses

keyboard_index1 = 0;
keyboard_index2 = 0;
keyboard_index3 = 0;
keyboard_index4 = 0;

while (~keyboard_index1)||(~keyboard_index2)||(~keyboard_index3)||(~keyboard_index4)
    
    [keyIsDown,~, keyCode] = KbCheck(-1);
   
if keyIsDown
    
    if keyCode(UpLeft)
        
        DrawFormattedText(win.Number, 'R', screenXpixels * 0.2,...
            screenYpixels * 0.45, [0 255 0]);
        
        keyboard_index1 = 1;
        
    else
        
        keyboard_index1 = 0;
        
        DrawFormattedText(win.Number, 'R', screenXpixels * 0.2,...
            screenYpixels * 0.45, [255 0 0]);
        
    end
    
    
    if keyCode(LowLeft)
        
        DrawFormattedText(win.Number, 'F', screenXpixels * 0.25,...
            screenYpixels * 0.7, [0 255 0]);
        
        keyboard_index2 = 1;
        
    else
        
        keyboard_index2 = 0;
        
        DrawFormattedText(win.Number, 'F', screenXpixels * 0.25,...
            screenYpixels * 0.7, [255 0 0]);
        
    end
    
    if keyCode(UpRight)
        
        DrawFormattedText(win.Number, 'I', screenXpixels * 0.8,...
            screenYpixels * 0.45, [0 255 0]);
        
        keyboard_index3 = 1;

    else
        
        keyboard_index3 = 0;
        
        DrawFormattedText(win.Number, 'I', screenXpixels * 0.8,...
            screenYpixels * 0.45, [255 0 0]);
        
    end
    
    if keyCode(LowRight)
        
        DrawFormattedText(win.Number, 'J', screenXpixels * 0.75,...
            screenYpixels * 0.7, [0 255 0]);
        
        keyboard_index4 = 1;
        

    else
        
        keyboard_index4 = 0;
        
        DrawFormattedText(win.Number, 'J', screenXpixels * 0.75,...
            screenYpixels * 0.7, [255 0 0]);
        
    end
    
    if keyCode(quitkey)
        % Clear the screen
        sca        
        error('User ended program.');
        
    end
    
    Screen('Flip', win.Number, 0, 1, 0, 0);
    
else
    
    keyboard_index1 = 0;
    keyboard_index2 = 0;
    keyboard_index3 = 0;
    keyboard_index4 = 0;
    
    DrawFormattedText(win.Number, 'R', screenXpixels * 0.2,...
        screenYpixels * 0.45, [255 0 0]);
        
    DrawFormattedText(win.Number, 'F', screenXpixels * 0.25,...
        screenYpixels * 0.7, [255 0 0]);
    
    DrawFormattedText(win.Number, 'I', screenXpixels * 0.8,...
        screenYpixels * 0.45, [255 0 0]);
    
    DrawFormattedText(win.Number, 'J', screenXpixels * 0.75,...
        screenYpixels * 0.7, [255 0 0]);
    
    Screen('Flip', win.Number, 0, 1, 0, 0);
end

if (keyboard_index1)&&(keyboard_index2)&&(keyboard_index3)&&(keyboard_index4)
    
    StartTime = GetSecs;
    
    while (keyboard_index1)||(keyboard_index2)||(keyboard_index3)||(keyboard_index4)
        
        CurrentTime = GetSecs;
        
        [keyIsDown,~, keyCode] = KbCheck;
        
        if keyIsDown
            
            if keyCode(UpLeft)
                
                DrawFormattedText(win.Number, 'R', screenXpixels * 0.2,...
                    screenYpixels * 0.45, [0 255 0]);
                
                keyboard_index1 = 1;
                
            else
                
                keyboard_index1 = 0;
                
                DrawFormattedText(win.Number, 'R', screenXpixels * 0.2,...
                    screenYpixels * 0.45, [255 0 0]);
                
            end
            
            
            if keyCode(LowLeft)
                
                DrawFormattedText(win.Number, 'F', screenXpixels * 0.25,...
                    screenYpixels * 0.7, [0 255 0]);
                
                keyboard_index2 = 1;
                
            else
                
                keyboard_index2 = 0;
                
                DrawFormattedText(win.Number, 'F', screenXpixels * 0.25,...
                    screenYpixels * 0.7, [255 0 0]);
                
            end
            
            if keyCode(UpRight)
                
                DrawFormattedText(win.Number, 'I', screenXpixels * 0.8,...
                    screenYpixels * 0.45, [0 255 0]);
                
                keyboard_index3 = 1;
                
            else
                
                keyboard_index3 = 0;
                
                DrawFormattedText(win.Number, 'I', screenXpixels * 0.8,...
                    screenYpixels * 0.45, [255 0 0]);
                
            end
            
            if keyCode(LowRight)
                
                DrawFormattedText(win.Number, 'J', screenXpixels * 0.75,...
                    screenYpixels * 0.7, [0 255 0]);
                
                keyboard_index4 = 1;
                
                
            else
                
                keyboard_index4 = 0;
                
                DrawFormattedText(win.Number, 'J', screenXpixels * 0.75,...
                    screenYpixels * 0.7, [255 0 0]);
                
            end
            
            if keyCode(quitkey)
                % Clear the screen
                sca;
                error('User ended program.');
                
            end
            
            Screen('Flip', win.Number, 0, 1, 0, 0);
            
        else
            
            keyboard_index1 = 0;
            keyboard_index2 = 0;
            keyboard_index3 = 0;
            keyboard_index4 = 0;
            
            DrawFormattedText(win.Number, 'R', screenXpixels * 0.2,...
                screenYpixels * 0.45, [255 0 0]);
            
            DrawFormattedText(win.Number, 'F', screenXpixels * 0.25,...
                screenYpixels * 0.7, [255 0 0]);
            
            DrawFormattedText(win.Number, 'I', screenXpixels * 0.8,...
                screenYpixels * 0.45, [255 0 0]);
            
            DrawFormattedText(win.Number, 'J', screenXpixels * 0.75,...
                screenYpixels * 0.7, [255 0 0]);
            
            Screen('Flip', win.Number, 0, 1, 0, 0);
        end
        
        if (CurrentTime - StartTime)>=2
            
            break;
        end
    end
end
    
end
    
Screen('Flip', win.Number);

line1 = 'Success';
line2 = 'Experiment start in';
line3 = 'seconds';

presSecs = sort(1:5,'descend');

for i = 1:5
    
    numberString = num2str(presSecs(i));
    % Draw our number to the screen
    Screen('TextSize', win.Number, 90);
    
    DrawFormattedText(win.Number, line1,...
        'center', screenYpixels * 0.18, [0 255 0]);
    DrawFormattedText(win.Number, line2,...
        'center', screenYpixels * 0.33, white);
    DrawFormattedText(win.Number, line3,...
        'center', screenYpixels * 0.55, white);
    
    DrawFormattedText(win.Number, numberString, 'center', 'center', white);

    % Flip to the screen
    Screen('Flip', win.Number);
    WaitSecs(1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fontsize    = 16;
fontcolor   = [255 255 255];   % white
Screen('TextFont', win.Number ,'Helvetica');
Screen('TextSize', win.Number , fontsize);
Screen('TextColor', win.Number , fontcolor);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo
% KbStrokeWait;

% Clear the screen
% sca;