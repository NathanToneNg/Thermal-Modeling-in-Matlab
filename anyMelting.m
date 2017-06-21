%anyMelting: Returns how many pixels in matrix were above the melting point. If a
%logical array is passed in, will only check the 1s of the logical in the
%matrix. This is a simple version? anyMeltingIter is a more complex version
%for two materials checking whether both are melting, and closer to
%compatible with multi-material case
function [count] = anyMelting(matrix, Tm, logic)
    switch nargin
        case 3
            melted = matrix(logic) > Tm;
        case 2
            melted = matrix > Tm;
        otherwise
            print('Incorrect number of arguments. Must be in form [matrix melting_point] or [matrix melting_point logical]');
    end
    if size(matrix,2) == 1 %Assume that if the next dimension is only 1, then it has that many dimensions
        count = sum(melted);
    else
        if size(matrix,3) == 1
            count = sum(sum(melted));
        else
            if size(matrix,4) == 1
                count = sum(sum(sum(melted)));
            end
        end
    end

end

