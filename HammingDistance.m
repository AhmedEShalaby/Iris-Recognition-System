function distance = HammingDistance(codeA, codeB)
    % HAMMING_DISTANCE calculates the Hamming distance between two iris codes.
    %
    %   distance = HAMMING_DISTANCE(codeA, codeB) calculates the Hamming distance
    %   between the logical vectors or strings codeA and codeB representing iris codes.
    %   The function returns the Hamming distance as a scalar value.
    %
    %   Inputs:
    %   codeA - The first iris code, a logical vector or string containing 0s and 1s.
    %   codeB - The second iris code, a logical vector or string containing 0s and 1s.
    %
    %   Output:
    %   distance - The Hamming distance between codeA and codeB.
    
    % Input validation
    if (~islogical(codeA) && ~islogical(codeB))
        error('Invalid input: Iris codes must be logical vectors or strings containing 0s and 1s.');
    end

    % Ensure both inputs are logical vectors
    codeA_logical = codeA;
    codeB_logical = codeB;

    % Get the size of both arrays
    size1 = size(codeB_logical);
    size2 = size(codeA_logical);
        
    % Find the maximum size in each dimension
    max_size = max([size1; size2], [], 1);
    
    % Calculate the padding width for each dimension
    pad_width = max_size - min([size1; size2], [], 1);

    % Pad arrays with zeros to ensure they have the same size
    [rT, cT] = size(codeB_logical);
    [rI, cI] = size(codeA_logical);

    if rT < rI  
        padded_arr1 = padarray(codeB_logical, [pad_width(1), 0], 1, 'pre');
        codeB_logical = padded_arr1;
    else
        padded_arr2 = padarray(codeA_logical, [pad_width(1), 0], 1, 'pre');
        codeA_logical = padded_arr2;
    end

    if cT < cI  
        padded_arr1 = padarray(codeB_logical, [0, pad_width(2)], 1, 'pre');
        codeB_logical = padded_arr1;
    else
        padded_arr2 = padarray(codeA_logical, [0, pad_width(2)], 1, 'pre');
        codeA_logical = padded_arr2;
    end
    
    % Flatten the matrices into vectors and convert to double
    vector1 = codeA_logical(:);
    vector2 = codeB_logical(:);

    % Calculate XOR operation and sum the differing bits to get the distance
    distance = xor(vector1, vector2);
    distance = sum(distance);
end
