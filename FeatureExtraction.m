function iris_code = FeatureExtraction(normalizedIris)
    % FeatureExtraction - Extracts features from the normalized iris region
    %
    % Syntax: iris_code = FeatureExtraction(normalizedIris)
    %
    % Inputs:
    %   normalizedIris - The normalized iris region
    %
    % Outputs:
    %   iris_code - The generated iris code

    % Apply Haar wavelet decomposition (3rd level)
    [CAn, CHn, CVn, CDn] = dwt2(normalizedIris, 'haar', 'level', 3);

    % Extract detail sub-bands (HL, LH, and HH)
    HL = CHn;
    LH = CVn;
    HH = CDn;

    % Combine detail sub-bands for feature extraction
    waveletFeatures = HL + LH + HH;

    % Apply thresholding to generate binary iris code
    iris_code = waveletFeatures >= 0;
end
