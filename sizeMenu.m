function sizeMenu
    global dimensions xdist dd isotherm;
    if isempty(isotherm)
        isotherm = false;
    end
    if isempty(dimensions)
        dimensions = 1;
    end
    
    f = figure('Visible', 'off','color','white','Position',...
    [360,500,300,300]);
    if isempty(dd)
        dd=0.005; %Distance increment
    end
    if isempty(xdist)
        xdist = 0.2;
    end
    ddText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,200,80,80],'String','Distance increment');
    ddEdit = uicontrol('Style','edit','Position',[20,200,40,40],...
    'String',num2str(dd),...
    'Callback',@callbackfn);

    xdistText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[70,200,80,80],'String','X distance');
    xdistEdit = uicontrol('Style','edit','Position',[90,200,40,40],...
    'String',num2str(xdist),...
    'Callback',@callbackfn);
    text = strcat('Number of pixels: ', num2str(floor((xdist / dd) + 1)));
    
    %More distance increments iff there are more dimensions.
    if dimensions > 1
        global ydist;
        if isempty(ydist)
            ydist = 0.2;
        end
        ydistText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[150,200,80,80],'String','Y distance');
        ydistEdit = uicontrol('Style','edit','Position',[170,200,40,40],...
        'String',num2str(ydist),...
        'Callback',@callbackfn);
        text = strcat('Number of pixels: ', num2str(floor((xdist / dd) + 1)), ' by', num2str(floor((ydist/dd) + 1)));
    end
    if dimensions > 2
        global zdist;
        if isempty(zdist)
            zdist = 0.2;
        end
        zdistText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[230,200,80,80],'String','Z distance');
        zdistEdit = uicontrol('Style','edit','Position',[250,200,40,40],...
        'String',num2str(zdist),...
        'Callback',@callbackfn);
        text = strcat('Number of pixels: ', num2str(floor((xdist / dd) + 1)), ' by', ...
            num2str(floor((ydist/dd) + 1)), ' by', num2str(floor(zdist/dd + 1)));
    end
    
    pixelsText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[110,10,80,150],'String',text);
    if dimensions == 3
        graphButton = uicontrol('Style','pushbutton',...
            'Position',[20,50, 80, 50],'Callback',@graphfunction);
        if isotherm
            set(graphButton,'String','Isosurface plot');
        else
            set(graphButton,'String','Slice plot');
        end
    end
        
    set(f,'Name','Size Settings')
    movegui(f,'center')
    setButton = uicontrol('Style','pushbutton',...
        'String','Set values',...
        'Position',[100,50,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    
    function callbackfn(~,~)
        dd=str2double(get(ddEdit,'String'));
        xdist=str2double(get(xdistEdit,'String'));
        text = strcat('Number of pixels: ', num2str(floor((xdist / dd) + 1)));
        if dimensions > 1
            ydist = str2double(get(ydistEdit, 'String'));
            text = strcat('Number of pixels: ', num2str(floor((xdist / dd) + 1)), ' by', num2str(floor((ydist/dd) + 1)));

        end
        if dimensions > 2
            zdist = str2double(get(zdistEdit, 'String'));
            text = strcat('Number of pixels: ', num2str(floor((xdist / dd) + 1)), ' by', ...
            num2str(floor((ydist/dd) + 1)), ' by', num2str(floor(zdist/dd + 1)));
        end
        set(pixelsText, 'String', text);
    end

    function graphfunction(~,~)
        isotherm = ~isotherm;
        if isotherm
            set(graphButton,'String','Isosurface plot');
        else
            set(graphButton,'String','Slice plot');
        end
    end
end
