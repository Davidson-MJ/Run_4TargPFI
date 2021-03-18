%% ComputeConditions:
% This script balances the flicker frequencies across target locations.

% The output is var 'options', a matrix of 48 trials x 5 columns.

% col1 = trial index
% cols 2:5 = flicker frequency per target.

% code written by Chunkai Qiu

%% very hardcoded at the moment. Needs to be updated to allow different 
% trial counts, or equal target flickers 
%% 

[pos1,pos2,pos3,pos4]=deal(params.waitframes);
%%
options=[];
optioncount=0;
if length(unique(params.waitframes))==4
    %we have 4 factorial (24) target flicker location options.
    [OptionsPos1, OptionsPos2, OptionsPos3, OptionsPos4]= deal([]);
    disp('...Creating 48 trials, 4! freq combinations')
    for i=1:4 % for each of 4 target freq options, Position 1.

        framePos1=pos1(i); 
        count=0;

        for n=1:4 
            if pos2(n)>framePos1 || pos2(n)<framePos1
                count=count+1;
                OptionsPos2(count)=pos2(n);
            end
        end
        % For remaining 3 options, Positions 2...
        for j=1:3
            framePos2=OptionsPos2(j);
            count2=0;
            for k=1:4
                if (pos3(k)>framePos2 || pos3(k)<framePos2) && (pos3(k)>framePos1 || pos3(k)<framePos1)
                    count2=count2+1;
                    OptionsPos3(count2)=pos3(k);
                end
            end
            for l=1:2
                framePos3=OptionsPos3(l);
                count3=0;
                for m=1:4
                    if (pos4(m)>framePos2 || pos4(m)<framePos2) && (pos4(m)>framePos1 || pos4(m)<framePos1) && (pos4(m)>framePos3 || pos4(m)<framePos3)
                        count3=count3+1;
                        OptionsPos4(count3)=pos4(m);

                    end
                end
                for o=1:1
                    framePos4=OptionsPos4(o);
                    optioncount=optioncount+1;
                    options_tmp(optioncount,1:4)=[framePos1 framePos2 framePos3 framePos4];
                end
            end
        end
    end

    options(:,2:5)=[options_tmp; options_tmp];
    options(:,1)=randperm(48);
    
elseif length(unique(params.waitframes))==1 % simply repeat the freq at each locaiton?
    disp('...Creating 48 trials, same freq each location')
    options=[];
    options(:,1)=randperm(48);
    options(:,2:5) = repmat(params.waitframes(1), 48, 4);

end


params.options = options;