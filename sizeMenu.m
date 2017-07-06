%sizeMenu: Opens a menu where the user can pick the size of the simulation
%and distance "step" of the grid.
%
%Clarifications: Assumed units are in meters, but scaling can be done as
%   clarified in the README right before Usage.
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
    text = strcat('Number of pixels: ', num2str(floor((xdist / dd))));
    
    %More distance increments iff there are more dimensions.
    if dimensions > 1
        global ydist;
        if isempty(ydist)
            ydist = 0.2;
        end
        ydistText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[140,200,80,80],'String','Y distance');
        ydistEdit = uicontrol('Style','edit','Position',[160,200,40,40],...
        'String',num2str(ydist),...
        'Callback',@callbackfn);
        text = strcat('Number of pixels: ', num2str(floor((xdist / dd))), ' by', num2str(floor((ydist/dd))));
    end
    if dimensions > 2
        global zdist;
        if isempty(zdist)
            zdist = 0.2;
        end
        zdistText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[210,200,80,80],'String','Z distance');
        zdistEdit = uicontrol('Style','edit','Position',[230,200,40,40],...
        'String',num2str(zdist),...
        'Callback',@callbackfn);
        text = strcat('Number of pixels: ', num2str(floor((xdist / dd))), ' by', ...
            num2str(floor((ydist/dd))), ' by', num2str(floor(zdist/dd)));
    end
    
    pixelsText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[110,10,80,150],'String',text);
        
    set(f,'Name','Size Settings')
    movegui(f,'center')
    set(f,'Visible','on')
    
    function callbackfn(~,~)
        dd=str2double(get(ddEdit,'String'));
        xdist=str2double(get(xdistEdit,'String'));
        switch dimensions
            case 1
                minSize = xdist;
            case 2
                minSize = min(xdist, ydist);
                ydist = str2double(get(ydistEdit, 'String'));
            case 3
                minSize = min([xdist, ydist, zdist]);
                ydist = str2double(get(ydistEdit, 'String'));
                zdist = str2double(get(zdistEdit, 'String')); 
        end
        if dd > minSize
            dd = minSize;
            set(ddEdit,'string',num2str(dd));
            disp('Distance step must be at least as big as smallest dimension.')
        end
        switch dimensions
            case 1
                text = strcat('Number of pixels: ', num2str(floor((xdist / dd))));
            case 2
                text = strcat('Number of pixels: ', num2str(floor((xdist / dd))), ' by', num2str(floor((ydist/dd))));
            case 3
                text = strcat('Number of pixels: ', num2str(floor((xdist / dd))), ' by', ...
                num2str(floor((ydist/dd))), ' by', num2str(floor(zdist/dd)));
        end
        set(pixelsText, 'String', text);
    end

end
