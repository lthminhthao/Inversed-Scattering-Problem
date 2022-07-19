function [ vectorK ] = createCutoffVector( N, R )
    baseGrid = getGridWithMesh(N, R);

    % CREATE VECTOR K^
    % Note: 1. Use 2 cursors:
    %       - cursor 1: navigates thru baseGrid, top->bottom & left->right
    %       - cursor 2: navigates top->bottom in vector-K
    %       2. Get vectorJ from cursor 1, compute its length
    %       3. Base on J-length, calculate and insert value to cursor 2
    vectorK = zeros((N+1)^2, 1);
    kIndex = 1;
    for row = 1:(N+1)
        for col = 1:(N+1)
            % 1. Get vectorJ from baseGrid, calculate jLength
            vectorJ = baseGrid{row, col};
            jX = vectorJ(1);
            jY = vectorJ(2);
            jLength = sqrt(jX^2 + jY^2);

            % 2. Conditionally calculate value at kIndex
            if jLength == 0                
                vectorK(kIndex, 1) = -1/(2*R) + (pi*1i/4) * besselh(1, 1, R);
            elseif jLength == R/pi
                coeff1 = 1/8*pi*1i*R;
                leftTerm = besselj(0, R) * besselh(0, 1, R);
                rightTerm = besselj(1, R) * besselh(1, 1, R);

                vectorK(kIndex, 1) = coeff1 * (leftTerm + rightTerm);
            else
                coeff2 = R^2 / ((pi^2*jLength^2 - R^2) * 2*R);
                minuend = pi*jLength * besselj(1, pi*jLength) * besselh(0, 1, R);
                subtrahend = R * besselj(0, pi) * besselh(1, 1, R);

                vectorK(kIndex, 1) = coeff2 * (1 + 1/2*1i*pi * (minuend-subtrahend));
            end

            % 3. Move kIndex down
            kIndex = kIndex + 1;
        end
    end
end
