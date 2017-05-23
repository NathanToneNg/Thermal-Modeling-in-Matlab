function saveConditions

file = fopen('mostRecentTest.txt', 'w+');
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
    if strcmp(varname, 'list')
        fprintf(file, '%%%s = %s\n', varname, var);
    else
        fprintf(file, 'global %s\n', varname);
        fprintf(file, '%s = %s;\n', varname, var);
    end
    
end

fclose(file);

end