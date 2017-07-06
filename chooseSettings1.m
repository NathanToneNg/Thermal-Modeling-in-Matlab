function chooseSettings1
global dt dd thermal_Conductivity specific_heat density;


f = figure('Visible', 'off','color','black','Position',...
[360, 500, 400,400]);

% Create a button group
grouph = uibuttongroup('Parent',f,'Units','Normalized',...
'Position',[0 0 1 1], 'Title','Select settings and press calculate when complete',...
'SelectionChangeFcn',@callbackfn);


sizeSettings = uicontrol(grouph,'Style','pushbutton',...
    'String','Size Settings','Units','Normalized',...
    'Position', [.05 .9 .3 .1],'Callback',@callbackfn);
timeSettings = uicontrol(grouph, 'Style','pushbutton',...
    'String','Time Settings','Units','Normalized',...
    'Position',[.05 .8 .3 .1],'Callback',@callbackfn);
materialSettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Material Settings', 'Units', 'Normalized',...
    'Position', [.05 .7 .3 .1],'Callback',@callbackfn);
energySettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Energy Dissipation', 'Units', 'Normalized',...
    'Position', [.05 .6 .3 .1],'Callback',@callbackfn);
ambientSettings = uicontrol(grouph, 'Style','pushbutton', ...
    'String', 'Room Temp Settings', 'Units', 'Normalized', ...
    'Position', [.05 .5 .3 .1],'Callback',@callbackfn);
temperatureSettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Energy Insertion', 'Units', 'Normalized',...
    'Position', [.05 .4 .3 .1],'Callback',@callbackfn);
graphingSettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Graphing Settings', 'Units', 'Normalized',...
    'Position', [.05 .3 .3 .1],'Callback',@callbackfn);
miscSettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Misc. Settings', 'Units', 'Normalized',...
    'Position', [.05 .2 .3 .1],'Callback',@callbackfn);


repickSettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Repick#Mat/Dimensions', 'Units', 'Normalized',...
    'Position', [.35 .9 .3 .1],'Callback',@callbackfn);
calculateBar = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Calculate', 'Units', 'Normalized',...
    'Position', [.35 .8 .3 .1],'Callback',@callbackfn);



warningText1 = uicontrol('Style','text', ...
    'Position',[270,170,120,200],'String', ...
    'Warning: The program may not run under these parameters. Decrease the time-step or increase one of the following: Material 1''s density, specific_heat, or conductivity, or the distance increment.');
checkButton = uicontrol('Style','pushbutton',...
    'Position',[270, 20, 120, 40], 'String', ...
    'Re-check parameters', 'Callback',@callbackfn);

if (1/7) <= dt * thermal_Conductivity / (dd * dd * specific_heat * density)
    set(warningText1,'Visible','on');
else
    set(warningText1,'Visible','off');
end
        

set(grouph,'SelectedObject',[]) % No button selected yet
set(f,'Name','Settings Menu')
movegui(f,'center')
% Now the GUI is made visible
set(f,'Visible','on')

%Opens the correct menu based on which button is pressed
function callbackfn(hObject, ~)
    switch hObject
        case sizeSettings
            sizeMenu;
        case timeSettings
            timeMenu;
        case materialSettings
            materialMenu;
        case energySettings
            energyMenu;
        case temperatureSettings
            temperatureMenu;
        case repickSettings
            close(gcf);
            repickDimensions;
        case graphingSettings
            graphingMenu;
        case ambientSettings
            ambientMenu;
        case miscSettings
            miscMenu;
        case calculateBar
            calculate
        case checkButton
            if (1/7) <= dt * thermal_Conductivity / (dd * dd * specific_heat * density)
                set(warningText1,'Visible','on');
            else
                set(warningText1,'Visible','off');
            end
    end

end

end