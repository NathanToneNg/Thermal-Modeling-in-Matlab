%precisionMenu: Opens a menu where the user can specify how many digits the
%calculations should be carried out to.
%
%Clarifications: Precision digits determine how many digits calculations 
%   should be carried out to.

function precisionMenu
    global precision;

    f = figure('Visible', 'off','color','white','Position',...
    [360,500,200,200]);
    if isempty(precision)
        precision = 10;
    end
    precisionText = uicontrol('Style','text','BackgroundColor','white','Position',[50,100,80,80],'String','Precision');
    precisionEdit = uicontrol('Style','edit','Position',[70,100,40,40],'String',num2str(precision));
    
    set(f,'Name','Precision Menu')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Set values',...
        'Position',[50,40,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    
    function callbackfn(~,~)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        precision=str2double(get(precisionEdit,'String'));
        if precision < 2 || precision > (2^29)
            precision = 10;
            set(precisionEdit,'string','10');
            disp('Precision must be a positive integer larger than 1 and smaller than 2^29 + 1.');
        end
    end
end
