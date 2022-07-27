function[ initialWave ] = plotInitialWave( X, Y, func )
    initialWave = real(func(X, Y));

    surf(X, Y, initialWave);
end
