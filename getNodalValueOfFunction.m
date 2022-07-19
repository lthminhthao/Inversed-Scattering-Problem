function [ nodalVector ] = getNodalValueOfFunction( N, R, func )
    % 1. BUILD THE (N+1) x (N+1) NODAL GRID
    % Note: 1. Create an N-mesh baseGrid
    %       2. Apply the target function to each vector in the baseGrid
    %          => nodalGrid
    baseGrid = getGridWithMesh(N, R);
    nodalGrid = zeros(N+1, N+1);
    for row = 1:(N+1)
        for col = 1:(N+1)
            coordinate_vector = baseGrid{row, col};
            x = coordinate_vector(1);
            y = coordinate_vector(2);

            nodalGrid(row, col) = func(x, y);
        end
    end

    % 2. BUILD THE NODAL VECTOR
    % Note: runs 2 cursors at a same-time:
    %       - cursor 1 reads the grid: left->right & top->bottom
    %       - cursor 2 reads the vector: top->bottom
    nodalVector = zeros((N+1)^2, 1);
    vectorIndex = 0;
    for row = 1:(N+1)
        for col = 1:(N+1)
            vectorIndex = vectorIndex + 1;
            nodalVector(vectorIndex, 1) = nodalGrid(row, col);
        end
    end
end
