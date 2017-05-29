function [count] = anyMelting(matrix, Tm, logic)
    switch nargin
        case 3
            melted = matrix(logic) > Tm;
        case 2
            melted = matrix > Tm;
        otherwise
            print('Not enough arguments');
    end
    if size(matrix,2) == 1
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

