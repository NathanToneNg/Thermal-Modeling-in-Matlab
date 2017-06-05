%Goes to the correct chooseSettings script based on how many materials
%there are. 
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