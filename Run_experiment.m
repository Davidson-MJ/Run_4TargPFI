%% Code to run an experiment with 4 targets over a dynamic background.
% At the moment, hard coded to create 48 trials. 

% This is based on 4 different target flicker frequencies as 
% 4! = 24, repeated twice.

% Alternate option is a single frequency for all target locations.


% last update:
% MD 18/03/21
%% 
close all; clear all;

params=[];
params.debugging=1; %1 to throw a smaller window and skip sync tests.
params.offscreen=1; %1 for dual monitor set up
params.inEEGroom = 0; %1 for use with Monash Biomedical Imaging EEG lab (sends triggers etc)

% Variables
params.BG_pixel = 10;  % [in pixels, a multiple of 2] This sets the background pixel size
params.BG_Prepare = 0; % If BG_pixel is changed, set BG_Prepare to 1, otherwise 
% always set to 0, as pregenerating the BG takes time.

params.Circle_Prepare = 0; % precompute the circular targets
params.denindex = 9; % density index of background. [density = 10:5:90];
params.IsWedgeExperiment = 0;

%Target Parameters. 
% RGB colour values for the 'white' space between dark pixels.
params.disccolour = [205, 205, 255];

% These are the frames to wait before updating each
% target. On a 60 Hz monitor, 60/4 = 15 Hz flicker. 
% [top left, top right, bottom left, bottom right]
params.waitframes = [4 4 4 4]; 
%NB, at the moment, ComputeConditions.m only works for either all identical
%target flicker frequencies, or all unique. 

params.targetSize = 200; % starting target size, is (targetSize-100 / 20)

%% begin !
dbstop if error
addpath( [ pwd filesep 'supportfiles'])

% Assign the target flicker to each location, balanced across 48 trials.
ComputeConditions;  
% Create output folder, keyboard set up etc:
startup_prep;

%%
if proceedYN=='y'
    try
        %% User input for subject information:
        RetrieveSubjInfo
        
        %% Set up the screen   
        ListenChar(2); % turn off key echo.
        
        win = SetScreen('BGColor',127,...
            'qFontSize',24,...
            'OpenGL',1,...
            'debug', params.debugging, ...
            'Window', params.offscreen);
        
        ifi = Screen('GetFlipInterval', win.Number);        
        vbl = Screen('Flip', win.Number);
        Screen('BlendFunction', win.Number, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        
        %% These next steps are COSTLY. Toggle whether to run them or not
        % prepare and preload varying background density textures.
        % By preloading, we can toggle the density in real-time:
        PrepDynBackground;
        
        % Same for targets:
        MyPrepareTexture;
%         MyPrepareTexturewedge;
       
        %% Construct input parameters for trial types
        ParameterSet;
        ntrials = length(params.options);% 
        in.condition= 1:ntrials;
        in.size = params.targetSize; %%Added this to randomize size
        in.centricity = params.eccx;

        %% create trialdata structure with relevant trial information.
        trialdata = MakeInputFromStruct(in, 'SaveToFile',1, 'Randomize', 1, 'Replications',1); %
        
       
        %% Run rest of experiment
        % Name of file to save data to
        
        if params.debugging<1
            savebasesubject = [savebasegroup filesep subject '_' answerdlg{3} answerdlg{4}];
            
            %create outpath folder if a new subject
            if exist(savebasesubject) ~= 7
                command = ['mkdir -p ' savebasesubject];
                system(command);
            end
        end
        %% allocate memory for saving button press frame by frame.
        trialduration = params.trialdur*win.RefreshRate;
        empty_nframes = ceil(trialduration);
        %% Confirm button presses?
%            keyboardreg;
        %%
           Screen('Flip', win.Number);
        %%        
        %show menu options. Option to select calibration, or launch an
        %experiment based on params. 
        
        %Note that calibration has the option to update the target
        %eccentricity, freq, targ size, and background density in real time.
% 1, Calibration:
    % ?	Use mouse to click on targets to turn on/off targets
    % ?	Left arrow on keyboard: decrease eccentricity
    % ?	Right arrow on keyboard: increase eccentricity
    % ?	Down arrow on keyboard: decrease background density
    % ?	Up arrow on keyboard: increase background density
    % ?	Return on keyboard: turn background on/off
    % ?	F1: decrease target size
    % ?	F2: increase target size
    % ?	F3: change target colour (R value)
    % ?	F4: change target colour (G value)
    % ?	F5: change target colour (B value)
    % ?	F9: change top left target frequency
    % ?	F10: change top right target frequency
    % ?	F11: change bottom left target frequency
    % ?	F12: change bottom right target frequency
    % ?	Press ?Q? on key board to quit Calibration mode and back to menu. 
% 
% 2, All targets with same frequency 15 Hz: (48 trials and one practice)
    % ?	Note, above keys are not disabled (ensure participant knows this and does not press anything).
    % ?	Press ?Q? on keyboard to quit Calibration mode and back to menu. 
% 
% 3, four targets with different frequencies:
    % ?	As above

        %% THIS LAUNCHES THE Main Experiment >
        ListenChar(2)
        menu;
        
        %% Save at subject level.
        
        SaveToFile({subject randomseed answerdlg{3} answerdlg{4}},'FileName','SubjSeedinfo.txt');
        
        ListenChar(0); % Clear char buffer.
        
        
%         filename=['AllRaw_' num2str(Targtype) '_Data_' num2str(subject) '.mat'];
%         
%         rawData = dataExp;
%         
%         if saveq==1
%             save(filename, 'rawData');
%         end
        
        
        %now add all data to ma2trix for large analysis.
%         cd(savebasegroup)
%         
%         try load(filename) %concatenate if already existing
%             
%             rawData = [rawData; dataExp];
%         catch
%             rawData = dataExp;
%         end
%         qq
%         if saveq==1
%             save(filename, 'rawData');
%         end
        
        
   catch SETUP
        ListenChar(0);        
        params.endexp = datestr(now,'HH.MM');
        ShowCursor;
%         clear screen;        
%         sca
        rethrow(SETUP);
    end
else
    disp('Rethrow program from correct location, or change output directory for saved data.')
    
end
sca
ShowCursor

% if saveq >0
%     processTrialdata
% end
