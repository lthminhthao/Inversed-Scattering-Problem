function [ resultVector ] = getNodalResultVector( N, R, funcA , funcF )
    % 1. Create Unit Matrix of size N
    I = eye((N+1)^2);

    % 2. Calculate a_N (nodal-value of funcA)
    % convert it to matrix
    a_N = getNodalValueOfFunction(N, R, funcA);
    a_NMatrix = vectorToMatrix(a_N);

    % 3. Calculate matrix F (Fourier Transform matrix)
    % inverse it, as well
    matrixF = createFourierTransformMatrix2D(N, R);
    inverseF = inv(matrixF);

    % 4. Calculate K^N (cutoff vector)
    % convert it to matrix
    K_N = createCutoffVector(N, R);
    K_NMatrix = vectorToMatrix(K_N);

    % 5. Calculate A, then inverse it
    A = I + a_NMatrix * inverseF * K_NMatrix * matrixF;
    inverseA = inv(A);

    % 6. Compute funcA * funcF as funcAF
    % calculate af_N (nodal value of funcAF)
    funcAF = @(x, y, R) funcA(x, y) * funcF(x, y);
    af_N = getNodalValueOfFunction(N, R, funcAF);

    % 7. Calculate resultVector = inverseA * af_N;
    resultVector = inverseA * af_N;
end
