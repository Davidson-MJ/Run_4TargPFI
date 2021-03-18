

 
 %This draws the selected random background.
%backgtex=Screen('MakeTexture', win.Number, rectdyn(:,:,choose));
% Screen('DrawTexture', win.Number, texindexes(backgrounds_rand(backgroundcounter),1));

if ~exist('preBGcounter')
    preBGcounter=0;
end


if (mod(frame,3)==0) || (frame==1)
    BGcounter = randi([1 99],1,1);
    if (BGcounter == preBGcounter)
        BGcounter = BGcounter+1;
    end
    preBGcounter = BGcounter;
end

Screen('DrawTexture', win.Number, texindexes(params.denindex,BGcounter));
