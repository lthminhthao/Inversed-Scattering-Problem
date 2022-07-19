function [ X, Y, finalWave ] = getFinalWave( N, R )
    % 1. Prepare v_N, F and baseGrid for FourierSeries
    v_N = getNodalResultVector(N, R, @functionA , @functionF);
    integerGrid = getIntegerGrid( N );
    matrixF = createFourierTransformMatrix2D(N, R);

    % 2.1 Prepare matrix-X of X-coordinates, matrix-Y of Y-coordinates
    h = 2*R/N;
    [X, Y] = meshgrid(-R:h:R, -R:h:R);

    % 2.2 Initialize finalWave Matrix as FourierSeries' value for each (X, Y)
    shape = size(X);
    rowCount = shape(1); colCount = shape(2);    
    finalWave = zeros(rowCount, colCount);

    % 2.3 Navigates thru each position of finalWave Matrix
    %     Get the corresponding (X, Y) vector
    %     Apply FourierSeries, then insert into the matrix.
    for row = 1:rowCount
        for col = 1:colCount
            vectorX = [X(row, col) Y(row, col)];
            finalWave(row, col) = getFourierSeriesOf(N, R, v_N , matrixF, integerGrid, vectorX);
        end
    end
end
