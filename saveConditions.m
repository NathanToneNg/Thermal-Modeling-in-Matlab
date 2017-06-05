function saveConditions(name)
if exist('name','var')
    file = fopen(name, 'w+');
else
    file = fopen('MostRecentTest.m','w+');
    name = 'MostRecentTest';
end
limit = 500000;
globalVars = who('global');

for i = 1:length(globalVars)
    varname = genvarname(globalVars{i});
    eval(sprintf('global %s', varname));
    var = eval(varname);
    if ~isnan(var)
        var = num2str(var);
    end
    fprintf(file, 'global %s\n', varname);
    if strcmp(varname, 'list') || strcmp(varname, 'tempsList') || strcmp(varname, 'materialMatrix') || strcmp(varname, 'finalTemps')
        strmatrix = mat2str(var);
        data = whos('strmatrix');
        if data.bytes > limit
            matrixname = genvarname(strcat(varname, name));
            save(matrixname,varname);
            fprintf(file, 'load %s\n', matrixname);
        else
            fprintf(file, '%s = %s;\n', varname, mat2str(var));
            fprintf(file, '%s = str2num(%s);\n',varname,varname);
        end
    else
        fprintf(file, '%s = %s;\n', varname, var);
    end
    
end

fclose(file);

end