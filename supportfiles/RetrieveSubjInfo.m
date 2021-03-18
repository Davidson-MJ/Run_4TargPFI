%% RetrieveSubjInfo
if params.debugging~=1
    %%get subject data
    prevsubjinfo = GetPreviousSubjInfo('SubjSeedinfo.txt');   %% Get Previous Subject Names and RandomSeeds
    answerdlg    = MyDialogBoxes(prevsubjinfo);               %% Input Current Subject Name and RandomSeed
    
    %%
    if ~isempty(answerdlg)
        
        subject         = answerdlg{1};      % get subjects name
        randomseed      = answerdlg{2};      % get subjects seed for random number generator
        expstart        = datestr(now,'ddmmmyyyy-HH.MM');   % string with current date
    end
    
else
    subject         = 'debug';      % get subjects name
    randomseed      = num2str(randi(1000));      % get subjects seed for random number generator
    expstart        = datestr(now,'ddmmmyyyy-HH.MM');   % string with current date
end
        