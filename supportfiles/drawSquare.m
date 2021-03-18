%This script draws a flickering square in the bottom left corner.
%used to physically measure flicker with a photodiode.
bottomX = win.Rect(3) - win.Rect(1); %finds bottom of the screen
bottomY= win.Rect(4)- win.Rect(2);

sidelengthRect = 100; %pixels

baseRect = [0, bottomY-sidelengthRect sidelengthRect bottomY];


%if outside catch duration, then draw the square as oscillating black to
%white (same as target)

% if c_rampval>0
%     rectCol = [250 250 250];
%     flickerCol = rectCol.*(am1(frame)/2+0.5);
%     
% %     if flickerCol < 0
% %         flickerCol = [0 0 0];
% %     else
% %   


flickerCol = [250 250 250];
% %     end
% else %if we are inside the catch, probably easier to see when photodiode drops to black (not grey)
%     flickerCol = [ 0 0 0];
% end

flickerCol = [0 0 0];

Screen('FillRect', win.Number, flickerCol, baseRect);

Screen('TextSize', win.Number, 13);
%----
DrawFormattedText(win.Number, [num2str(waitframe(TL_index)) '  ' num2str(p.eccy) ' ' num2str(angle) '  ' ...
    num2str(waitframe(TR_index)) '\n  ' num2str((cir_size-1)*20+100) '  ' num2str(denindex*5+5) '%' '\n' ... 
    num2str(disccolour_R) ' '  num2str(disccolour_G) ' ' num2str(disccolour_B) '\n\n' ...
    num2str(waitframe(BL_index)) '            ' ...
    num2str(waitframe(BR_index))], 0,...
    bottomY-90, 255);

%-----

