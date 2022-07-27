function [ value ] = getFourierSeriesOf( N, R, v_N , matrixF, integerGrid, vectorX )
    % 1. Get Fourier's Coeff Vector (v^)
    vhat = matrixF * v_N;

    % 2. Calculate the final value:
    % - Start from 0
    % - Each time:
    %   + find the corresponding point J in integerGrid
    %   + calculate the dot-product of J and X
    %   + calculate the new term, multiply it with current v^
    %   + add result to final value
    value = 0;
    for vIndex = 1:(N+1)^2
        posVectorJ = getCoordinate(vIndex, N+1);
        vectorJRow = posVectorJ(1); vectorJCol = posVectorJ(2);
        vectorJ = integerGrid{vectorJRow, vectorJCol};

        term = (1/(2*R)) * exp( (1i*pi/R) * dot(vectorJ, vectorX) );
        value = value + vhat(vIndex)*term;
    end

    value = real(value);
end

function coordinate = getCoordinate(index, size)
    row = ceil(index/size);
    col = mod(index, size);
    if col == 0
        col = size;
    end

    coordinate = [row col];
end