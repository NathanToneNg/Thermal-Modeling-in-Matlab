function repickDimensions
    global dimensions materials distribution

    f = figure('Visible', 'off','color','white','Position',...
    [360,500,200,200]);
    if isempty(dimensions)
        dimensions = 3;
    end
    if isempty(materials)
        materials = 1;
    end
    dimensionsText = uicontrol('Style','text','BackgroundColor','white','Position',[30,100,80,80],'String','Dimensions');
    dimensionsEdit = uicontrol('Style','edit','Position',[50,100,40,40],'String',num2str(dimensions));
    materialsText = uicontrol('Style','text','BackgroundColor','white','Position',[100,100,80,80],'String','Materials');
    materialsEdit = uicontrol('Style','pushbutton','Position',[90,100,100,40], 'Callback', @materialsButton);
    switch materials
            case 1
                set(materialsEdit,'String','1 Material');
            case 2
                set(materialsEdit,'String','2 Materials');
            case 3
                set(materialsEdit,'String', '1 Matrix, 1 Receiver');
    end
    
    set(f,'Name','Repick Important Settings:')
    movegui(f,'center')
    hbutton = uicontrol('Style','pushbutton',...
        'String','Continue',...
        'Position',[40,40,100,50], 'Callback',@callbackfn);
    set(f,'Visible','on')
    
    function callbackfn(~,~)
        dimensions=str2double(get(dimensionsEdit,'String'));
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
                set(materialsEdit,'String','1 Material');
            case 2
                set(materialsEdit,'String','2 Materials');
            case 3
                set(materialsEdit,'String', '1 Matrix, 1 Receiver');
        end
        
    end

end