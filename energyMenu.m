function energyMenu
    global dimensions borders convection radiation extraConduction extraConvection extraRadiation;
    if isempty(borders)
        borders = true;
    end
    if isempty(convection)
        convection = false;
    end
    if isempty(radiation)
        radiation = false;
    end
    if isempty(dimensions)
        dimensions = 3;
    end
    if isempty(extraConduction)
        extraConduction = false;
    end
    if isempty(extraConvection)
        extraConvection = false;
    end
    if isempty(extraRadiation)
        extraRadiation = false;
    end
    
    f = figure('Visible', 'off','color','white','Position',[360,500,320,300]);
    
    
    hsttext = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[0,190,150,80],'String','No conduction off edges');
    huitext = uicontrol('Style','pushbutton','Position',[20,210,80,40],...
    'String','Currently on','Callback',@callbackfn);

    hsttext2 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[20,110,80,80],'String','Convection');
    huitext2 = uicontrol('Style','pushbutton','Position',[20,130,80,40],...
    'String','Currently off','Callback',@callbackfn);
    
    hsttext3 = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[20,30,80,80],'String','Radiation');
    huitext3 = uicontrol('Style','pushbutton','Position',[20,50,80,40],...
    'String','Currently off','Callback',@callbackfn);
    

    conductionOff = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[170,200,120,80],'String','Conduction off unseen dimensions');
    conductionOffB = uicontrol('Style','pushbutton','Position',[190,210,80,40],...
    'String','Currently off','Callback',@callbackfn);
    if extraConduction
        set(conductionOffB,'String','Currently on');
    end

    convectionOff = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[170,120,120,80],'String','Convection off unseen dimensions');
    convectionOffB = uicontrol('Style','pushbutton','Position',[190,130,80,40],...
    'String','Currently off','Callback',@callbackfn);
    if extraConvection
        set(convectionOffB,'String','Currently on');
    end
    
    radiationOff = uicontrol('Style','text','BackgroundColor','white',...
    'Position',[170,40,120,80],'String','Radiation off unseen dimensions');
    radiationOffB = uicontrol('Style','pushbutton','Position',[190,50,80,40],...
    'String','Currently off','Callback',@callbackfn);
    if extraRadiation
        set(radiationOffB,'String','Currently on');
    end
    
    if dimensions > 2
        set(conductionOff,'Visible','off');
        set(conductionOffB,'Visible','off');
        set(convectionOff,'Visible','off');
        set(convectionOffB,'Visible','off');
        set(radiationOff,'Visible','off');
        set(radiationOffB,'Visible','off');
    end
    
    set(f,'Name','Energy Dissipation Options')
    movegui(f,'center')

    set(f,'Visible','on')
    
    if borders
        set(huitext,'String','Currently on');
        if dimensions < 3
            set(conductionOff,'Visible','off');
            set(conductionOffB,'Visible','off');
        end
    else
        set(huitext,'String','Currently off');
        if dimensions < 3
            set(conductionOff,'Visible','on');
            set(conductionOffB,'Visible','on');
        end
    end
    if convection
        set(huitext2,'String','Currently on');
        if dimensions < 3
            set(convectionOff,'Visible','on');
            set(convectionOffB,'Visible','on');
        end
    else
        set(huitext2,'String','Currently off');
        if dimensions < 3
            set(convectionOff,'Visible','off');
            set(convectionOffB,'Visible','off');
        end
    end
    if radiation
        set(huitext3,'String','Currently on');
        if dimensions < 3
            set(radiationOff,'Visible','on');
            set(radiationOffB,'Visible','on');
        end
    else
        set(huitext3,'String','Currently off');
        if dimensions < 3
            set(radiationOff,'Visible','off');
            set(radiationOffB,'Visible','off');
        end
    end
    
    function callbackfn(hObject,~)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        switch hObject
            case huitext
                borders = ~borders;
                if borders
                    set(huitext,'String','Currently on');
                    if dimensions < 3
                        set(conductionOff,'Visible','off');
                        set(conductionOffB,'Visible','off');
                    end
                else
                    set(huitext,'String','Currently off');
                    if dimensions < 3
                        set(conductionOff,'Visible','on');
                        set(conductionOffB,'Visible','on');
                    end
                end
            case huitext2
                convection = ~convection;
                if convection
                    set(huitext2,'String','Currently on');
                    if dimensions < 3
                        set(convectionOff,'Visible','on');
                        set(convectionOffB,'Visible','on');
                    end
                else
                    set(huitext2,'String','Currently off');
                    if dimensions < 3
                        set(convectionOff,'Visible','off');
                        set(convectionOffB,'Visible','off');
                    end
                end
            case huitext3
                radiation = ~radiation;
                if radiation
                    set(huitext3,'String','Currently on');
                    if dimensions < 3
                        set(radiationOff,'Visible','on');
                        set(radiationOffB,'Visible','on');
                    end
                else
                    set(huitext3,'String','Currently off');
                    if dimensions < 3
                        set(radiationOff,'Visible','off');
                        set(radiationOffB,'Visible','off');
                    end
                end
            case conductionOffB
                extraConduction = ~extraConduction;
                if extraConduction
                    set(conductionOffB,'String','Currently on');
                else
                    set(conductionOffB,'String','Currently off');
                end
            case convectionOffB
                extraConvection = ~extraConvection;
                if extraConvection
                    set(convectionOffB,'String','Currently on');
                else
                    set(convectionOffB,'String','Currently off');
                end
            case radiationOffB
                extraRadiation = ~extraRadiation;
                if extraRadiation
                    set(radiationOffB,'String','Currently on');
                else
                    set(radiationOffB,'String','Currently off');
                end
                
        end
    end
    

end
