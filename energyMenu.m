function energyMenu
    global borders convection radiation;
    if isempty(borders)
        borders = true;
    end
    if isempty(convection)
        convection = false;
    end
    if isempty(radiation)
        radiation = false;
    end

    
    f = figure('Visible', 'off','color','white','Position',[360,500,320,300]);
    
    
    hsttext = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,190,150,80],'String','No conduction off edges');
    huitext = uicontrol('Style','pushbutton','Position',[20,210,150,40],...
    'String','Currently on','Callback',@callbackfn);

    hsttext2 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[20,110,80,80],'String','Not implemented');
    huitext2 = uicontrol('Style','pushbutton','Position',[20,130,150,40],...
    'String','Currently off','Callback',@callbackfn);
    
    hsttext3 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[20,30,80,80],'String','Not implemented');
    huitext3 = uicontrol('Style','pushbutton','Position',[20,50,150,40],...
    'String','Currently off','Callback',@callbackfn);

    
    set(f,'Name','Energy Dissipation Options')
    movegui(f,'center')

    set(f,'Visible','on')
    
    if borders
        set(huitext,'String','Currently on');
    else
        set(huitext,'String','Currently off');
    end
    if convection
        set(huitext2,'String','Currently on');
    else
        set(huitext2,'String','Currently off');
    end
    if radiation
        set(huitext3,'String','Currently on');
    else
        set(huitext3,'String','Currently off');
    end
    
    function callbackfn(hObject,eventdata)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        switch hObject
            case huitext
                borders = ~borders;
                if borders
                    set(huitext,'String','Currently on');
                else
                    set(huitext,'String','Currently off');
                end
            case huitext2
                convection = ~convection;
                if convection
                    set(huitext2,'String','Currently on');
                else
                    set(huitext2,'String','Currently off');
                end
            case huitext3
                radiation = ~radiation;
                if radiation
                    set(huitext3,'String','Currently on');
                else
                    set(huitext3,'String','Currently off');
                end
        end
    end
    

end
