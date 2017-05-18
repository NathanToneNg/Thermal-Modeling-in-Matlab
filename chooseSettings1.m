function chooseSettings1
global dimensions;
global dt dd thermal_Conductivity specific_heat density ;

% guiWithButtongroup has a button group with 2 radio buttons
% Format: guiWithButtongroup
% Create the GUI but make it invisible for now while
% it is being initialized

                                    %color of background, 
f = figure('Visible', 'off','color','black','Position',...
[360, 500, 400,400]);



% Create a button group
grouph = uibuttongroup('Parent',f,'Units','Normalized',...
'Position',[0 0 1 1], 'Title','Select settings and press calculate when complete',...
'SelectionChangeFcn',@whattodo);


% Put two radio buttons in the group
precisionSettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Precision Settings', 'Units', 'Normalized',...
    'Position', [.05 .9 .3 .1],'Callback',@whattodo);
sizeSettings = uicontrol(grouph,'Style','pushbutton',...
'String','Size Settings','Units','Normalized',...
'Position', [.05 .8 .3 .1],'Callback',@whattodo);
timeSettings = uicontrol(grouph, 'Style','pushbutton',...
'String','Time Settings','Units','Normalized',...
'Position',[.05 .7 .3 .1],'Callback',@whattodo);
materialSettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Material Settings', 'Units', 'Normalized',...
    'Position', [.05 .6 .3 .1],'Callback',@whattodo);
energySettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Energy Dissipation', 'Units', 'Normalized',...
    'Position', [.05 .5 .3 .1],'Callback',@whattodo);
temperatureSettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Energy Insertion', 'Units', 'Normalized',...
    'Position', [.05 .4 .3 .1],'Callback',@whattodo);
repickSettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Repick#Mat/Dimensions', 'Units', 'Normalized',...
    'Position', [.05 .3 .3 .1],'Callback',@whattodo);
calculateBar = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Calculate', 'Units', 'Normalized',...
    'Position', [.05 .2 .3 .1],'Callback',@whattodo);

warningText1 = uicontrol('Style','text', ...
    'Position',[250,170,120,200],'String', ...
    'Warning: The program may not run under these parameters. Decrease the time-step or increase one of the following: Material 1''s density, specific_heat, or conductivity, or the distance increment.');
checkButton = uicontrol('Style','pushbutton',...
    'Position',[250, 0, 120, 40], 'String', ...
    'Re-check parameters', 'Callback',@recheck);

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


function whattodo(hObject, ~)
    % whattodo is called by the 'SelectionChangeFcn' property
    % in the button group
    switch hObject
        case sizeSettings
            sizeMenu;
        case timeSettings
            timeMenu;
        case precisionSettings
            precisionMenu;
        case materialSettings
            materialMenu;
        case energySettings
            energyMenu;
        case temperatureSettings
            temperatureMenu;
        case repickSettings
            close(gcf);
            repickDimensions;
        case calculateBar
            printParameters;
            if dimensions == 1
                Thermal1TwoMat;
            elseif dimensions == 2
                Thermal2TwoMat;
            elseif dimensions == 3
                Thermal3TwoMat;
            else
                disp('Number of dimensions must be declared');
                close(gcf);
                overallGUI;
            end



    end

end

function recheck(~,~)
        if (1/7) <= dt * thermal_Conductivity / (dd * dd * specific_heat * density)
            set(warningText1,'Visible','on');
        else
            set(warningText1,'Visible','off');
        end
end

end