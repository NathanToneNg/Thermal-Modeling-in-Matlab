%materialMenu: Opens a menu where the user may specify necessary constants
%for thermal calculations.
%
% Clarifications:
%   Conduction Constant is used in Newton's Law of Cooling
%
%   Radiation Emissivity is used in the Stefan-Boltzmann Law
%
%   All assumed units are seconds, meters, kilograms, Watts, and degrees Celcius
%       For example, density is expected to be provided in kg/m^3
function materialMenu
    global Tm specific_heat density thermal_Conductivity constant dt dd materials ...
        infinitex infinitey infinitez dimensions;
    if isempty(materials)
        materials = 1;
    end
    if isempty(dt)
        dt = 0.05;
    end
    if isempty(dd)
        dd = 0.005;
    end
    if isempty(infinitex)
        infinitex = false;
    end
    if isempty(infinitey)
        infinitey = false;
    end
    if isempty(infinitez)
        infinitez = false;
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
    
    TmText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[0,200,80,80],'String','Melting Point of the Material');
    TmEdit = uicontrol('Style','edit','Position',[20,200,40,40],...
        'String',num2str(Tm), 'Callback', @callbackfn);

    cText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[80,200,80,80],'String','Specific Heat');
    cEdit = uicontrol('Style','edit','Position',[100,200,40,40],...
        'String',num2str(specific_heat),...
        'Callback',@callbackfn);
    
    pText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[160,200,80,80],'String','Density');
    pEdit = uicontrol('Style','edit','Position',[180,200,40,40],...
        'String',num2str(density),...
        'Callback',@callbackfn);

    kText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[240,200,80,80],'String','Thermal Conductivity');
    kEdit = uicontrol('Style','edit','Position',[260,200,40,40],...
        'String',num2str(thermal_Conductivity),...
        'Callback',@callbackfn);

    constText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[120,100,80,80],'String','Conduction Constant');
    constShow = uicontrol('Style','text','Position',[120,110,80,40],...
        'String',num2str(constant),'BackgroundColor','white',...
        'Callback',@callbackfn);
    if dimensions == 3
        xinfText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[-5, 40, 120, 80], 'String', 'Infinite x-direction?');
    	xinfButton = uicontrol('Style','pushbutton','Position',[15, 60, 80, 40],...
        'Callback',@callbackfn);
        yinfText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[100, 40, 120, 80], 'String', 'Infinite y-direction?');
    	yinfButton = uicontrol('Style','pushbutton','Position',[120, 60, 80, 40],...
        'Callback',@callbackfn);
        zinfText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[205, 40, 120, 80], 'String', 'Infinite z-direction?');
    	zinfButton = uicontrol('Style','pushbutton','Position',[225, 60, 80, 40],...
        'Callback',@callbackfn);
        if infinitex
           set(xinfButton, 'string', 'On');
        else
            set(xinfButton, 'string', 'Off');
        end
        if infinitey
           set(yinfButton, 'string', 'On');
        else
            set(yinfButton, 'string', 'Off');
        end
        if infinitez
           set(zinfButton, 'string', 'On');
        else
            set(zinfButton, 'string', 'Off');
        end
    end

    set(f,'Name','Materials Variables')
    movegui(f,'center')
    set(f,'Visible','on')
    
    set(cText, 'Visible', 'on');
    set(cEdit, 'Visible', 'on');
    set(pText, 'Visible', 'on');
    set(pEdit, 'Visible', 'on');
    set(kText, 'Visible', 'on');
    set(kEdit, 'Visible', 'on');
        
    
    function callbackfn(hObject,~)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        Tm=str2double(get(TmEdit,'String'));
        specific_heat=str2double(get(cEdit,'String'));
        density = str2double(get(pEdit,'String'));
        thermal_Conductivity = str2double(get(kEdit,'String'));
        constant = thermal_Conductivity * dt / (density * specific_heat * dd * dd);
        set(constShow, 'String', num2str(constant));
        if hObject == xinfButton
            infinitex = ~infinitex;
            if infinitex
               set(xinfButton, 'string', 'On');
            else
                set(xinfButton, 'string', 'Off');
            end
        end
        if hObject == yinfButton
            infinitey = ~infinitey;
            if infinitey
               set(yinfButton, 'string', 'On');
            else
                set(yinfButton, 'string', 'Off');
            end
        end
        if hObject == zinfButton
            infinitez = ~infinitez;
            if infinitez
               set(zinfButton, 'string', 'On');
            else
                set(zinfButton, 'string', 'Off');
            end
        end
    end
    
end
