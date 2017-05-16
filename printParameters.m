function printParameters
global precision xdist ydist zdist dd total_time dt framerate borders convection radiation ...
    specific_heat density Tm constant roomTemp elevatedTemp elevLocation thermal_Conductivity...
    elevFrequency absorption energyRate distributionFrequency emissivity timeOn timeOff ...
    materials thermal_Conductivity2 interfaceK density2 specific_heat2 distribution frequency2 ...
    extraConduction extraConvection extraRadiation;
varList = {precision,xdist,ydist, zdist, dd, total_time, dt, framerate, ...
    specific_heat, specific_heat2, density, density2, Tm, constant, roomTemp, elevatedTemp,  ...
    elevFrequency, energyRate, timeOn, timeOff, distributionFrequency, frequency2, thermal_Conductivity ...
    thermal_Conductivity2 interfaceK emissivity};
strList = {'Precision','X distance','Y distance','Z distance','Distance increment',...
    'Total time','Time increment','Graphing framerate', '[Material 1] Specific Heat',...
    '[Material 2] Specific Heat', '[Material 1] Density', '[Material 2] Density',...
    'Melting point','Conduction constant','Room Temperature','Initial Elevated Temperature',...
    'Frequency of Elevated Temperature','Rate of energy reception','Absorption time on', ...
    'Absorption time off', 'Frequency of receptors',...
    'Frequency of material 2', '[Material 1] Thermal Conductivity', '[Material 2] Thermal Conductivity', ...
    'Conductivity between materials', 'Emissivity constant'};
varList2 = {borders, convection, radiation, extraConduction, extraConvection, extraRadiation, elevLocation, absorption, distribution};
strList2 = {'Conduction Borders', 'Convection', 'Radiation', ...
    'Conduction off extra dimensions', 'Convection off extra dimensions', 'Radiation off extra dimensions',...
    'Initial Elevated Temperature/ Location', 'Absorption/Receptor Location', 'Distribution of second material'};



switch materials
    case 1
        text = 'One material';
    case 2
        text = 'Two materials';
    case 3
        text = 'One matrix, one purely receiver';
end
disp(text);

for i = 1:23
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
for j = 1:9
    if isempty(varList2{j})
        text = strcat(strList2{j}, ' not declared');
    else
        switch varList2{j}
            case 1
                if (strcmp(strList2{j} ,'Convection') || strcmp(strList2{j}, 'Radiation') || strcmp(strList2{j}, 'Conduction Borders')...
                        || strcmp(strList2{j}, 'Convection off extra dimensions') || strcmp(strList2{j}, 'Conduction off extra dimensions')...
                        || strcmp(strList2{j}, 'Radiation off extra dimensions'))
                    text = strcat(strList2{j}, ': On');
                else
                    text = strcat(strList2{j}, ': Single Middle Point');
                end
            case 2
                text = strcat(strList2{j}, ': Block Middle Point');
            case 3
                text = strcat(strList2{j}, ': Spread');
                if strcmp(strList2{j}, 'Distribution of second material')
                    text = strcat(strList2{j}, ': Uniformly spread');
                end
            case 4
                text = strcat(strList2{j}, ': Off');
                if strcmp(strList2{j}, 'Distribution of second material')
                    text = strcat(strList2{j}, ': Randomly spread');
                end
            case 0
                text = strcat(strList2{j}, ': Off');
        end
    end
    disp(text);
end




end
