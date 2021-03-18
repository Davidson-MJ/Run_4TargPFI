%Code by Chunkai Qiu
%% If we need to regenerate all the background images:
if ~exist([pwd filesep 'supportfiles' filesep 'circle'], 'dir')
    mkdir([pwd filesep 'supportfiles' filesep 'circle'])
end

if (params.Circle_Prepare == 1)
    
    MyTargetTexture=zeros(100,1);
    
    counter =1;
    for imSize = 100:20:200                          % image size: n X n
        disp(['... preparing disc target sizes ' num2str(counter) ' of 6'])
        [X,Y]=meshgrid(1:imSize/10+1);
        gaussSD=25;
        xx=normpdf(X,(imSize/10+1)/2,gaussSD);
        yy=normpdf(Y,(imSize/10+1)/2,gaussSD);
        gauss=xx.*yy;
        gauss=gauss/max(gauss(:));
        
        mid_gauss = gauss(round(imSize/10/2+1),1);
        
        for j = 1:imSize/10+1
            for k = 1:imSize/10+1
                if gauss(j,k) >=mid_gauss;
                    gauss(j,k)=1;
                else
                    gauss(j,k)=0;
                end
            end
        end
        
        for j = 0:imSize-1
            for k = 0:imSize-1
                newgauss(j+1,k+1,1)=gauss(floor(j/10)+1,floor(k/10)+1);
            end
        end
        
        for i = 1:100
            
            bwColors = randi([0 1],ceil(imSize/10),ceil(imSize/10))*255;
            
            for j = 0:imSize-1
                for k = 0:imSize-1
                    Texture(j+1,k+1,1)=bwColors(floor(j/10)+1,floor(k/10)+1);
                end
            end
            
            Texture(:,:,2) = newgauss*255;
            
            filename = ['supportfiles/circle/CL_' num2str(imSize) '_' num2str(i)];
            save(filename,'Texture');
            
        end
        counter=counter+1
    end
end

index = 1;

for imSize = 100:20:200                           % image size: n X n
    disp(['...loading image size textures, ' num2str(index) ' of 6'])
    
    
    for i = 1:100
        
        filename = ['supportfiles/circle/CL_' num2str(imSize) '_' num2str(i)];
        load(filename);
        checkerTexture = Screen('MakeTexture', win.Number, Texture);
        MyTargetTexture(index,i) = checkerTexture;
    end
    index=index+1;
end


