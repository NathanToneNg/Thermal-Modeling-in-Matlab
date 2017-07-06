%printParameters: Brings all global variables to the user workspace
%
% Note that modifying or clearing these variables on the workspace will
% change the global ones after running this
%
globalVars = who('global');
for i = 1:length(globalVars)
    varname = genvarname(globalVars{i});
    eval(sprintf('global %s', varname));
end
