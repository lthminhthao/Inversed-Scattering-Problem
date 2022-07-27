function [ outputMatrix ] = vectorToMatrix( inputVector )
    vectorLength = length(inputVector);

    outputMatrix = zeros(vectorLength);

    for index = 1:vectorLength
        outputMatrix(index, index) = inputVector(index);
    end
end
