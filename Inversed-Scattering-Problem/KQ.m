function [ ] = KQ( )
    format short g
    warning off

    N = input('NHAP DO MIN "N" CUA MAT PHANG MO TA HOP DUOC CHIEU: ');
    R = input('NHAP CHU KY "R" CUA SONG TONG HOP: ');

    % 0. Calculate finalWave on a specific (X, Y) grid
    [X, Y, finalWave] = getFinalWave(N, R);

    % 1. INITIAL Wave
    figure
    initialWave = plotInitialWave(X, Y, @functionF);

    % 2. SCATTER Wave
    figure
    plotScatteredWave(X, Y, initialWave, finalWave);

    % 3. FINAL Wave
    figure
    surf(X, Y, finalWave);
end
