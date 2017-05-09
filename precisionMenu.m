function precisionMenu
    global precision;
    % guiMultiplierIf has 2 edit boxes for numbers and
    % multiplies them
    % Format: guiMultiplierIf or guiMultiplierIf()
    f = figure('Visible', 'off','color','white','Position',...
    [360,500,200,200]);
    if isempty(precision)
        precision = 10;
    end
    dd=0; %Distance increment
    hsttext = uicontrol('Style','text','BackgroundColor','white','Position',[50,100,80,80],'String','Precision');
    huitext = uicontrol('Style','edit','Position',[70,100,40,40],'String',num2str(precision));
    set(f,'Name','Precision Menu')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Set values',...
        'Position',[50,40,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    
    function callbackfn(hObject,eventdata)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        precision=str2double(get(huitext,'String'));
    end
end
