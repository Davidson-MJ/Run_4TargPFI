%% Creating an array of 100 different random backgrounds

%%%%%%%%******************%%%%%%%%%%%%%%%%
% % % Coding  works for any multiple of 2 pixels background
% % % just need to change the value of BG_pixel


% code written by Chunkai Qiu
%% If we need to regenerate all the background images:
if ~exist([pwd filesep 'supportfiles' filesep 'background'], 'dir')
    mkdir([pwd filesep 'supportfiles' filesep 'background'])
end

if params.BG_Prepare == 1    
    screensize = get( groot, 'Screensize' );
    randd=zeros(screensize(4),screensize(3),100);
    disp('... Preparing background textures, this may take a while...')
    density = 10:5:90;
    
    for densityindex = 1:17
        
        for i = 1:100
            
            % r=rand(screensize(4)/BG_pixel,screensize(3)/BG_pixel)*255;
            
            r = zeros(180,320);
            
            index = 0;
            
            while index < (180*320)*density(densityindex)/100
                
                i1 = randi(180,1,1);
                j1 = randi(320,1,1);
                
                if r(i1,j1) == 0
                    r(i1,j1) = 255;
                    index = index + 1;
                end
            end
            
            for j = 0:screensize(4)-1
                for k = 0:screensize(3)-1
                    randomV(j+1,k+1)=r(floor(j/params.BG_pixel)+1,floor(k/params.BG_pixel)+1);
                end
            end
            
            filename = ['supportfiles/background/BG' num2str(densityindex) '_' num2str(i)];
            variable = randomV;
            save(filename,'variable');
            
        end
        
        clear random r variable
        disp(['... completed for BG density ' num2str(densityindex) ' of  17'])
    end
end
%% %%%%%%******************%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % Coding only works for 2*2 pixel background
% % % 
% % % % for iz=1:100
% % % %     r=rand(screensize(4)/2,screensize(3)/2);
% % % %     countercollodd=0;
% % % %     counterrowodd=0;
% % % %     countercolleven=0;
% % % %     counterroweven=0;
% % % %     random=zeros(screensize(4),screensize(3));
% % % %     for i=1:screensize(3)
% % % %         counterroweven=0;
% % % %         counterrowodd=0;
% % % %         isodcoll = mod(i,2);
% % % %         if isodcoll==1
% % % %             countercollodd=countercollodd+1;
% % % %             for j=1:screensize(4)
% % % %                 isodrow = mod(j,2);
% % % %                 if isodrow==1
% % % %                     counterrowodd=counterrowodd+1;
% % % %                     random(j,i)=r(counterrowodd,countercollodd);
% % % %                 elseif isodrow==0
% % % %                     counterroweven=counterroweven+1;
% % % %                     random(j,i)=r(counterroweven,countercollodd);
% % % %                 end
% % % %             end
% % % %         elseif isodcoll==0
% % % %             countercolleven=countercolleven+1;
% % % %             for j=1:screensize(4)
% % % %                 isodrow = mod(j,2);
% % % %                 if isodrow==1
% % % %                     counterrowodd=counterrowodd+1;
% % % %                     random(j,i)=r(counterrowodd,countercollodd);
% % % %                 elseif isodrow==0
% % % %                     counterroweven=counterroweven+1;
% % % %                     random(j,i)=r(counterroweven,countercolleven);
% % % %                 end
% % % %             end
% % % %         end
% % % %     end
% % % %     randd(:,:,iz)=random;
% % % %     
% % % % end
% % % % 
% % % % rectdyn=randd*250;
% % % 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % 
% % % % %%
% % % % % Save to file
% % % % for ind = 1:100
% % % %     filename = ['background/BG' num2str(ind)];
% % % %     variable = rectdyn(:,:,ind);
% % % %     save(filename,'variable');
% % % % end
% % % % 
% % % % %% Making it 2 by 2
% % % % 
% % % % % screensize = get( groot, 'Screensize' );
% % % % % r=zeros(screensize(4)/2,screensize(3)/2,100);
% % % % % for iz=1:100
% % % % %  r(:,:,iz)=rand(screensize(4)/2,screensize(3)/2);
% % % % %  rectdyn=r*250;
% % % % % end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preload all the texture, so that we can calibrate different densities if
% necessary...
texindexes=zeros(11,100);
for densityindex = 1:17
disp(['...loading background density textures, ' num2str(densityindex) ' of 17'])
for i=1:100
    
    filename = ['supportfiles/background/BG' num2str(densityindex) '_' num2str(i)];
    load(filename);
    % backgtex=Screen('MakeTexture', win.Number, rectdyn(:,:,i));
    backgtex=Screen('MakeTexture', win.Number, variable);
    texindexes(densityindex,i)=backgtex;
end
end
% clear rectdyn randd r