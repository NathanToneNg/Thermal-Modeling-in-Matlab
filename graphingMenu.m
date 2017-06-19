% graphingMenu Opens up a menu where globals for graphing (options for
% occurrences every framerate intervals) can be picked for the Thermal
% Modeling Program.
function graphingMenu
    global dimensions isotherm saveMovie melting
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
    
    f = figure('Visible', 'off','color','white','Position',[360,500,320,300]);
    
    
    isothermText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[0,190,120,80],'String','Slice or Isosurface plot?');
    isothermButton = uicontrol('Style','pushbutton','Position',[20,210,80,40],...
        'Callback',@callbackfn);

    movieText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[0, 110, 120, 80], 'String', 'Save movie?');
    movieButton = uicontrol('Style','pushbutton','Position',[20, 130, 80, 40],...
        'Callback',@callbackfn);
    
    meltingText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[0, 30, 120, 80], 'String', 'Keep track of melting?');
    meltingButton = uicontrol('Style','pushbutton','Position',[20, 50, 80, 40],...
        'Callback',@callbackfn);
    
    
    if dimensions == 3
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
        end
        
    end

end