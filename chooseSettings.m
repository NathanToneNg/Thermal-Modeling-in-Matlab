%chooseSettings: Goes to the correct chooseSettings script based on how 
%many materials there are. 
%
%Clarifications: 
%   re-check parameters tells whether the program has a chance
%       of becoming unstable with the given material parameters and step sizes.
%   If the user is concerned about parameters, the button should be clicked
%       to refresh it after changing the parameters.
function chooseSettings
    global materials;
    if isempty(materials)
        materials = 3;
    end
    if materials == 1
        chooseSettings1
    else
        chooseSettings2
    end

end