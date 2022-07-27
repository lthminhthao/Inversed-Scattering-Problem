function [ output ] = functionA( x, y )
    if x^2 + y^2 <= 0.75^2
        output = 1;
    else
        output = 0;
    end
end
