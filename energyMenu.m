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
    global dimensions convection radiation thin bottomLoss emissivity convecc;
    if isempty(convection)
        convection = false;
    end
    if isempty(radiation)
        radiation = false;
    end
    if isempty(dimensions)
        dimensions = 3;
    end
    if isempty(thin)
        thin = false;
    end
    if isempty(bottomLoss)
        bottomLoss = (dimensions == 3);
    end
    if isempty(emissivity)
        emissivity = 0.1;
    end
    if isempty(convecc)
        convecc = 20;
    end
    
    f = figure('Visible', 'off','color','white','Position',[360,500,320,300]);
    
    

    convectionText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,190,120,80],'String','Convection');
    convectionButton = uicontrol('Style','pushbutton','Position',[20,210,80,40],...
    'String','Currently off','Callback',@callbackfn);
    
    radiationText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[170,190,120,80],'String','Radiation');
    radiationButton = uicontrol('Style','pushbutton','Position',[190,210,80,40],...
    'String','Currently off','Callback',@callbackfn);
    
    conveccText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,120,120,80],'String','Convection Constant');
    conveccEdit = uicontrol('Style','edit','Position',[20,140,80,40],...
    'String',num2str(convecc),'Callback',@editCall);

    emissivityText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[170,120,120,80],'String','Emissivity Constant');
    emissivityEdit = uicontrol('Style','edit','Position',[190,140,80,40],...
    'String',num2str(emissivity),'Callback',@editCall);

    thinText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[170,50,120,80],'String','Dissipation off unseen dimensions');
    thinButton = uicontrol('Style','pushbutton','Position',[190,50,80,40],...
    'String','Currently off','Callback',@callbackfn);
    if thin
        set(thinButton,'String','Currently on');
    end
    
    bottomText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,50,120,80],'String','Convection off Bottom?');
    bottomButton = uicontrol('Style','pushbutton','Position',[20,50,80,40],...
    'String','Currently off','Callback',@callbackfn);
    if bottomLoss
        set(bottomButton,'String','Currently on');
    end
    
    
    
    if dimensions > 2
        set(thinText,'Visible','off');
        set(thinButton,'Visible','off');
    end
    
    set(f,'Name','Energy Dissipation Options')
    movegui(f,'center')

    set(f,'Visible','on')
    
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
            case convectionButton
                convection = ~convection;
                if convection
                    set(convectionButton,'String','Currently on');
                    set(conveccText,'Visible','On');
                    set(conveccEdit,'Visible','On');
                else
                    set(convectionButton,'String','Currently off');
                    set(conveccText,'Visible','Off');
                    set(conveccEdit,'Visible','Off');
                end
            case radiationButton
                radiation = ~radiation;
                if radiation
                    set(radiationButton,'String','Currently on');
                    set(emissivityText,'Visible','On');
                    set(emissivityEdit,'Visible','On');
                else
                    set(radiationButton,'String','Currently off');
                    set(emissivityText,'Visible','Off');
                    set(emissivityEdit,'Visible','Off');
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

    function editCall(~,~)
        convecc = str2double(get(conveccEdit,'String'));
        emissivity = str2double(get(emissivityEdit,'String'));
    end
    
end
