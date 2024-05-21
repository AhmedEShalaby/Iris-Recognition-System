function [iris_center, iris_radii, pupil_center, pupil_radii] = IrisSegmentation(Img)
    % IrisSegmentation - Segments the iris and pupil from an eye image
    %
    % Syntax: [iris_center, iris_radii, pupil_center, pupil_radii] = IrisSegmentation(Img)
    %
    % Inputs:
    %   Img - The input eye image
    %
    % Outputs:
    %   iris_center - Center coordinates of the detected iris
    %   iris_radii - Radius of the detected iris
    %   pupil_center - Center coordinates of the detected pupil
    %   pupil_radii - Radius of the detected pupil

    if ndims(Img) == 3 && size(Img, 3) == 3
        % Convert RGB image to grayscale
        eyeImage = im2gray(Img);
    end

    % Define the structuring element for morphological operations
    se = strel('disk', 10);

    % Invert the image
    invertedImage = imcomplement(eyeImage);

    % Perform morphological opening followed by closing to remove noise and smooth the image
    closedImage = imclose(invertedImage, se);

    % Smooth the inverted image using a Gaussian filter
    smoothedImage = imgaussfilt(closedImage, 3);

    % Find edges using Canny edge detection
    edges = edge(smoothedImage, 'canny', []);

    % Define parameters for Circular Hough Transform for iris/sclera boundary
    irisRadiiRange = [85 130];
    irisSensitivity = 0.98; % Sensitivity parameter for detecting circles

    % Define parameters for Circular Hough Transform for pupil boundary
    pupilRadiiRange = [25 100];
    pupilSensitivity = 0.88; % Sensitivity parameter for detecting circles

    % Find iris/sclera boundary circles
    [iris_centers, iris_radiis] = imfindcircles(edges, irisRadiiRange, 'Sensitivity', irisSensitivity);

    % Find pupil boundary circles
    [pupil_centers, pupil_radiis] = imfindcircles(edges, pupilRadiiRange, 'Sensitivity', pupilSensitivity);

    % Check if pupil circles are detected
    if ~isempty(pupil_centers)
        % Calculate the distance between each detected iris circle center and the pupil circle center
        distances = sqrt((iris_centers(:, 1) - pupil_centers(1)).^2 + (iris_centers(:, 2) - pupil_centers(2)).^2);

        % Find the index of the iris circle with the minimum distance to the pupil circle center
        [~, minIndex] = min(distances);

        % Select the iris circle closest to the pupil circle center
        iris_center = iris_centers(minIndex, :);
        iris_radii = iris_radiis(minIndex);

        % Calculate distances between iris centers and pupil center
        distances = sqrt((pupil_centers(:, 1) - iris_center(1)).^2 + (pupil_centers(:, 2) - iris_center(2)).^2);
            
        % Find the closest iris circle
        [~, minIndex] = min(distances);
        pupil_center = pupil_centers(minIndex, :);
        pupil_radii = pupil_radiis(minIndex);
        
    else
        disp('Pupil circle not detected.');
        iris_center = [];
        iris_radii = [];
        pupil_center = [];
        pupil_radii = [];
    end    
end
