%material2Menu: Opens a menu where the user can specify constants for the second material
%necessary for thermal calculations.
%
% Clarifications:
%   Conduction Constant is used in Newton's Law of Cooling
%
%   Radiation Emissivity is used in the Stefan-Boltzmann Law
%
%   All assumed units are seconds, meters, kilograms, Watts, and degrees Celcius
%       For example, density is expected to be provided in kg/m^3
%
%   Thermal Conductivity on interface between materials is the second
%       conductivity box, and usually lies in value between the two individual
%       Thermal conductivities.
%
%
% Distribution (For both 2nd Material and/or Energy Receptors)
%	Center Pixel: Only the single pixel in the center of the grid
%
%   Center Block: With the center at the middle, a line/square/cube covering a 
%       5th of the total dimension (a 10th out from the center in each direction)
%
%   Uniform Distribution: 1 out of every (input) pixels become the second 
%       material/receptor, by taking the nth root and rounding.
%
%   Random Distribution: 1 out of every (input) pixels become the second 
%       material/ receptor, by randomly finding unselected spots and filling 
%       until the ratio is fulfilled.
%   Random Spheres: 1 out of every (input) pixels become the second 
%       material/ receptor, by randomly finding a radius within the remainder 
%       of needed pixels, and then picking a random unselected spot. The 
%       process is repeated until the ratio is fulfilled.
function material2Menu
    global Tm2 specific_heat2 density2 thermal_Conductivity2  dt dd materials interfaceK ...
        distribution frequency2;
    if isempty(materials)
        materials = 3;
    end
    if isempty(distribution)
        distribution = 1; %Center, center block, uniform, random. May have a second that gives option for radii
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
    f = figure('Visible', 'off','color','white','Position',[360,500,320,300]);
    if isempty(Tm2)
        Tm2=110; 
    end
    if isempty(specific_heat2)
        specific_heat2 = 4130;
    end
    if isempty(density2)
        density2 = 1600;
    end
    if isempty(thermal_Conductivity2)
        thermal_Conductivity2 = 2.5;
    end
    if isempty(interfaceK)
        interfaceK = 0.11;
    end
    if isempty(frequency2)
        frequency2 = 12;
    end
    
    Tm2Text = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,200,80,80],'String','Melting Point of Material 2');
    Tm2Edit = uicontrol('Style','edit','Position',[20,200,40,40],...
    'String',num2str(Tm2));

    c2Text = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[80,200,80,80],'String','Specific Heat (2)');
    c2Edit = uicontrol('Style','edit','Position',[100,200,40,40],...
    'String',num2str(specific_heat2),...
    'Callback',@callbackfn);
    
    p2Text = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[160,200,80,80],'String','Density (2) ');
    p2Edit = uicontrol('Style','edit','Position',[180,200,40,40],...
    'String',num2str(density2),...
    'Callback',@callbackfn);

    k2Text = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[240,200,80,80],'String','Thermal Conductivity (2)');
    k2Edit = uicontrol('Style','edit','Position',[260,200,40,40],...
    'String',num2str(thermal_Conductivity2),...
    'Callback',@callbackfn);

    
    
    interfaceText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[210,100,100,80],'String','Thermal Conductivity between the two materials');
    interfaceEdit = uicontrol('Style','edit','Position',[240,110,40,40],...
    'String',num2str(interfaceK));
    
    DBT = uicontrol('Style','text','BackgroundColor','White',...
        'Position', [20, 100, 100, 80], 'String','Distribution of the second material');
    DB = uicontrol('Style','pushbutton','Position',[20,110,100,40],'Callback',@DBF);
    
    frequencytext = uicontrol('Style','text','BackgroundColor','White',...
        'Position',[20, 20, 100, 80], 'String','Density of second material');
    frequencyEdit = uicontrol('Style','edit','BackgroundColor','White',...
        'Position',[50,30,40,40],'String', num2str(frequency2),'Callback',@callbackfn);
    switch distribution
            case 1
                set(DB,'String','Center Pixel');
                set(frequencytext,'Visible','off');
                set(frequencyEdit,'Visible','off');
            case 2
                set(DB,'String','Center Block');
                set(frequencytext,'Visible','off');
                set(frequencyEdit,'Visible','off');
            case 3
                set(DB,'String','Uniform Distribution');
                set(frequencytext,'Visible','on');
                set(frequencyEdit,'Visible','on');
            case 4
                set(DB,'String','Random Distribution');
                set(frequencytext,'Visible','on');
                set(frequencyEdit,'Visible','on');
            case 5
                set(DB,'String','Random Spheres');
                set(frequencytext,'Visible','on');
                set(frequencyEdit,'Visible','on');
    end
    set(f,'Name','Materials Variables')
    movegui(f,'center')
    set(f,'Visible','on')
    
        
    
    function callbackfn(~,~)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the push11button
        Tm2=str2double(get(Tm2Edit,'String'));
        specific_heat2=str2double(get(c2Edit,'String'));
        density2 = str2double(get(p2Edit,'String'));
        thermal_Conductivity2 = str2double(get(k2Edit,'String'));
        interfaceK = str2double(get(interfaceEdit,'String'));
        frequency2 = str2double(get(frequencyEdit,'String'));
        
    end

    function DBF(~,~)
        distribution = distribution + 1;
        if distribution > 5
            distribution = 1;
        end
        switch distribution
            case 1
                set(DB,'String','Center Pixel');
                set(frequencytext,'Visible','off');
                set(frequencyEdit,'Visible','off');
            case 2
                set(DB,'String','Center Block');
                set(frequencytext,'Visible','off');
                set(frequencyEdit,'Visible','off');
            case 3
                set(DB,'String','Uniform Distribution');
                set(frequencytext,'Visible','on');
                set(frequencyEdit,'Visible','on');
            case 4
                set(DB,'String','Random Distribution');
                set(frequencytext,'Visible','on');
                set(frequencyEdit,'Visible','on');
            case 5
                set(DB,'String','Random Spheres');
                set(frequencytext,'Visible','on');
                set(frequencyEdit,'Visible','on');
        end        
    end
    
end
