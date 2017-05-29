function materialMenu
    global Tm specific_heat density thermal_Conductivity constant dt dd emissivity materials;
    if isempty(materials)
        materials = 1;
    end
    if isempty(emissivity)
        emissivity = 0.1;
    end
    if isempty(dt)
        dt = 0.05;
    end
    if isempty(dd)
        dd = 0.005;
    end

    % guiMultiplierIf has 2 edit boxes for numbers and
    % multiplies them
    % Format: guiMultiplierIf or guiMultiplierIf()
    f = figure('Visible', 'off','color','white','Position',...
    [360,500,320,300]);
    if isempty(Tm)
        Tm=110; 
    end
    if isempty(specific_heat)
        specific_heat = 1900;
    end
    if isempty(density)
        density = 910;
    end
    if isempty(thermal_Conductivity)
        thermal_Conductivity = 0.33;
    end
    if isempty(constant)
        constant = thermal_Conductivity * dt / (density * specific_heat * dd * dd);
    end
    
    hsttext = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,200,80,80],'String','Melting Point of the Material');
    huitext = uicontrol('Style','edit','Position',[20,200,40,40],...
    'String',num2str(Tm));

    hsttext2 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[80,200,80,80],'String','Specific Heat');
    huitext2 = uicontrol('Style','edit','Position',[100,200,40,40],...
    'String',num2str(specific_heat),...
    'Callback',@callbackfn);
    
    hsttext3 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[160,200,80,80],'String','Density');
    huitext3 = uicontrol('Style','edit','Position',[180,200,40,40],...
    'String',num2str(density),...
    'Callback',@callbackfn);

    hsttext4 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[240,200,80,80],'String','Thermal Conductivity');
    huitext4 = uicontrol('Style','edit','Position',[260,200,40,40],...
    'String',num2str(thermal_Conductivity),...
    'Callback',@callbackfn);

    hsttext5 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[120,100,80,80],'String','Conduction Constant');
        huitext5 = uicontrol('Style','text','Position',[120,110,80,40],...
        'String',num2str(constant),'BackgroundColor','white',...
        'Callback',@callbackfn);
    

    hsttext7 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[210,100,100,80],'String','Radiation Emissivity Constant');
    huitext7 = uicontrol('Style','edit','Position',[240,110,40,40],...
    'String',num2str(emissivity));

    set(f,'Name','Materials Variables')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Set values',...
        'Position',[107.5,50,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    
            set(hsttext2, 'Visible', 'on');
            set(huitext2, 'Visible', 'on');
            set(hsttext3, 'Visible', 'on');
            set(huitext3, 'Visible', 'on');
            set(hsttext4, 'Visible', 'on');
            set(huitext4, 'Visible', 'on');
        
    
    function callbackfn(hObject,eventdata)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        Tm=str2double(get(huitext,'String'));
        specific_heat=str2double(get(huitext2,'String'));
        density = str2double(get(huitext3,'String'));
        thermal_Conductivity = str2double(get(huitext4,'String'));
        emissivity = str2double(get(huitext7,'String'));
        constant = thermal_Conductivity * dt / (density * specific_heat * dd * dd);
        set(huitext5, 'String', num2str(constant));
    end
    
end
