%%
%% If we need to regenerate all the wedge images:
if ~exist([pwd filesep 'supportfiles' filesep 'wedge'], 'dir')
    mkdir([pwd filesep 'supportfiles' filesep 'wedge'])
end
%%
if (params.wedge_Prepare == 1)
    
    [x, y] = meshgrid(-win.Height/2:1:win.Height/2, win.Height/2:-1:-win.Height/2);
    [th, r] = cart2pol(x, y);
    
    Texture_TR = zeros(win.Height/2,win.Height/2,2);
    
    index = 1;
    %%
    for angle = 0.5:0.5:5
        
        theta1_L = (45-angle)/180*pi;
        theta1_H = (45+angle)/180*pi;

       
        
        for k = 1:100
            
            bwColors = randi([0 1],ceil(win.Height/2/10),ceil(win.Height/2/10))*255;
            
            for i = 0:win.Height/2-1
                for j = 0:win.Height/2-1
                    Texture_TR(i+1,j+1,1)=bwColors(floor(i/10)+1,floor(j/10)+1);
                    if (abs(th(i+1,j+win.Height/2+2))>=theta1_L)&&(abs(th(i+1,j+win.Height/2+2))<=theta1_H)
                        Texture_TR(i+1,j+1,2)= 255;
                    end

                end
            end

            Texture_TR(:,1:50,2) = 0;
            
            filename1 = ['supportfiles/wedge/TR_' num2str(index) '_' num2str(k)];
            
            save(filename1,'Texture_TR');
            
        end
         index = index + 1;
    end
    
    clear Texture_TR
    
end
%%

index = 1;

for angle = 0.5:0.5:5
    
    disp(['...loading wedge textures, ' num2str(index) ' of 10'])
        
    for k = 1:100    
        
        filename1 = ['supportfiles/wedge/TR_' num2str(index) '_' num2str(k)];
        
        load(filename1);
        
        wedgeTexture_TR(index,k) = Screen('MakeTexture', win.Number, Texture_TR);

    end
    
    index = index + 1;
end
 clear Texture_TR