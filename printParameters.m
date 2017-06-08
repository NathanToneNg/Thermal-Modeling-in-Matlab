%Redone: Now simply brings all global variables to the workspace

globalVars = who('global');
for i = 1:length(globalVars)
    varname = genvarname(globalVars{i});
    eval(sprintf('global %s', varname));
    var = eval(varname);    
end
