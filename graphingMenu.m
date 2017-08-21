% graphingMenu Opens up a menu where globals for graphing (options for
% occurrences every framerate intervals) can be picked for the Thermal
% Modeling Program.
%
% Clarifications
%   Isosurfaces option applies for 3D cases only: Will plot isosurfaces at
%       every 10th percentile of temperatures.
%   Histogram option tracks number of temperatures in each range and plots
%       them. Default is 10 bins.
%   Gradient option plots average temperatures at radii from center against
%       the radii in bins. Default is 10 bins.
%
%   Saving the movie will have the program save the movie as 
%       recentTestMovie.avi in your MATLAB folder. Drag this into the 
%       MATLAB Command Window to bring the movie to the workspace, and use 
%       movie(recentTestMovie) to play it.
function graphingMenu
    global dimensions isotherm saveMovie graph initialGrid finalGrid gradientPlot recordGradient
    if isempty(dimensions)
        dimensions = 3;
    end
    if isempty(isotherm)
        isotherm = false;
    end
    if isempty(saveMovie)
        saveMovie = false;
    end
    if isempty(graph)
        graph = true;
    end
    if isempty(initialGrid)
        initialGrid = false;
    end
    if isempty(finalGrid)
        finalGrid = false;
    end
    if isempty(gradientPlot)
        gradientPlot = 0;
    end
    if isempty(recordGradient)
        recordGradient = false;
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
    
    histogramText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[120,110,120,90],'String','Gradient Plot/ Histogram Instead?');
    histogramButton = uicontrol('Style','pushbutton','Position',[140,130,80,40],...
        'Callback',@callbackfn);
    
    recGradText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[120,30,120,90],'String','Record Gradient in a matrix?');
    recGradButton = uicontrol('Style','pushbutton','Position',[140,50,80,40],...
        'Callback',@callbackfn);
    
    initialText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[240, 190, 120, 80], 'String', 'Record initial temps grid?');
    initialButton = uicontrol('Style','pushbutton','Position',[260, 210, 80, 40],...
        'Callback',@callbackfn);
    
    finalText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[240, 110, 120, 80], 'String', 'Record final temps grid?');
    finalButton = uicontrol('Style','pushbutton','Position',[260, 130, 80, 40],...
        'Callback',@callbackfn);
        
    if dimensions == 3
        if graph && ~gradientPlot
            set(isothermText,'visible','on');
            set(isothermButton,'visible','on');
        else
            set(isothermText,'visible','off');
            set(isothermButton,'visible','off');
        end
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
    switch gradientPlot
        case 0
            set(histogramButton,'string','Off');
            set(recGradText,'visible','off');
            set(recGradButton,'visible','off');
        case 1
            set(histogramButton,'string','Histogram');
            set(recGradText,'visible','off');
            set(recGradButton,'visible','off');
        case 2
            set(histogramButton,'string','Gradient Plot');
            set(recGradText,'visible','on');
            set(recGradButton,'visible','on');
    end
    if recordGradient
        set(recGradButton,'string','On');
    else
        set(recGradButton,'string','Off');
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
            case graphButton
                graph = ~graph;
                if graph
                    set(graphButton,'String','On');
                    set(movieText,'Visible','On');
                    set(movieButton,'Visible','On');
                    if dimensions == 3 && ~gradientPlot
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
            case histogramButton
                gradientPlot = gradientPlot + 1;
                if gradientPlot > 2
                    gradientPlot = 0;
                end
                if gradientPlot
                    if gradientPlot == 1
                        set(histogramButton,'string','Histogram');
                        set(recGradText,'visible','off');
                        set(recGradButton,'visible','off');
                    else
                        set(histogramButton,'string','Gradient Plot');
                        set(recGradText,'visible','on');
                        set(recGradButton,'visible','on');
                    end
                    if dimensions == 3 && graph
                        set(isothermText,'visible','off');
                        set(isothermButton,'visible','off');
                    end
                else
                    set(histogramButton,'string','Off');
                    set(recGradText,'visible','off');
                    set(recGradButton,'visible','off');
                    if dimensions == 3 && graph
                        set(isothermText,'visible','on');
                        set(isothermButton,'visible','on');
                    end
                end
            case recGradButton
                recordGradient = ~recordGradient;
                if recordGradient
                    set(recGradButton,'string','On');
                else
                    set(recGradButton,'string','Off');
                end
        end
    end

end