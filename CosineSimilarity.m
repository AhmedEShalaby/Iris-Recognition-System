function distance = CosineSimilarity(codeA, codeB)
    % COSINE_SIMILARITY calculates the cosine similarity (or distance) between two iris codes.
    % 
    %   distance = COSINE_SIMILARITY(codeA, codeB) calculates the cosine similarity
    %   (or distance) between the logical vectors or strings codeA and codeB representing
    %   iris codes. The function returns the cosine similarity (or distance) as a scalar value.
    %
    %   Input:
    %   - codeA: Iris code A, a logical vector or string containing 0s and 1s.
    %   - codeB: Iris code B, a logical vector or string containing 0s and 1s.
    %
    %   Output:
    %   - distance: Cosine similarity (or distance) between codeA and codeB, a scalar value.

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

    [rT, cT] = size(codeB_logical);
    [rI, cI] = size(codeA_logical);

    if rT < rI  
        % Pad arrays with zeros using 'constant' mode
        padded_arr1 = padarray(codeB_logical, [pad_width(1), 0], 1, 'pre');
        codeB_logical = padded_arr1;
    else
        padded_arr2 = padarray(codeA_logical, [pad_width(1), 0], 1, 'pre');
        codeA_logical = padded_arr2;
    end

    if cT < cI  
        % Pad arrays with zeros using 'constant' mode
        padded_arr1 = padarray(codeB_logical, [0, pad_width(2)], 1, 'pre');
        codeB_logical = padded_arr1;
    else
        padded_arr2 = padarray(codeA_logical, [0, pad_width(2)], 1, 'pre');
        codeA_logical = padded_arr2;
    end

    % Calculates the Cosine distance between two iris codes (logical).
    % Flatten the matrices into vectors and convert to double
    vector1 = double(codeA_logical(:));
    vector2 = double(codeB_logical(:));

    % Calculate the dot product
    dotProduct = dot(vector1, vector2);

    % Calculate the norms of the vectors
    norm1 = norm(vector1);
    norm2 = norm(vector2);

    % Compute cosine similarity
    cosineSimilarity = dotProduct / norm1 / norm2;
    
    % Compute cosine distance
    distance = 1 - cosineSimilarity; % Correct the calculation
end
