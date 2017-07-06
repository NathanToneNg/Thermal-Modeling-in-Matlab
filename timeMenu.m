%timeMenu: Opens a menu where the user can pick how long the simulation
%will run, the time step, and rate of graphing.
%
%Clarifications:
%   Assumed units are in seconds, but scaling can be done as clarified in
%       the README below Usage.
%   Graphing Framerate tells the program how often (in terms of time steps)
%       the program should take a snapshot graph and calculate the average 
%       temperature and energy.
function timeMenu
    global total_time dt framerate graph timeOn timeOff absorption;

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
    if isempty(timeOn)
        timeOn = 0;
    end
    if isempty(timeOff)
        timeOff = total_time;
    end
    if isempty(absorption)
        absorption = 1;
    end
    
    totalTimeText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,200,80,80],'String','Total Time covered');
    totalTimeEdit = uicontrol('Style','edit','Position',[20,200,40,40],...
    'String',num2str(total_time), 'Callback', @callbackfn);

    dtText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[80,200,80,80],'String','Calculation time increment');
    dtEdit = uicontrol('Style','edit','Position',[100,200,40,40],...
    'String',num2str(dt),'Callback',@callbackfn);
    
    framerateText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[160,200,80,80],'String','Graphing framerate');
    framerateEdit = uicontrol('Style','edit','Position',[180,200,40,40],...
    'String',num2str(framerate),...
    'Callback',@callbackfn);
    if ~graph
        set(framerateText,'Visible','Off');
        set(framerateEdit,'Visible','Off');
    end
    
    onText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,110,80,80],'String','Time Absorption On');
    onEdit = uicontrol('Style','edit','Position',[20,110,40,40],...
    'String',num2str(timeOn), 'Callback', @callbackfn);

    offText = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[80,110,80,80],'String','Time Absorption Off');
    offEdit = uicontrol('Style','edit','Position',[100,110,40,40],...
    'String',num2str(timeOff),'Callback',@callbackfn);
    
    
    text = strcat('Total time steps: ', num2str(total_time/dt));
    intervalsShow = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[160,100,80,80],'String',text);
    
    
    set(f,'Name','Time Settings')
    movegui(f,'center')
    set(f,'Visible','on')
    
    
    if absorption == 6
        set(onText,'Visible','Off');
        set(onEdit,'Visible','Off');
        set(offText,'Visible','Off');
        set(offEdit,'Visible','Off');
    end
    
    function callbackfn(~,~)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        total_time=str2double(get(totalTimeEdit,'String'));
        dt=str2double(get(dtEdit,'String'));
        framerate = str2double(get(framerateEdit,'String'));
        text = strcat('Total time steps: ', num2str(total_time/dt));
        timeOn = str2double(get(onEdit,'String'));
        timeOff = str2double(get(offEdit,'String'));
        set(intervalsShow, 'String', text);
        if dt > total_time
            dt = total_time;
            set(dtEdit,'string',num2str(dt));
            disp('Must have at least one time step occurring.');
        end
    end
end
