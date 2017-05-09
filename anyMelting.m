function [count] = anyMelting(matrix, Tm)
    melted = matrix > Tm;
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