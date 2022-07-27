function [ output ] = functionF( x, y )
    k = 15.05;
    unit = sqrt(2)/2;

    output = exp( 1i*k * unit*(x - y) );
end
