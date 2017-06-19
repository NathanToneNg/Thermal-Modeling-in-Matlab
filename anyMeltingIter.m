%anyMeltingIter Returns a logical matrix: this function will take a Matrix of values, 
%a logical matrix, and a scalar value or matrix to compare against. All matrices must
%be the same size. 
%
%RETURNS: The returned matrix will return the logical matrix passed in, with
%additional 1s for which of the value matrix are higher than the scalar
%value or their respective value in the third matrix.
function [unupdated] = anyMeltingIter(matrix, unupdated, Tms)
    if nargin ~= 3
        error('Incorrect number of arguments. Must be in form anyMeltingIter [matrix melting_logical melting_points(or scalar)]');
    end
    if any(size(matrix) ~= size(unupdated)) || (any(size(matrix) ~= size(Tms)) && numel(Tms == 1))
        error('Matrices must be same size.')
    end
    checking = ~unupdated;
    if numel(Tms) == 1
        unupdated(checking) = unupdated(checking) | (matrix(checking) > Tms);
    else
        unupdated(checking) = unupdated(checking) | (matrix(checking) > Tms(checking));
    end
end