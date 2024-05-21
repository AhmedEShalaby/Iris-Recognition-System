Iris Recognition System
Overview
The Iris Recognition System is a biometric identification project that leverages the unique patterns of the human iris to accurately identify individuals. This system utilizes the CASIA-Iris-Syn database, known for its synthetic iris images that replicate the variations and complexities found in real-world scenarios. The project encompasses the entire process from image preprocessing, feature extraction, to the final matching of iris codes.

Features
Segmentation: Accurate segmentation of the iris and pupil regions from eye images using advanced image processing techniques.
Normalization: Application of the Daugman rubber sheet model to map the segmented iris region to a normalized, rectangular block in polar coordinates.
Feature Extraction: Utilization of Haar wavelet decomposition to extract robust features from the normalized iris image.
Matching: Implementation of Hamming Distance and Cosine Similarity methods to compare iris codes and determine identity matches.
Iris Recognition Function: A comprehensive function that processes an input image, extracts its iris code, and matches it against a database to return the corresponding label.
Objectives
To provide a robust and efficient solution for biometric identification using iris patterns.
To explore and compare different methods for feature extraction and matching.
To develop an easily extensible system that can be further enhanced with additional biometric recognition techniques.
Key Components
Preprocessing:
Segmentation of the iris and pupil boundaries.
Smoothing and noise reduction using morphological operations and Gaussian filtering.
Normalization:
Mapping of iris regions from Cartesian to polar coordinates.
Feature Extraction:
Decomposition of the normalized iris image using Haar wavelets.
Combination of detail sub-bands to form the feature vector.
Matching:
Calculation of Hamming Distance for bit-wise comparison of iris codes.
Calculation of Cosine Similarity to measure directional similarity between iris code vectors.
Iris Recognition Function:
A function that takes an input eye image, segments the iris, normalizes it, extracts features, and matches the generated iris code against a precomputed database of iris codes to identify the individual.
Database
We utilized the CASIA-Iris-Syn database, available on Kaggle, which contains synthetic iris images designed for iris recognition research. From this dataset, 48 subjects were selected, with each subject having 10 images captured under different conditions.
