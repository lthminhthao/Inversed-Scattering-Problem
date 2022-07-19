function [ baseGrid ] = getGridWithMesh( N, R )
    baseGrid = cell(N+1, N+1);

    % 1. Start from the "extra-top-left" point of the square
    % Note: This point is the point "immediately" above the top-left point
    %       (with a distance of 2*R/N).
    baseX = -R;
    baseY = R + 2*R/N;

    % 2. BUILD THE BASE GRID
    % Note: FOR EACH ROW OF THE GRID:
    %       1. Move coordinate-Y DOWN by a unit (2*R/N) => baseY
    %       2. Insert (X, Y) to column 1 of CURRENT ROW.
    %
    %       3. FOR EACH COLUMN >=2 OF THE CURRENT ROW:
    %          4. Move coordinate-X RIGHT by a unit (2*R/N) => curX
    %          5. Insert (X, Y) to CURRENT COLUMN of CURRENT ROW.
    for row = 1:(N+1)
        baseY = baseY - (2*R/N);
        baseGrid{row, 1} = [baseX baseY];

        for col = 2:(N+1)
            curX = baseX + (col-1) * (2*R/N);
            baseGrid{row, col} = [curX baseY];
        end
    end
end
