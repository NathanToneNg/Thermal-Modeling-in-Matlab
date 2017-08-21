% miscMenu Opens up a menu where globals for graphing (options for
% occurrences every framerate intervals) can be picked for the Thermal
% Modeling Program.
%
% Clarifications
%   
%   Precision digits determine how many digits calculations should be 
%       carried out to.
%
%   Tracking top temperatures will leave the global topTemps as an array 
%       with the average top (top z values) of a matrix down to the 
%       provided depth.
%   
%   Constant RNG makes it so that the program runs "rng('default');" which
%       causes all random factors to be the same each run. Most useful  for 
%       reproducibility.
%
function miscMenu
    global dimensions melting precision consistent topCheck depth
    if isempty(precision)
        precision = 10;
    end
    if isempty(dimensions)
        dimensions = 3;
    end
    if isempty(melting)
        melting = false;
    end
    if isempty(consistent)
        consistent = false;
    end
    
    f = figure('Visible', 'off','color','white','Position',[360,500,400,300]);
    
    meltingText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[0, 190, 120, 80], 'String', 'Keep track of melting?');
    meltingButton = uicontrol('Style','pushbutton','Position',[20, 210, 80, 40],...
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
        'Position',[0, 110, 120, 80], 'String', 'Precision');
    precisionEdit = uicontrol('Style','edit','Position',[20, 130, 80, 40],...
        'String',num2str(precision),'Callback',@callbackfn);
    
    consistentText = uicontrol('Style','text','BackgroundColor','white',...
        'Position',[0, 30, 120, 80], 'String', 'Constant RNG?');
    consistentButton = uicontrol('Style','pushbutton','Position',[20, 50, 80, 40],...
        'Callback',@callbackfn);
    
    
    if dimensions == 3
        set(topText,'visible','on');
        set(topButton,'visible','on');
    else
        set(topText,'visible','off');
        set(topButton,'visible','off');
    end
    if melting
        set(meltingButton,'string','On');
    else
        set(meltingButton,'string','Off');
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
    if consistent
        set(consistentButton,'String','On');
    else
        set(consistentButton,'String','Off');
    end
    set(f,'Name','Miscellaneous Options')
    movegui(f,'center')

    set(f,'Visible','on')



    function callbackfn(hObject,~)
        switch hObject 
            case meltingButton
                melting = ~melting;
                if melting
                    set(meltingButton,'string','On');
                else
                    set(meltingButton,'string','Off');
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
            case consistentButton
                consistent = ~consistent;
                if consistent
                    set(consistentButton,'String','On');
                else
                    set(consistentButton,'String','Off');
                end
        end
        
    end

end