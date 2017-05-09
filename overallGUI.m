function overallGUI
    global dimensions precision xdist ydist zdist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm constant roomTemp elevatedTemp elevLocation thermal_Conductivity...
    elevFrequency absorption energyRate distributionFrequency emissivity;

    
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
    emissivity = 0.1;
    roomTemp = 0;
    elevatedTemp = 250;
    elevLocation = 1;
    elevFrequency = 12;
    absorption = 4;
    energyRate = 0;
    distributionFrequency = 12;
    convection = false;
    radiation = false;
    %%%%%%%%%%%%
    
    
    f = figure('Visible', 'off','color','white','Position',...
    [360,500,200,200]);
    if isempty(dimensions)
        dimensions = 3;
    end
    hsttext = uicontrol('Style','text','BackgroundColor','white','Position',[50,100,80,80],'String','Dimensions');
    huitext = uicontrol('Style','edit','Position',[70,100,40,40],'String',num2str(dimensions));
    set(f,'Name','Input Number of Dimensions Needed:')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Continue',...
        'Position',[40,40,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    
    function callbackfn(hObject,eventdata)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        dimensions=str2double(get(huitext,'String'));
        close(gcf);
        chooseSettings1;
        
    end

end