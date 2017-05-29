function saveConditions(name)
if exist('name','var')
    file = fopen(name, 'w+');
else
    file = fopen('MostRecentTest.m','w+');
end
if ~file
    disp('Create file ''mostRecentTest.txt''.');
end

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
        fprintf(file, '%s = %s;\n', varname, mat2str(var));
        fprintf(file, '%s = str2num(%s);\n',varname,varname);
    else
        fprintf(file, '%s = %s;\n', varname, var);
    end
    
end

fclose(file);

end