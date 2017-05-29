function temperatureMenu
    global roomTemp elevatedTemp elevLocation elevFrequency absorption energyRate ...
    distributionFrequency timeOn timeOff total_time materials;
    if isempty(materials)
        materials = 3;
    end
    if materials == 3
        absorption = 7;
    end
    if isempty(roomTemp)
        roomTemp = 0;
    end
    if isempty(elevatedTemp)
        elevatedTemp = 250;
    end
    if isempty(elevLocation)
        elevLocation = 1;
    end
    if isempty(elevFrequency)
        elevFrequency = 12;
    end
    if isempty(absorption)
        absorption = 4;
    end
    if isempty(energyRate)
        energyRate = 20;
    end
    if isempty(distributionFrequency)
        distributionFrequency = 12;
    end
    if isempty(timeOn)
        timeOn = 0;
    end
    if isempty(timeOff)
        timeOff = total_time;
    end
    % guiMultiplierIf has 2 edit boxes for numbers and
    % multiplies them
    % Format: guiMultiplierIf or guiMultiplierIf()
    f = figure('Visible', 'off','color','white','Position',...
    [360,500,360,500]);

    
    hsttext = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,400,80,80],'String','Initial Room Temperature');
    huitext = uicontrol('Style','edit','Position',[20,400,40,40],...
    'String',num2str(roomTemp),'Callback',@callbackfn);

    hsttext2 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[20,340,100,40],'String','Initial Higher Temperature');
    huitext2 = uicontrol('Style','pushbutton','Position',[20,300,100,40],...
    'String','Middle: Single Point',...
    'Callback',@highTempOpts);
    
    hsttext3 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[140,300,80,80],'String','What is the Elevated Temperature');
    huitext3 = uicontrol('Style','edit','Position',[160,300,40,40],...
    'String',num2str(elevatedTemp),...
    'Callback',@callbackfn);

    hsttext10 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[220,300,80,80],'String','Frequency of Elevated Temperature');
    huitext10 = uicontrol('Style','edit','Position',[240,300,40,40],...
    'String',num2str(elevFrequency),...
    'Callback',@callbackfn);

    hsttext4 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[140,200,100,80],'String','Energy Absorption Rate (Power/ Watts)');
    huitext4 = uicontrol('Style','edit','Position',[160,200,40,40],...
    'String',num2str(energyRate),...
    'Callback',@callbackfn);

    hsttext5 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[240,200,80,80],'String','Density of Energy Receptors');
    huitext5 = uicontrol('Style','edit','Position',[260,200,40,40],...
    'String',num2str(distributionFrequency),...
    'Callback',@callbackfn);
    if materials == 3
        set(huitext5,'Visible','off');
        set(hsttext5,'Visible','off');
    end

    hsttext20 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[150,100,80,80], 'String','Time Absorption On');
    huitext20 = uicontrol('Style','edit','Position',[160,100,40,40],...
    'String',num2str(timeOn),...
    'Callback',@callbackfn);

    hsttext21 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[240,100,80,80], 'String','Time Absorption Off');
    huitext21 = uicontrol('Style','edit','Position',[260,100,40,40],...
    'String',num2str(timeOff),...
    'Callback',@callbackfn);
    
%     buttontext1 = uicontrol('Style','text','BackgroundColor','white',...
%     'Position',[0,300,120,80],'String','Initial Elevated Temperature'); %#ok<*NASGU>
%     button1 = uicontrol('Style','pushbutton','Position',[20,300,80,40],...
%     'String','Currently On','Callback',@button1call);
    
    buttontext2 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[10,200,120,80],'String','Energy Receivers Present'); 
    button2 = uicontrol('Style','pushbutton','Position',[10,210,120,40],...
    'String','Off','Callback',@button2call);

    set(f,'Name','Temperature Menu')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Set values',...
        'Position',[107.5,50,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    

    switch elevLocation
            case 1
                set(huitext2,'String','Middle: Single Point');
                set(huitext3,'Visible','on');
                set(hsttext3,'Visible','on');
                set(huitext10,'Visible','off');
                set(hsttext10,'Visible','off');
            case 2
                set(huitext2,'String','Middle Block');
                set(huitext3,'Visible','on');
                set(hsttext3,'Visible','on');
                set(huitext10,'Visible','off');
                set(hsttext10,'Visible','off');
            case 3
                set(huitext2,'String','Spread');
                set(huitext3,'Visible','on');
                set(hsttext3,'Visible','on');
                set(huitext10,'Visible','on');
                set(hsttext10,'Visible','on');
            case 4
                set(huitext2,'String','Off');
                set(huitext3,'Visible','off');
                set(hsttext3,'Visible','off');
                set(huitext10,'Visible','off');
                set(hsttext10,'Visible','off');
    end
    switch absorption
            case 1
                set(button2, 'String','Middle: Single Point');
                set(huitext4,'Visible','on');
                set(hsttext4,'Visible','on');
                if materials ~= 3
                    set(huitext5,'Visible','off');
                    set(hsttext5,'Visible','off');
                end
                set(huitext20,'Visible','on');
                set(hsttext20,'Visible','on');
                set(huitext21,'Visible','on');
                set(hsttext21,'Visible','on');
            case 2
                set(button2, 'String','Middle Block');
                set(huitext4,'Visible','on');
                set(hsttext4,'Visible','on');
                if materials ~= 3
                    set(huitext5,'Visible','off');
                    set(hsttext5,'Visible','off');
                end
                set(huitext20,'Visible','on');
                set(hsttext20,'Visible','on');
                set(huitext21,'Visible','on');
                set(hsttext21,'Visible','on');
            case 3
                set(button2, 'String','Uniform Distribution');
                if materials ~= 3
                    set(huitext5,'Visible','on');
                    set(hsttext5,'Visible','on');
                end
                set(huitext4,'Visible','on');
                set(hsttext4,'Visible','on');
                set(huitext20,'Visible','on');
                set(hsttext20,'Visible','on');
                set(huitext21,'Visible','on');
                set(hsttext21,'Visible','on');
            case 4
                set(button2, 'String','Random Distribution');
                if materials ~= 3
                    set(huitext5,'Visible','on');
                    set(hsttext5,'Visible','on');
                end
                set(huitext4,'Visible','on');
                set(hsttext4,'Visible','on');
                set(huitext20,'Visible','on');
                set(hsttext20,'Visible','on');
                set(huitext21,'Visible','on');
                set(hsttext21,'Visible','on');
            case 5
                set(button2, 'String','Random Spheres');
                if materials ~= 3
                    set(huitext5,'Visible','on');
                    set(hsttext5,'Visible','on');
                end
                set(huitext4,'Visible','on');
                set(hsttext4,'Visible','on');
                set(huitext20,'Visible','on');
                set(hsttext20,'Visible','on');
                set(huitext21,'Visible','on');
                set(hsttext21,'Visible','on');
            case 6
                set(button2, 'String','Off');
                set(huitext4,'Visible','off');
                set(hsttext4,'Visible','off');
                if materials ~= 3
                    set(huitext5,'Visible','off');
                    set(hsttext5,'Visible','off');
                end
                set(huitext20,'Visible','off');
                set(hsttext20,'Visible','off');
                set(huitext21,'Visible','off');
                set(hsttext21,'Visible','off');
        case 7
                if materials == 3
                    set(button2, 'String', 'Located at 2nd Material');
                else
                    set(hsttext5,'Visible','on');
                end
                set(huitext4,'Visible','on');
                set(hsttext4,'Visible','on');
                set(huitext20,'Visible','on');
                set(hsttext20,'Visible','on');
                set(huitext21,'Visible','on');
                set(hsttext21,'Visible','on');
            
    end
    
    function callbackfn(~,~)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        roomTemp=str2double(get(huitext,'String'));
        elevatedTemp=str2double(get(huitext3,'String'));
        elevFrequency = str2double(get(huitext10,'String'));
        energyRate = str2double(get(huitext4,'String'));
        distributionFrequency = str2double(get(huitext5,'String'));
        timeOn = str2double(get(huitext20,'String'));
        timeOff = str2double(get(huitext21,'String'));
    end
    

    function button2call(~, ~)
        if materials ~= 3
            absorption = absorption + 1;
            if absorption > 6
                absorption = 1;
            end
            switch absorption
                case 1
                    set(button2, 'String','Middle: Single Point');
                    set(huitext4,'Visible','on');
                    set(hsttext4,'Visible','on');
                    set(huitext20,'Visible','on');
                    set(hsttext20,'Visible','on');
                    set(huitext21,'Visible','on');
                    set(hsttext21,'Visible','on');
                case 2
                    set(button2, 'String','Middle Block');
                case 3
                    set(button2, 'String','Uniform Distribution');
                    if materials ~= 3
                        set(huitext5,'Visible','on');
                        set(hsttext5,'Visible','on');
                    end
                case 4
                    set(button2, 'String','Random Distribution');
                case 5
                    set(button2, 'String','Random Spheres');
                case 6
                    set(button2, 'String','Off');
                    set(huitext4,'Visible','off');
                    set(hsttext4,'Visible','off');
                    if materials ~= 3
                        set(huitext5,'Visible','off');
                        set(hsttext5,'Visible','off');
                    end
                    set(huitext20,'Visible','off');
                    set(hsttext20,'Visible','off');
                    set(huitext21,'Visible','off');
                    set(hsttext21,'Visible','off');
            end
        end
    end

    function highTempOpts(~, ~)
        elevLocation = elevLocation + 1;
        if elevLocation > 4
            elevLocation = 1;
        end
        switch elevLocation
            case 1
                set(huitext2,'String','Middle: Single Point');
                set(huitext3,'Visible','on');
                set(hsttext3,'Visible','on');
            case 2
                set(huitext2,'String','Middle Block');
            case 3
                set(huitext2,'String','Spread');
                set(huitext10,'Visible','on');
                set(hsttext10,'Visible','on');
            case 4
                set(huitext2,'String','Off');
                set(huitext3,'Visible','off');
                set(hsttext3,'Visible','off');
                set(huitext10,'Visible','off');
                set(hsttext10,'Visible','off');
        end

    end
end
