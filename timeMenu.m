function timeMenu
    global total_time dt framerate;

    % guiMultiplierIf has 2 edit boxes for numbers and
    % multiplies them
    % Format: guiMultiplierIf or guiMultiplierIf()
    f = figure('Visible', 'off','color','white','Position',...
    [360,500,240,300]);
    if isempty(total_time)
        total_time=500; 
    end
    if isempty(dt)
        dt = 0.5;
    end
    if isempty(framerate)
        framerate = 500;
    end
    
    hsttext = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,200,80,80],'String','Total Time covered');
    huitext = uicontrol('Style','edit','Position',[20,200,40,40],...
    'String',num2str(total_time));

    hsttext2 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[80,200,80,80],'String','Calculation time increment');
    huitext2 = uicontrol('Style','edit','Position',[100,200,40,40],...
    'String',num2str(dt),...
    'Callback',@callbackfn);
    
    hsttext3 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[160,200,80,80],'String','Graphing framerate');
    huitext3 = uicontrol('Style','edit','Position',[180,200,40,40],...
    'String',num2str(framerate),...
    'Callback',@callbackfn);

    text = strcat('Total time steps: ', num2str(total_time/dt));
    hsttext4 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[80,100,80,80],'String',text);
    
    
    set(f,'Name','Time Settings')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Set values',...
        'Position',[70,50,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    
    function callbackfn(hObject,eventdata)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        total_time=str2double(get(huitext,'String'));
        dt=str2double(get(huitext2,'String'));
        framerate = str2double(get(huitext3,'String'));
        text = strcat('Total time steps: ', num2str(total_time/dt));
        set(hsttext4, 'String', text);
    end
end
