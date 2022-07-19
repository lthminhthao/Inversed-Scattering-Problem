function [ matrixF ] = createFourierTransformMatrix2D( N, R )
    % 1. Create an N- integerGrid
    baseIntegerGrid = getIntegerGrid(N);

    % 2. CREATE FTM 2D
    % Note: 1. Use 3 cursors:
    %       - cursor 1: insert into F, top->bottom & left->right
    %       - cursor 2: reads K for each F-row: start @1 then +1 after each row
    %       - cursor 3: reads J for each F-col:
    %                   start @1 with new-row, then +1 after each col
    %       2. Cursor 2 & Cursor 3 point to integerGrid's index
    %       3. Compute dotProduct of each (K, J) and apply the formula.
    matrixF = zeros((N+1)^2);
    vectorKIndex = 1;
    for row = 1:(N+1)^2
        posVectorK = getCoordinate(vectorKIndex, N+1);
        vectorKRow = posVectorK(1);
        vectorKCol = posVectorK(2);
        vectorK = baseIntegerGrid{vectorKRow, vectorKCol};

        vectorJIndex = 1;
        for col = 1:(N+1)^2
            posVectorJ = getCoordinate(vectorJIndex, N+1);
            vectorJRow = posVectorJ(1);
            vectorJCol = posVectorJ(2);
            vectorJ = baseIntegerGrid{vectorJRow, vectorJCol};

            dotProduct = dot(vectorK, vectorJ);
            baseValue = exp( -1i*pi * (2*dotProduct/N) );
            matrixF(row, col) = (2*R/N^2) * baseValue;

            vectorJIndex = vectorJIndex + 1;
        end

        vectorKIndex = vectorKIndex + 1;
    end
end

function coordinate = getCoordinate(index, size)
    row = ceil(index/size);
    col = mod(index, size);
    if col == 0
        col = size;
    end

    coordinate = [row col];
end
