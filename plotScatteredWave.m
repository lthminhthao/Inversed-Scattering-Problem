function [ ] = plotScatteredWave( X, Y, initialWave, finalWave )
    scatteredWave = finalWave - initialWave;

    surf(X, Y, scatteredWave);
end
