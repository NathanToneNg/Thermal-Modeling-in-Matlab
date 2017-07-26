%saveConditions This function will save all global variables into a
%   specified file (or MostRecentTest.m if none is specified) in a form
%   that can be run as a matlab script to put all global variables onto the
%   workspace and global field.
%
% A second argument (must be a string) is optional and adds a comment with
%   the given string at the beginning of the file.
%
% Form: saveConditions filename 'string comment here, no % necessary.'
%
% Note that this will overwrite previous scripts if the name is the same.
%
% Will put the bigger matrices into a separate saved variable if the size
%   in a string is above the internal limit. Currently limit is 200000
%   bytes as a string, but that can be modified within the function. 

function saveConditions(filename, optionalText)
global initialGrid finalGrid recordGradient gradientPlot
if nargin > 2
    error('Incorrect usage. Use as saveConditions(filename, optionalText), arguments optional.');
end

if exist('filename','var')
    file = fopen(filename, 'w+');
else
    file = fopen('MostRecentTest.m','w+');
    filename = 'MostRecentTest';
end

%This limit is how big a matrix may be before putting it into a separate
%variable file. 
limit = 200000;

if nargin == 2
    fprintf(file, '%%%s\n\n', optionalText);
end

%Retrieve all global variables and print them into the file
globalVars = who('global');
for i = 1:length(globalVars)
    varname = globalVars{i};
    eval(sprintf('global %s', varname));
    var = eval(varname);
    if isa(var,'function_handle')
        var = func2str(var);
    elseif ~isnan(var)
        var = num2str(var);
    end
    fprintf(file, 'global %s\n', varname);
    
    %Print matrices as well, or just create a matrix to load if it is too
    %big in string form.
    if strcmp(varname, 'list') || strcmp(varname, 'tempsList') || strcmp(varname, ...
            'materialMatrix') || (strcmp(varname,'initialFrame') && ...
            ~isempty(initialGrid) && initialGrid) || ...
            (strcmp(varname, 'finalTemps') && ~isempty(finalGrid) && finalGrid) ...
             || (strcmp(varname, 'topTemps') && ~isempty(topCheck) && topCheck) ...
             || (strcmp(varname, 'gradientData') && ~isempty(recordGradient) && ...
             gradientPlot == 2 && recordGradient)
         
        strmatrix = mat2str(var);
        data = whos('strmatrix');
        if data.bytes > limit
            matrixname = strcat(filename, varname);
            matrixname = replace(matrixname,'.m','');
            save(matrixname,varname);
            fprintf(file, 'load %s\n', matrixname);
        else
            fprintf(file, '%s = %s;\n', varname, mat2str(var));
            fprintf(file, '%s = str2num(%s);\n',varname,varname);
        end
    elseif ischar(eval(varname))
        fprintf(file, '%s = ''%s'';\n', varname, var);
    elseif strcmp(varname, 'histogramPlot')
        clear global histogramPlot
        continue;
    elseif ~strcmp(varname, 'finalTemps') && ~strcmp(varname, 'topTemps')
        fprintf(file, '%s = %s;\n', varname, var);
    end
    
end

fclose(file);

end