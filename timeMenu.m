function timeMenu
    global total_time dt framerate;

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
    
    totalTimeText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,200,80,80],'String','Total Time covered');
    totalTimeEdit = uicontrol('Style','edit','Position',[20,200,40,40],...
    'String',num2str(total_time));

    dtText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[80,200,80,80],'String','Calculation time increment');
    dtEdit = uicontrol('Style','edit','Position',[100,200,40,40],...
    'String',num2str(dt),...
    'Callback',@callbackfn);
    
    framerateText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[160,200,80,80],'String','Graphing framerate');
    framerateEdit = uicontrol('Style','edit','Position',[180,200,40,40],...
    'String',num2str(framerate),...
    'Callback',@callbackfn);

    text = strcat('Total time steps: ', num2str(total_time/dt));
    intervalsShow = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[80,100,80,80],'String',text);
    
    
    set(f,'Name','Time Settings')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Set values',...
        'Position',[70,50,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    
    function callbackfn(~,~)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        total_time=str2double(get(totalTimeEdit,'String'));
        dt=str2double(get(dtEdit,'String'));
        framerate = str2double(get(framerateEdit,'String'));
        text = strcat('Total time steps: ', num2str(total_time/dt));
        set(intervalsShow, 'String', text);
    end
end
