%set up directories
basefol = pwd;
outdir     = [basefol filesep 'BehaviouralData'];      % output data folder


if params.debugging==0
proceedYN = input(['WARNING: Save data to ' num2str(basefol) '/BehaviouralData? Y/N response:'], 's');
else
    proceedYN='y';
end

%create output folder if it doesn't exist.
if ~exist(outdir, 'dir')
    command = ['mkdir -p ' outdir];
    system(command);
end

%% Set up Keyboard
KbName('UnifyKeyNames');
% KbName('KeyNamesOSX');
% KbName('KeyNamesWindows');
key1        = KbName('leftarrow');
key2        = KbName('rightarrow');
key3        = KbName('downarrow');
key4        = KbName('uparrow');
quitkey     = KbName('Q');
ESC         = KbName('ESCAPE');
space       = KbName('space');
TopLeft      = KbName('r');
TopRight     = KbName('i'); % KbName(''"');
BottomLeft     = KbName('f');
BottomRight    = KbName('j');
Return      = KbName('Return');% 40;; 
shift       = KbName('rightshift');
F1          = KbName('F1');
F2          = KbName('F2');
F3          = KbName('F3');
F4          = KbName('F4');
F5          = KbName('F5');
F9          = KbName('F9');
F10         = KbName('F10');
F11         = KbName('F11');
F12         = KbName('F12');
num1        = KbName('1!');
num2        = KbName('2@');
num3        = KbName('3#');


answerkey  = [TopLeft TopRight BottomLeft BottomRight]; % target locations

%skips PTB sync tests for timing, useful when working on dual screens.
Screen('Preference', 'SkipSyncTests', params.debugging);

%% Initialise chat b/w computers for EEG
if params.inEEGroom
    ioObj = io64; % initialise the mex command
    status = io64(ioObj); % Status of the driver
    portcode = hex2dec('0378'); % Portcode to send to EEG machine, 
end