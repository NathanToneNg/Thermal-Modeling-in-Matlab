%calculate: Runs the correct thermal program based on how many dimensions
%   there are. Useful for running immediately after running test case
%   script.

function calculate
    global dimensions
    close(gcf);
    switch dimensions
        case 1
            Thermal1TwoMat;
        case 2
            Thermal2TwoMat;
        case 3
            Thermal3TwoMat;
        otherwise
            disp('Number of dimensions must be declared');
            repickDimensions;
    end
end