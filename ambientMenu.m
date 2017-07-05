% ambientMenu: Opens a menu where the user can choose how energy is
% inserted into the system, both iniitially and through reception.
%
% Clarifications:
%   The option for constant time allows the user run the program slightly faster 
%   than otherwise, assuming the room temperature remains at an approximately 
%   constant temperature.
%
%   The room temperature function should be written in the form of an
%   anonymous function in matlab. For example, 10 + 3x^2 should be written as
%   '@(x)10 + 3*(x^2)'
%

function ambientMenu
    global heating roomTemp roomTempFunc;
    if isempty(heating)
        heating = false;
    end
    if isempty(roomTemp)
        roomTemp = 0;
    end
    if isempty(roomTempFunc)
        roomTempFunc = @(x)0;
    end

    
    f = figure('Visible', 'off','color','white','Position',...
    [360,500,360,300]);
    
    heatingText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,200,140,80],'String','Constant or changing room temperature?');
    heatingButton = uicontrol('Style','pushbutton','Position',[20,200,100,40],...
    'String','fixthis','Callback',@callbackfn);

    roomTempText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[150,240,100,40],'String','Constant Room Temperature');
    roomTempEdit = uicontrol('Style','edit','Position',[150,200,100,40],...
    'String',num2str(roomTemp),...
    'Callback',@callbackfn);
    
    roomFuncText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[150,240,100,40],'String','Room Temperature (function of time)');
    roomFuncEdit = uicontrol('Style','edit','Position',[150,200,100,40],...
    'String',func2str(roomTempFunc),...
    'Callback',@callbackfn);


    set(f,'Name','Ambient Temperature Menu')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Set values',...
        'Position',[107.5,50,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    

    if heating
        set(heatingButton,'String','Changing over time');
        set(roomTempText,'Visible','Off');
        set(roomTempEdit,'Visible','Off');
        set(roomFuncText,'Visible','On');
        set(roomFuncEdit,'Visible','On');
    else
        set(heatingButton,'String','Constant');
        set(roomTempText,'Visible','On');
        set(roomTempEdit,'Visible','On');
        set(roomFuncText,'Visible','Off');
        set(roomFuncEdit,'Visible','Off');
    end
    
    function callbackfn(hObject,~)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        if hObject == heatingButton
            heating = ~heating;
            if heating
                set(heatingButton,'String','Changing over time');
                set(roomTempText,'Visible','Off');
                set(roomTempEdit,'Visible','Off');
                set(roomFuncText,'Visible','On');
                set(roomFuncEdit,'Visible','On');
            else
                set(heatingButton,'String','Constant');
                set(roomTempText,'Visible','On');
                set(roomTempEdit,'Visible','On');
                set(roomFuncText,'Visible','Off');
                set(roomFuncEdit,'Visible','Off');
            end
        end
        roomTemp=str2double(get(roomTempEdit,'String'));
        roomTempFunc = str2func(get(roomFuncEdit,'String'));
        
    end
    
end

