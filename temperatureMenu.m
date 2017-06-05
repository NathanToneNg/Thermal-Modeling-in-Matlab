function temperatureMenu
    global roomTemp elevatedTemp elevLocation elevFrequency absorption energyRate ...
    distributionFrequency timeOn timeOff total_time materials cycle cycleIntervals cycleSpeed;
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
    if isempty(cycle)
        cycle = 1;
    end
    if isempty(cycleIntervals)
        cycleIntervals = 20;
    end
    if isempty(cycleSpeed)
        cycleSpeed = 20;
    end

    
    f = figure('Visible', 'off','color','white','Position',...
    [360,500,360,500]);
    
    roomTempText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,400,80,80],'String','Initial Room Temperature');
    roomTempBar = uicontrol('Style','edit','Position',[20,400,40,40],...
    'String',num2str(roomTemp),'Callback',@callbackfn);

    elevTempText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[90,440,100,40],'String','Initial Higher Temperature');
    elevTempBar = uicontrol('Style','pushbutton','Position',[90,400,100,40],...
    'String','Middle: Single Point',...
    'Callback',@highTempOpts);
    
    elevTempAmountText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[190,410,80,80],'String','What is the Elevated Temperature');
    elevTempAmountEdit = uicontrol('Style','edit','Position',[210,400,40,40],...
    'String',num2str(elevatedTemp),...
    'Callback',@callbackfn);

    elevFreqText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[260,410,80,80],'String','Frequency of Elevated Temperature');
    elevFreqEdit = uicontrol('Style','edit','Position',[280,400,40,40],...
    'String',num2str(elevFrequency),...
    'Callback',@callbackfn);

    energyRateText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[140,300,100,80],'String','Energy Absorption Rate (Power/ Watts)');
    energyRateEdit = uicontrol('Style','edit','Position',[160,300,40,40],...
    'String',num2str(energyRate),...
    'Callback',@callbackfn);

    receptorDensityText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[240,300,80,80],'String','Density of Energy Receptors');
    receptorDensityEdit = uicontrol('Style','edit','Position',[260,300,40,40],...
    'String',num2str(distributionFrequency),...
    'Callback',@callbackfn);
    if materials == 3
        set(receptorDensityEdit,'Visible','off');
        set(receptorDensityText,'Visible','off');
    end

    absorptionOnText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[150,200,80,80], 'String','Time Absorption On');
    absorptionOnBar = uicontrol('Style','edit','Position',[160,200,40,40],...
    'String',num2str(timeOn),...
    'Callback',@callbackfn);

    absorptionOffText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[240,200,80,80], 'String','Time Absorption Off');
    absorptionOffBar = uicontrol('Style','edit','Position',[260,200,40,40],...
    'String',num2str(timeOff),...
    'Callback',@callbackfn);
    
    receiverButtonText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[10,300,120,80],'String','Energy Receivers Present'); 
    receiverButton = uicontrol('Style','pushbutton','Position',[10,310,120,40],...
    'String','Off','Callback',@button2call);

    cycleText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[10,120,120,60],'String','Time distribution'); 
    cycleButton = uicontrol('Style','pushbutton','Position',[10,120,120,40],...
    'Callback',@cycleButtonFunc);

    cycleIntervalsText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[140,140,80,50],'String','Number of intervals in cycle'); 
    cycleIntervalsEdit = uicontrol('Style','edit','Position',[160,120,40,40],...
    'String',num2str(cycleIntervals),'Callback',@callbackfn);

    cycleSpeedText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[220,150,120,40],'String','Speed of whole rotation (in seconds)'); 
    cycleSpeedEdit = uicontrol('Style','edit','Position',[260,120,40,40],...
    'String',num2str(cycleSpeed),'Callback',@callbackfn);

    set(f,'Name','Temperature Menu')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Set values',...
        'Position',[107.5,50,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    

    switch elevLocation
            case 1
                set(elevTempBar,'String','Middle: Single Point');
                set(elevTempAmountEdit,'Visible','on');
                set(elevTempAmountText,'Visible','on');
                set(elevFreqEdit,'Visible','off');
                set(elevFreqText,'Visible','off');
            case 2
                set(elevTempBar,'String','Middle Block');
                set(elevTempAmountEdit,'Visible','on');
                set(elevTempAmountText,'Visible','on');
                set(elevFreqEdit,'Visible','off');
                set(elevFreqText,'Visible','off');
            case 3
                set(elevTempBar,'String','Spread');
                set(elevTempAmountEdit,'Visible','on');
                set(elevTempAmountText,'Visible','on');
                set(elevFreqEdit,'Visible','on');
                set(elevFreqText,'Visible','on');
            case 4
                set(elevTempBar,'String','Off');
                set(elevTempAmountEdit,'Visible','off');
                set(elevTempAmountText,'Visible','off');
                set(elevFreqEdit,'Visible','off');
                set(elevFreqText,'Visible','off');
    end
    switch absorption
            case 1
                set(receiverButton, 'String','Middle: Single Point');
                set(energyRateEdit,'Visible','on');
                set(hsttext4,'Visible','on');
                if materials ~= 3
                    set(receptorDensityEdit,'Visible','off');
                    set(receptorDensityText,'Visible','off');
                end
                set(absorptionOnBar,'Visible','on');
                set(absorptionOnText,'Visible','on');
                set(absorptionOffBar,'Visible','on');
                set(absorptionOffText,'Visible','on');
            case 2
                set(receiverButton, 'String','Middle Block');
                set(energyRateEdit,'Visible','on');
                set(energyRateText,'Visible','on');
                if materials ~= 3
                    set(receptorDensityEdit,'Visible','off');
                    set(receptorDensityText,'Visible','off');
                end
                set(absorptionOnBar,'Visible','on');
                set(absorptionOnText,'Visible','on');
                set(absorptionOffBar,'Visible','on');
                set(absorptionOffText,'Visible','on');
            case 3
                set(receiverButton, 'String','Uniform Distribution');
                if materials ~= 3
                    set(receptorDensityEdit,'Visible','on');
                    set(receptorDensityText,'Visible','on');
                end
                set(energyRateEdit,'Visible','on');
                set(energyRateText,'Visible','on');
                set(absorptionOnBar,'Visible','on');
                set(absorptionOnText,'Visible','on');
                set(absorptionOffBar,'Visible','on');
                set(absorptionOffText,'Visible','on');
            case 4
                set(receiverButton, 'String','Random Distribution');
                if materials ~= 3
                    set(receptorDensityEdit,'Visible','on');
                    set(receptorDensityText,'Visible','on');
                end
                set(energyRateEdit,'Visible','on');
                set(energyRateText,'Visible','on');
                set(absorptionOnBar,'Visible','on');
                set(absorptionOnText,'Visible','on');
                set(absorptionOffBar,'Visible','on');
                set(absorptionOffText,'Visible','on');
            case 5
                set(receiverButton, 'String','Random Spheres');
                if materials ~= 3
                    set(receptorDensityEdit,'Visible','on');
                    set(receptorDensityText,'Visible','on');
                end
                set(energyRateEdit,'Visible','on');
                set(energyRateText,'Visible','on');
                set(absorptionOnBar,'Visible','on');
                set(absorptionOnText,'Visible','on');
                set(absorptionOffBar,'Visible','on');
                set(absorptionOffText,'Visible','on');
            case 6
                set(receiverButton, 'String','Off');
                set(energyRateEdit,'Visible','off');
                set(energyRateText,'Visible','off');
                if materials ~= 3
                    set(receptorDensityEdit,'Visible','off');
                    set(receptorDensityText,'Visible','off');
                end
                set(absorptionOnBar,'Visible','off');
                set(absorptionOnText,'Visible','off');
                set(absorptionOffBar,'Visible','off');
                set(absorptionOffText,'Visible','off');
        case 7
                if materials == 3
                    set(receiverButton, 'String', 'Located at 2nd Material');
                else
                    set(receptorDensityText,'Visible','on');
                end
                set(energyRateEdit,'Visible','on');
                set(energyRateText,'Visible','on');
                set(absorptionOnBar,'Visible','on');
                set(absorptionOnText,'Visible','on');
                set(absorptionOffBar,'Visible','on');
                set(absorptionOffText,'Visible','on');
            
    end
    
    switch cycle
        case 1
            set(cycleButton, 'String','Constant');
            set(cycleIntervalsText,'Visible','off');
            set(cycleIntervalsEdit,'Visible','off');
            set(cycleSpeedText,'Visible','off');
            set(cycleSpeedEdit,'Visible','off');
        case 2
            set(cycleButton, 'String','All cycle; Middle');
            set(cycleIntervalsText,'Visible','on');
            set(cycleIntervalsEdit,'Visible','on');
            set(cycleSpeedText,'Visible','on');
            set(cycleSpeedEdit,'Visible','on');
        case 3
            set(cycleButton, 'String','All cycle; High');
            set(cycleIntervalsText,'Visible','on');
            set(cycleIntervalsEdit,'Visible','on');
            set(cycleSpeedText,'Visible','on');
            set(cycleSpeedEdit,'Visible','on');
        case 4
            set(cycleButton, 'String','Rotation; Middle');
            set(cycleIntervalsText,'Visible','on');
            set(cycleIntervalsEdit,'Visible','on');
            set(cycleSpeedText,'Visible','on');
            set(cycleSpeedEdit,'Visible','on');
        case 5
            set(cycleButton, 'String','Rotation, High');
            set(cycleIntervalsText,'Visible','on');
            set(cycleIntervalsEdit,'Visible','on');
            set(cycleSpeedText,'Visible','on');
            set(cycleSpeedEdit,'Visible','on');
        
    end
    
    function callbackfn(~,~)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        roomTemp=str2double(get(roomTempBar,'String'));
        elevatedTemp=str2double(get(elevTempAmountEdit,'String'));
        elevFrequency = str2double(get(elevFreqEdit,'String'));
        energyRate = str2double(get(energyRateEdit,'String'));
        distributionFrequency = str2double(get(receptorDensityEdit,'String'));
        timeOn = str2double(get(absorptionOnBar,'String'));
        timeOff = str2double(get(absorptionOffBar,'String'));
        cycleIntervals = str2double(get(cycleIntervalsEdit,'String'));
        cycleSpeed = str2double(get(cycleSpeedEdit,'String'));
    end
    

    function button2call(~, ~)
        if materials ~= 3
            absorption = absorption + 1;
            if absorption > 6
                absorption = 1;
            end
            switch absorption
                case 1
                    set(receiverButton, 'String','Middle: Single Point');
                    set(energyRateEdit,'Visible','on');
                    set(energyRateText,'Visible','on');
                    set(absorptionOnBar,'Visible','on');
                    set(absorptionOnText,'Visible','on');
                    set(absorptionOffBar,'Visible','on');
                    set(absorptionOffText,'Visible','on');
                case 2
                    set(receiverButton, 'String','Middle Block');
                case 3
                    set(receiverButton, 'String','Uniform Distribution');
                    if materials ~= 3
                        set(receptorDensityEdit,'Visible','on');
                        set(receptorDensityText,'Visible','on');
                    end
                case 4
                    set(receiverButton, 'String','Random Distribution');
                case 5
                    set(receiverButton, 'String','Random Spheres');
                case 6
                    set(receiverButton, 'String','Off');
                    set(energyRateEdit,'Visible','off');
                    set(energyRateText,'Visible','off');
                    if materials ~= 3
                        set(receptorDensityEdit,'Visible','off');
                        set(receptorDensityText,'Visible','off');
                    end
                    set(absorptionOnBar,'Visible','off');
                    set(absorptionOnText,'Visible','off');
                    set(absorptionOffBar,'Visible','off');
                    set(absorptionOffText,'Visible','off');
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
                set(elevTempBar,'String','Middle: Single Point');
                set(elevTempAmountEdit,'Visible','on');
                set(elevTempAmountText,'Visible','on');
            case 2
                set(elevTempBar,'String','Middle Block');
            case 3
                set(elevTempBar,'String','Spread');
                set(elevFreqEdit,'Visible','on');
                set(elevFreqText,'Visible','on');
            case 4
                set(elevTempBar,'String','Off');
                set(elevTempAmountEdit,'Visible','off');
                set(elevTempAmountText,'Visible','off');
                set(elevFreqEdit,'Visible','off');
                set(elevFreqText,'Visible','off');
        end

    end

    function cycleButtonFunc(~, ~)
            cycle = cycle + 1; %Constant, All cycle middle, All cycle high, Rotation Middle, rotation high
            if cycle > 5
                cycle = 1;
            end
            switch cycle
                case 1
                    set(cycleButton, 'String','Constant');
                    set(cycleIntervalsText,'Visible','off');
                    set(cycleIntervalsEdit,'Visible','off');
                    set(cycleSpeedText,'Visible','off');
                    set(cycleSpeedEdit,'Visible','off');
                case 2
                    set(cycleButton, 'String','All cycle; Middle'); %All cycle together, High point is energyRate
                    set(cycleIntervalsText,'Visible','on');
                    set(cycleIntervalsEdit,'Visible','on');
                    set(cycleSpeedText,'Visible','on');
                    set(cycleSpeedEdit,'Visible','on');
                case 3
                    set(cycleButton, 'String','All cycle; High'); %All cycle together, High point is 2 times eneryRate
                case 4
                    set(cycleButton, 'String','Rotation; Middle');
                case 5
                    set(cycleButton, 'String','Rotation; High');
            end
    end
end
