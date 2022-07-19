function [ integerGrid ] = getIntegerGrid( N )
    integerGrid = cell(N+1, N+1);

    % 1. Start from the "extra-top-left" point of the grid
    % Note: This point is the point "immediately" above the top-left point
    baseX = -N/2;
    baseY = N/2 + 1;

    % 2. BUILD THE INTEGER GRID
    % Note: FOR EACH ROW OF THE GRID:
    %       1. Move coordinate-Y DOWN by 1 => baseY
    %       2. Insert (X, Y) to column 1 of CURRENT ROW.
    %
    %       3. FOR EACH COLUMN >=2 OF THE CURRENT ROW:
    %          4. Move coordinate-X RIGHT by 1 => curX
    %          5. Insert (X, Y) to CURRENT COLUMN of CURRENT ROW.
    for row = 1:(N+1)
        baseY = baseY - 1;
        integerGrid{row, 1} = [baseX baseY];

        for col = 2:(N+1)
            curX = baseX + (col-1);
            integerGrid{row, col} = [curX baseY];
        end
    end
end
