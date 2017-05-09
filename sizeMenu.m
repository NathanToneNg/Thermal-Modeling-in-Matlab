function sizeMenu
    global dimensions xdist dd;
    if isempty(dimensions)
        dimensions = 1;
    end
    
    % guiMultiplierIf has 2 edit boxes for numbers and
    % multiplies them
    % Format: guiMultiplierIf or guiMultiplierIf()
    f = figure('Visible', 'off','color','white','Position',...
    [360,500,300,300]);
    if isempty(dd)
        dd=0.005; %Distance increment
    end
    if isempty(xdist)
        xdist = 0.2;
    end
    pixels = ((xdist / dd) + 1);
    hsttext = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,200,80,80],'String','Distance increment');
    huitext = uicontrol('Style','edit','Position',[20,200,40,40],...
    'String',num2str(dd),...
    'Callback',@callbackfn);

    hsttext2 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[70,200,80,80],'String','X distance');
    huitext2 = uicontrol('Style','edit','Position',[90,200,40,40],...
    'String',num2str(xdist),...
    'Callback',@callbackfn);
    
    if dimensions > 1
        global ydist;
        if isempty(ydist)
            ydist = 0.2;
        end
        hsttext3 = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[150,200,80,80],'String','Y distance');
        huitext3 = uicontrol('Style','edit','Position',[170,200,40,40],...
        'String',num2str(ydist),...
        'Callback',@callbackfn);
        pixels = ((xdist / dd) + 1) * ((ydist / dd) + 1);
    end
    if dimensions > 2
        global zdist;
        if isempty(zdist)
            zdist = 0.2;
        end
        hsttext4 = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[230,200,80,80],'String','Z distance');
        huitext4 = uicontrol('Style','edit','Position',[250,200,40,40],...
        'String',num2str(zdist),...
        'Callback',@callbackfn);
        pixels = ((xdist / dd) + 1) * ((ydist / dd) + 1) * ((zdist / dd) + 1);
    end
    
    text = strcat('Number of pixels: ', num2str(pixels));
    hsttext5 = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[110,10,80,150],'String',text);
    
    set(f,'Name','Size Settings')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Set values',...
        'Position',[100,50,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    
    function callbackfn(hObject,eventdata)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        dd=str2double(get(huitext,'String'));
        xdist=str2double(get(huitext2,'String'));
        pixels = ((xdist / dd) + 1);
        if dimensions > 1
            ydist = str2double(get(huitext3, 'String'));
            pixels = ((xdist / dd) + 1) * ((ydist / dd) + 1);
        end
        if dimensions > 2
            zdist = str2double(get(huitext4, 'String'));
            pixels = ((xdist / dd) + 1) * ((ydist / dd) + 1) * ((zdist / dd) + 1);
        end
        text = strcat('Number of pixels: ', num2str(pixels));
        set(hsttext5, 'String', text);
    end
end
