function calculate
    global dimensions
    if dimensions == 1
        Thermal1TwoMat;
    elseif dimensions == 2
        Thermal2TwoMat;
    elseif dimensions == 3
        Thermal3TwoMat;
    else
        disp('Number of dimensions must be declared');
        close(gcf);
        repickDimensions;
    end

end