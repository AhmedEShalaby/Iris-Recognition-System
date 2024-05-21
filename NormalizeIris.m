function normalizedIris = NormalizeIris(iris_image, iris_center, iris_radii, pupil_center, pupil_radii, numRadialSamples, numAngularSamples)
    % NormalizeIris - Normalizes the iris image using Daugman's Rubber-Sheet Model
    %
    % Syntax: normalizedIris = NormalizeIris(iris_image, iris_center, iris_radii, pupil_center, pupil_radii, numRadialSamples, numAngularSamples)
    %
    % Inputs:
    %   iris_image - The input eye image
    %   iris_center - Center coordinates of the detected iris
    %   iris_radii - Radius of the detected iris
    %   pupil_center - Center coordinates of the detected pupil
    %   pupil_radii - Radius of the detected pupil
    %   numRadialSamples - Number of radial samples
    %   numAngularSamples - Number of angular samples
    %
    % Outputs:
    %   normalizedIris - The normalized iris image

    % Initialize normalized iris image and mask
    normalizedIris = zeros(numRadialSamples, numAngularSamples);

    % Convert the centers and radii to double
    iris_center = double(iris_center);
    pupil_center = double(pupil_center);
    iris_radii = double(iris_radii);
    pupil_radii = double(pupil_radii);

    % Get the size of the iris image
    [rows, cols] = size(iris_image);

    for r = 1:numRadialSamples
        for theta = 1:numAngularSamples
            angle = (theta / numAngularSamples) * 2 * pi;
            radius = pupil_radii + ((r / numRadialSamples) * (iris_radii - pupil_radii));

            x = pupil_center(1) + radius * cos(angle);
            y = pupil_center(2) + radius * sin(angle);

            % Round coordinates and check bounds
            x = round(x);
            y = round(y);

            if x >= 1 && x <= cols && y >= 1 && y <= rows
                normalizedIris(r, theta) = iris_image(y, x);
            end
        end
    end
end
