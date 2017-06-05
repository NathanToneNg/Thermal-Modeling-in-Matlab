%This function will save all global variables into a specified .m file (or
%MostRecentTest.m if none is specified) in a form that can be run as a
%matlab script to put all global variables onto the workspace and global field.

%Note that this will overwrite previous scripts if the name is the same. 
function saveConditions(name)
if exist('name','var')
    file = fopen(name, 'w+');
else
    file = fopen('MostRecentTest.m','w+');
    name = 'MostRecentTest';
end

%This limit is how big a matrix may be before putting it into a separate
%variable. 
limit = 500000;

%Retrieve all global variables and print them into the file
globalVars = who('global');
for i = 1:length(globalVars)
    varname = genvarname(globalVars{i});
    eval(sprintf('global %s', varname));
    var = eval(varname);
    if ~isnan(var)
        var = num2str(var);
    end
    fprintf(file, 'global %s\n', varname);
    
    %Print matrices as well, or just create a matrix to load if it is too
    %big in string form.
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