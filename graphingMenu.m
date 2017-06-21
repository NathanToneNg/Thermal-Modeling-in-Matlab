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
    global dimensions isotherm saveMovie melting graph
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
    
    f = figure('Visible', 'off','color','white','Position',[360,500,320,300]);
    
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
    
    
    if dimensions == 3 && graph
        set(isothermText,'visible','on');
        set(isothermButton,'visible','on');
    else
        set(isothermText,'Visible','off');
        set(isothermButton,'Visible','off');
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
    
    set(f,'Name','Graphing Options')
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
        end
        
    end

end