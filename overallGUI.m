function overallGUI
    global dimensions precision xdist ydist zdist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm constant roomTemp elevatedTemp elevLocation thermal_Conductivity...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff ...
    materials thermal_Conductivity2 interfaceK density2 specific_heat2 distribution frequency2 ...
    extraConduction extraConvection extraRadiation;

    
    %%%%Defaults
    precision = 10;
    xdist = 0.2;
    ydist = 0.2;
    zdist = 0.2;
    dd = 0.005;
    total_time = 500;
    dt = 0.05;
    framerate = 500;
    Tm = 110; %Melting point
    specific_heat = 1900;
    density = 910; %kg/m^3
    thermal_Conductivity = 0.33;
    constant = thermal_Conductivity * dt / (density * specific_heat * dd * dd);
    borders = true;
    emissivity = 0.97;
    roomTemp = 0;
    elevatedTemp = 250;
    elevLocation = 1;
    elevFrequency = 12;
    absorption = 4;
    energyRate = 0;
    distributionFrequency = 12;
    timeOn = 0;
    timeOff = 500;
    convection = false;
    radiation = false;
    thermal_Conductivity2 = 0.33;
    interfaceK = 0.2;
    density2 = 1600;
    specific_heat2 = 4130;
    distribution = 1;
    frequency2 = 12;
    extraConduction = false;
    extraConvection = false;
    extraRadiation = false;
    %%%%%%%%%%%%
    
    
    f = figure('Visible', 'off','color','white','Position',...
    [360,500,200,200]);
    if isempty(dimensions)
        dimensions = 3;
    end
    if isempty(materials)
        materials = 1;
    end
    hsttext = uicontrol('Style','text','BackgroundColor','white','Position',[30,100,80,80],'String','Dimensions');
    huitext = uicontrol('Style','edit','Position',[50,100,40,40],'String',num2str(dimensions));
    hsttext2 = uicontrol('Style','text','BackgroundColor','white','Position',[100,100,80,80],'String','Materials');
    huitext2 = uicontrol('Style','pushbutton','Position',[90,100,100,40], 'Callback', @materialsButton);
    switch materials
            case 1
                set(huitext2,'String','1 Material');
            case 2
                set(huitext2,'String','2 Materials');
            case 3
                set(huitext2,'String', '1 Matrix, 1 Receiver');
    end
    
    set(f,'Name','Input Number of Dimensions Needed:')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Continue',...
        'Position',[40,40,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    
    function callbackfn(~,~)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        dimensions=str2double(get(huitext,'String'));
        close(gcf);
        if materials == 1
            distribution = 0;
            chooseSettings1;
        else
            chooseSettings2;
        end
        
    end

    function materialsButton(~,~)
        materials = materials + 1;
        if materials > 3
            materials = 1;
        end
        switch materials
            case 1
                set(huitext2,'String','1 Material');
            case 2
                set(huitext2,'String','2 Materials');
            case 3
                set(huitext2,'String', '1 Matrix, 1 Receiver');
        end
        
    end

end