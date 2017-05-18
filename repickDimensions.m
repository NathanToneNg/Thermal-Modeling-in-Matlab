function repickDimensions
    global dimensions materials




f = figure('Visible', 'off','color','white','Position',...
    [360,500,200,200]);
    if isempty(dimensions)
        dimensions = 3;
    end
    if isempty(materials)
        materials = 1;
    end
    hsttext = uicontrol('Style','text','BackgroundColor','white','Position',[30,100,80,80],'String','Dimensions');
    huitext = uicontrol('Style','edit','Position',[50,100,40,40],'String',num2str(dimensions));
    hsttext2 = uicontrol('Style','text','BackgroundColor','white','Position',[100,100,80,80],'String','Materials');
    huitext2 = uicontrol('Style','pushbutton','Position',[90,100,100,40], 'Callback', @materialsButton);
    switch materials
            case 1
                set(huitext2,'String','1 Material');
            case 2
                set(huitext2,'String','2 Materials');
            case 3
                set(huitext2,'String', '1 Matrix, 1 Receiver');
    end
    
    set(f,'Name','Repick Important Settings:')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Continue',...
        'Position',[40,40,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    
    function callbackfn(~,~)
        % callbackfn is called by the 'Callback' property
        % in either the second edit box or the pushbutton
        dimensions=str2double(get(huitext,'String'));
        close(gcf);
        if materials == 1
            distribution = 0;
            chooseSettings1;
        else
            chooseSettings2;
        end
        
    end

    function materialsButton(~,~)
        materials = materials + 1;
        if materials > 3
            materials = 1;
        end
        switch materials
            case 1
                set(huitext2,'String','1 Material');
            case 2
                set(huitext2,'String','2 Materials');
            case 3
                set(huitext2,'String', '1 Matrix, 1 Receiver');
        end
        
    end

end