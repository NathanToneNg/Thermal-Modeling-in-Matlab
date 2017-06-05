function chooseSettings2
global dimensions;
global dt dd thermal_Conductivity thermal_Conductivity2 interfaceK specific_heat specific_heat2 density density2;

f = figure('Visible', 'off','color','black','Position',...
[360, 500, 400,400]);



% Create a button group
grouph = uibuttongroup('Parent',f,'Units','Normalized',...
'Position',[0 0 1 1], 'Title','Select settings and press calculate when complete',...
'SelectionChangeFcn',@whattodo);

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
    'String', 'First Material', 'Units', 'Normalized',...
    'Position', [.05 .6 .3 .1],'Callback',@whattodo);
material2Settings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Second Material', 'Units', 'Normalized',...
    'Position', [.05 .5, .3 .1], 'Callback', @whattodo);
energySettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Energy Dissipation', 'Units', 'Normalized',...
    'Position', [.05 .4 .3 .1],'Callback',@whattodo);
temperatureSettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Energy Insertion', 'Units', 'Normalized',...
    'Position', [.05 .3 .3 .1],'Callback',@whattodo);
repickSettings = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Repick#Mat/Dimensions', 'Units', 'Normalized',...
    'Position', [.05 .2 .3 .1],'Callback',@whattodo);
calculateBar = uicontrol(grouph, 'Style', 'pushbutton', ...
    'String', 'Calculate', 'Units', 'Normalized',...
    'Position', [.05 .1 .3 .1],'Callback',@whattodo);

warningText1 = uicontrol('Style','text', ...
    'Position',[250,170,120,200],'String', ...
    'Warning: The program may not run under these parameters. Decrease the time-step or increase one of the following: Material 1''s density, specific_heat, or conductivity, or the distance increment.');
warningText2 = uicontrol('Style','text', ...
    'Position',[250,20,120,200],'String', ...
    'Warning: The program may not run under these parameters. Decrease the time-step or increase one of the following: Material 2''s density, specific_heat, or conductivity/interface conductivity, or the distance increment.');
checkButton = uicontrol('Style','pushbutton',...
    'Position',[250, 0, 120, 40], 'String', ...
    'Re-check parameters', 'Callback',@recheck);

        if (1/7) <= dt * thermal_Conductivity / (dd * dd * specific_heat * density)
            set(warningText1,'Visible','on');
        else
            set(warningText1,'Visible','off');
        end
        if (1/7) <= dt * thermal_Conductivity2 / (dd * dd * specific_heat2 * density2) || ...
           (1/7) <= dt * interfaceK / (dd * dd * specific_heat2 * density2)            
            set(warningText2,'Visible','on');
        else
            set(warningText2,'Visible','off');
        end
        
        

set(grouph,'SelectedObject',[]) % No button selected yet
set(f,'Name','Settings Menu')
movegui(f,'center')
% Now the GUI is made visible
set(f,'Visible','on')

%Opens the correct menu based on which button is pressed
function whattodo(hObject, ~)
    switch hObject
        case sizeSettings
            sizeMenu;
        case timeSettings
            timeMenu;
        case precisionSettings
            precisionMenu;
        case materialSettings
            materialMenu;
        case material2Settings
            material2Menu;
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
                repickDimensions;
            end



    end

end

    function recheck(~,~)
        if (1/7) <= dt * thermal_Conductivity / (dd * dd * specific_heat * density)
            set(warningText1,'Visible','on');
        else
            set(warningText1,'Visible','off');
        end
        if (1/7) <= dt * thermal_Conductivity2 / (dd * dd * specific_heat2 * density2) || ...
                (1/7) <= dt * interfaceK / (dd * dd * specific_heat2 * density2)
            set(warningText2,'Visible','on');
        else
            set(warningText2,'Visible','off');
        end
    end
end