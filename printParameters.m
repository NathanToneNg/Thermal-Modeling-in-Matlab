function printParameters
global precision xdist ydist zdist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm constant roomTemp elevatedTemp elevLocation ...
    elevFrequency absorption energyRate distributionFrequency emissivity;
varList = {precision,xdist,ydist, zdist, dd, total_time, dt, framerate, ...
    specific_heat, density, Tm, constant, roomTemp, elevatedTemp,  ...
    elevFrequency, energyRate, distributionFrequency, emissivity};
strList = {'Precision','X distance','Y distance','Z distance','Distance increment',...
    'Total time','Time increment','Graphing framerate', 'Specific Heat','Density of material',...
    'Melting point','Conduction constant','Room Temperature','Initial Elevated Temperature',...
    'Frequency of Elevated Temperature','Rate of energy reception','Frequency of receptors','Emissivity constant'};
varList2 = {borders, convection, radiation, elevLocation, absorption};
strList2 = {'Conduction Borders', 'Convection', 'Radiation', ...
    'Initial Elevated Temperature/ Location', 'Absorption/Receptor Location'};

for i = 1:18
    if isempty(varList{i})
        text = strcat(strList{i}, ' not declared');
    else
        if ~isnan(varList{i})
            text = strcat(strList{i}, ': ', num2str(varList{i}));
        else
            text = strcat(strList{i}, ': ', varList{i});
        end
    end
    disp(text);
end
for j = 1:5
    if isempty(varList2{j})
        text = strcat(strList2{j}, ' not declared');
    else
        switch varList2{j}
            case 1
                if (strcmp(strList2{j} ,'Convection') || strcmp(strList2{j}, 'Radiation') || strcmp(strList2{j}, 'borders'))
                    text = strcat(strList2{j}, ': On');
                else
                    text = strcat(strList2{j}, ': Single Middle Point');
                end
            case 2
                text = strcat(strList2{j}, ': Block Middle Point');
            case 3
                text = strcat(strList2{j}, ': Spread');
            case 4
                text = strcat(strList2{j}, ': Off');
            case 0
                text = strcat(strList2{j}, ': Off');
        end
    end
    disp(text);
end
