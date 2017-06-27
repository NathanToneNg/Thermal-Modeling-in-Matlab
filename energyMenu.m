%energyMenu: Opens a menu where the user can choose how energy is
%dissipated, through conduction, convection, and/or radiation.
%
% Energy Dissipation: 
%   Conduction on the Edges is usually turned off, except for in test 
%       cases and when the situation should be considered as 
%       connecting to a ?grounded? material at the room temperature.
%
%   Convection/Radiation off unseen directions are used in the 1D 
%   and 2D cases:
%       1D: This acts as if the setting given is a rectangular prism 
%           material of thickness given by dd (almost infinitely thin),
%           where the surroundings are all air and thus convection/
%           radiation occurs off all pixels in addition to sides
%
%       2D: This acts as if the setting given is a flat material of 
%           thickness given by dd (almost infinitely thin), where the 
%           3rd dimension (top and bottom) are air above and below, 
%           and thus convection/radiation occurs off all pixels in 
%           addition to sides.
%
%   The same process is for both 1D and 2D, but twice as impactful for 1D.
function energyMenu
    global dimensions borders convection radiation extraConduction thin bottomLoss;
    if isempty(borders)
        borders = true;
    end
    if isempty(convection)
        convection = false;
    end
    if isempty(radiation)
        radiation = false;
    end
    if isempty(dimensions)
        dimensions = 3;
    end
    if isempty(extraConduction)
        extraConduction = false;
    end
    if isempty(thin)
        thin = false;
    end
    if isempty(bottomLoss)
        bottomLoss = (dimensions == 3);
    end
    
    f = figure('Visible', 'off','color','white','Position',[360,500,320,300]);
    
    
    bordersText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,190,150,80],'String','No conduction off edges');
    bordersButton = uicontrol('Style','pushbutton','Position',[20,210,80,40],...
    'String','Currently on','Callback',@callbackfn);

    convectionText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[20,110,80,80],'String','Convection');
    convectionButton = uicontrol('Style','pushbutton','Position',[20,130,80,40],...
    'String','Currently off','Callback',@callbackfn);
    
    radiationText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[20,30,80,80],'String','Radiation');
    radiationButton = uicontrol('Style','pushbutton','Position',[20,50,80,40],...
    'String','Currently off','Callback',@callbackfn);
    

    conductionOff = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[170,200,120,80],'String','Conduction off unseen dimensions');
    conductionOffB = uicontrol('Style','pushbutton','Position',[190,210,80,40],...
    'String','Currently off','Callback',@callbackfn);
    if extraConduction
        set(conductionOffB,'String','Currently on');
    end

    thinText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[170,120,120,80],'String','Dissipation off unseen dimensions');
    thinButton = uicontrol('Style','pushbutton','Position',[190,130,80,40],...
    'String','Currently off','Callback',@callbackfn);
    if thin
        set(thinButton,'String','Currently on');
    end
    
    bottomText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[170,30,120,80],'String','Dissipation off Bottom?');
    bottomButton = uicontrol('Style','pushbutton','Position',[190,50,80,40],...
    'String','Currently off','Callback',@callbackfn);
    if bottomLoss
        set(bottomButton,'String','Currently on');
    end
    
    
    
    if dimensions > 2
        set(conductionOff,'Visible','off');
        set(conductionOffB,'Visible','off');
        set(thinText,'Visible','off');
        set(thinButton,'Visible','off');
    end
    
    set(f,'Name','Energy Dissipation Options')
    movegui(f,'center')

    set(f,'Visible','on')
    
    if borders
        set(bordersButton,'String','Currently on');
        if dimensions < 3
            set(conductionOff,'Visible','off');
            set(conductionOffB,'Visible','off');
        end
    else
        set(bordersButton,'String','Currently off');
        if dimensions < 3
            set(conductionOff,'Visible','on');
            set(conductionOffB,'Visible','on');
        end
    end
    if convection
        set(convectionButton,'String','Currently on');
        if dimensions < 3
            set(thinText,'Visible','on');
            set(thinButton,'Visible','on');
        end
    else
        set(thinButton,'String','Currently off');
        if dimensions < 3
            set(thinText,'Visible','off');
            set(thinButton,'Visible','off');
        end
    end
    if radiation
        set(radiationButton,'String','Currently on');
    else
        set(radiationButton,'String','Currently off');
    end
    if dimensions < 3
        if convection || radiation
            set(thinButton,'Visible','On');
            set(thinText,'Visible','On');
        else
            set(thinButton,'Visible','Off');
            set(thinText,'Visible','Off');
        end
    end
    if (convection) && (dimensions == 3 || thin)
        set(bottomText,'Visible','On');
        set(bottomButton, 'Visible','On');
    else
        set(bottomText,'Visible','Off');
        set(bottomButton, 'Visible','Off');
    end
    
    function callbackfn(hObject,~)
        switch hObject
            case bordersButton
                borders = ~borders;
                if borders
                    set(bordersButton,'String','Currently on');
                    if dimensions < 3
                        set(conductionOff,'Visible','off');
                        set(conductionOffB,'Visible','off');
                    end
                else
                    set(bordersButton,'String','Currently off');
                    if dimensions < 3
                        set(conductionOff,'Visible','on');
                        set(conductionOffB,'Visible','on');
                    end
                end
            case convectionButton
                convection = ~convection;
                if convection
                    set(convectionButton,'String','Currently on');
                else
                    set(convectionButton,'String','Currently off');
                end
            case radiationButton
                radiation = ~radiation;
                if radiation
                    set(radiationButton,'String','Currently on');
                else
                    set(radiationButton,'String','Currently off');
                end
            case conductionOffB
                extraConduction = ~extraConduction;
                if extraConduction
                    set(conductionOffB,'String','Currently on');
                else
                    set(conductionOffB,'String','Currently off');
                end
            case thinButton
                thin = ~thin;
                if thin
                    set(thinButton,'String','Currently on');
                else
                    set(thinButton,'String','Currently off');
                end
            case bottomButton
                bottomLoss = ~bottomLoss;
                if bottomLoss
                    set(bottomButton,'String','Currently on');
                else
                    set(bottomButton,'String','Currently off');
                end
        end
        if dimensions < 3
            if convection || radiation
                set(thinButton,'Visible','On');
                set(thinText,'Visible','On');
            else
                set(thinButton,'Visible','Off');
                set(thinText,'Visible','Off');
            end
        end
        if (convection) && (dimensions == 3 || thin)
            set(bottomText,'Visible','On');
            set(bottomButton, 'Visible','On');
        else
            set(bottomText,'Visible','Off');
            set(bottomButton, 'Visible','Off');
        end
    end
    
end
