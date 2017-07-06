% graphingMenu Opens up a menu where globals for graphing (options for
% occurrences every framerate intervals) can be picked for the Thermal
% Modeling Program.
%
% Clarifications
%   Isosurfaces option applies for 3D cases only: Will plot isosurfaces at
%       every 10th percentile of temperatures.
%
%   Saving the movie will have the program save the movie as 
%       recentTestMovie.avi in your MATLAB folder. Drag this into the 
%       MATLAB Command Window to bring the movie to the workspace, and use 
%       movie(recentTestMovie) to play it.
function graphingMenu
    global dimensions isotherm saveMovie melting graph initialGrid ...
        topCheck depth finalGrid precision
    if isempty(precision)
        precision = 10;
    end
    if isempty(dimensions)
        dimensions = 3;
    end
    if isempty(isotherm)
        isotherm = false;
    end
    if isempty(saveMovie)
        saveMovie = false;
    end
    if isempty(melting)
        melting = false;
    end
    if isempty(graph)
        graph = true;
    end
    if isempty(initialGrid)
        initialGrid = false;
    end
    if isempty(topCheck)
        topCheck = false;
    end
    if isempty(depth)
        depth = 0.015;
    end
    if isempty(finalGrid)
        finalGrid = false;
    end
    
    f = figure('Visible', 'off','color','white','Position',[360,500,400,300]);
    
    graphText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[0,190,120,80],'String','Graph temperatures?');
    graphButton = uicontrol('Style','pushbutton','Position',[20,210,80,40],...
        'Callback',@callbackfn);
    
    isothermText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[120,190,120,80],'String','Slice or Isosurface plot?');
    isothermButton = uicontrol('Style','pushbutton','Position',[140,210,80,40],...
        'Callback',@callbackfn);

    movieText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[0, 110, 120, 80], 'String', 'Save movie?');
    movieButton = uicontrol('Style','pushbutton','Position',[20, 130, 80, 40],...
        'Callback',@callbackfn);
    
    meltingText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[0, 30, 120, 80], 'String', 'Keep track of melting?');
    meltingButton = uicontrol('Style','pushbutton','Position',[20, 50, 80, 40],...
        'Callback',@callbackfn);
    
    initialText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[120, 110, 120, 80], 'String', 'Record initial temps grid?');
    initialButton = uicontrol('Style','pushbutton','Position',[140, 130, 80, 40],...
        'Callback',@callbackfn);
    
    finalText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[120, 30, 120, 80], 'String', 'Record final temps grid?');
    finalButton = uicontrol('Style','pushbutton','Position',[140, 50, 80, 40],...
        'Callback',@callbackfn);
    
    topText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[240, 190, 120, 80], 'String', 'Track top temperatures?');
    topButton = uicontrol('Style','pushbutton','Position',[260, 210, 80, 40],...
        'Callback',@callbackfn);
    
    depthText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[240, 110, 120, 80], 'String', 'Depth');
    depthEdit = uicontrol('Style','edit','Position',[260, 130, 80, 40],...
        'String',num2str(depth),'Callback',@callbackfn);
    
    precisionText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[240, 30, 120, 80], 'String', 'Precision');
    precisionEdit = uicontrol('Style','edit','Position',[260, 50, 80, 40],...
        'String',num2str(precision),'Callback',@callbackfn);
    
    if dimensions == 3
        set(topText,'visible','on');
        set(topButton,'visible','on');
        if graph
            set(isothermText,'visible','on');
            set(isothermButton,'visible','on');
        else
            set(isothermText,'visible','off');
            set(isothermButton,'visible','off');
        end
    else
        set(isothermText,'Visible','off');
        set(isothermButton,'Visible','off');
        set(topText,'visible','off');
        set(topButton,'visible','off');
    end
    if isotherm
        set(isothermButton,'string','Isosurface plot');
    else
        set(isothermButton,'string','Slice plot');
    end
    if saveMovie
        set(movieButton,'string','On');
    else
        set(movieButton,'string','Off');
    end
    if melting
        set(meltingButton,'string','On');
    else
        set(meltingButton,'string','Off');
    end
    if graph
        set(graphButton,'String','On');
    else
        set(graphButton,'String','Off');
        set(movieText,'Visible','Off');
        set(movieButton,'Visible','Off');
    end
    if initialGrid
        set(initialButton,'string','On');
    else
        set(initialButton,'string','Off');
    end
    if finalGrid
        set(finalButton,'string','On');
    else
        set(finalButton,'string','Off');
    end
    if topCheck && dimensions == 3
        set(topButton,'string','On');
        set(depthText,'Visible','On');
        set(depthEdit,'Visible','On');
    else
        set(topButton,'string','Off');
        set(depthText,'Visible','Off');
        set(depthEdit,'Visible','Off');
    end
    set(f,'Name','Miscellaneous Options')
    movegui(f,'center')

    set(f,'Visible','on')



    function callbackfn(hObject,~)
        switch hObject 
            case isothermButton
                isotherm = ~isotherm;
                if isotherm
                    set(isothermButton,'string','Isosurface plot');
                else
                    set(isothermButton,'string','Slice plot');
                end
            case movieButton
                saveMovie = ~saveMovie;
                if saveMovie
                    set(movieButton,'string','On');
                else
                    set(movieButton,'string','Off');
                end
            case meltingButton
                melting = ~melting;
                if melting
                    set(meltingButton,'string','On');
                else
                    set(meltingButton,'string','Off');
                end
            case graphButton
                graph = ~graph;
                if graph
                    set(graphButton,'String','On');
                    set(movieText,'Visible','On');
                    set(movieButton,'Visible','On');
                    if dimensions == 3
                        set(isothermText,'visible','on');
                        set(isothermButton,'visible','on');
                    end
                else
                    set(graphButton,'String','Off');
                    set(movieText,'Visible','Off');
                    set(movieButton,'Visible','Off');
                    set(isothermText,'Visible','off');
                    set(isothermButton,'Visible','off');
                end
            case initialButton
                initialGrid = ~initialGrid;
                if initialGrid
                    set(initialButton,'string','On');
                else
                    set(initialButton,'string','Off');
                end
            case finalButton
                finalGrid = ~finalGrid;
                if finalGrid
                    set(finalButton,'String','On');
                else
                    set(finalButton,'String','Off');
                end
            case topButton
                topCheck = ~topCheck;
                if topCheck
                    set(topButton,'string','On');
                    set(depthText,'Visible','On');
                    set(depthEdit,'Visible','On');
                else
                    set(topButton,'string','Off');
                    set(depthText,'Visible','Off');
                    set(depthEdit,'Visible','Off');
                end
            case depthEdit
                depth = str2double(get(depthEdit,'string'));
            case precisionEdit
                precision = str2double(get(precisionEdit,'string'));
        end
        
    end

end