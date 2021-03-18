%% Computes Catch Trials for Four stimuli. 
% specifies the  catch paramaters%
params.catchbuffer  = [10 10];    % first n seconds, and last n seconds of the trial during which the catch trial cannot occur
params.catchdur     = [5 8];     % min and max duration of catch in sec;
params.catchrange   = [params.catchbuffer(1) params.trialdur-params.catchbuffer(2)];   % min and max START time of catch in sec;


%% define locations for catch disappearance events:
%catches with 1 disap:
catch1dis(1,:)=[1,0,0,0];
catch1dis(2,:)=[0,1,0,0];
catch1dis(3,:)= [0,0,1,0];
catch1dis(4,:)= [0,0,0,1];
 
 %catches with 2 disap:
 catch2dis(1,:)=[1,1,0,0];
 catch2dis(2,:)=[0,1,1,0];
 catch2dis(3,:)=[0,0,1,1];
 catch2dis(4,:)=[1,0,1,0];
 catch2dis(5,:)=[0,1,0,1];
 catch2dis(6,:)=[1,0,0,1];
 
 %catches with 3 disap:
 catch3dis(1,:)=[1,1,1,0];
 catch3dis(2,:)=[0,1,1,1];
 catch3dis(3,:)=[1,0,1,1];
 catch3dis(4,:)=[1,1,0,1];

 %catches with 4 disap:
 catch4dis(1,:)=[1,1,1,1];
 catch4dis(2,:)=[1,1,1,1];
 catch4dis(3,:)=[1,1,1,1];
 catch4dis(4,:)=[1,1,1,1];

catchTrials_tmp(1:4,1:4)=catch1dis;
catchTrials_tmp(5:10,1:4)=catch2dis;
catchTrials_tmp(11:14,1:4)=catch3dis;
catchTrials_tmp(15:18,1:4)=catch4dis;
catchTrials_tmp(19:22,1:4)=catch1dis;
catchTrials_tmp(23:28,1:4)=catch2dis;
catchTrials_tmp(29:32,1:4)=catch3dis;
catchTrials_tmp(33:36,1:4)=catch4dis; 
catchTrials_tmp(37:40,1:4)=catch1dis;
catchTrials_tmp(41:44,1:4)=catch3dis;
catchTrials_tmp(45:48,1:4)=catch4dis; 

catchTrials_tmp(:,5) = sum(catchTrials_tmp(:,1:4),2);

catchTrials = catchTrials_tmp;

%% define timing of disappearances per trial:
for i = 1:48
    catchstart      = round((params.catchrange(1) + diff(params.catchrange) * rand()) * win.RefreshRate);
    catchduration   = round((params.catchdur(1)   + diff(params.catchdur) * rand())* win.RefreshRate);
    catchend        = catchstart + catchduration;
    catchTrials(i,6:7) = [catchstart catchend];
end
params.catchTrials = catchTrials;
clear catchTrials_tmp catch1dis catch2dis catch3dis catch4dis 
clear catchstart catchduration catchend choicevec i