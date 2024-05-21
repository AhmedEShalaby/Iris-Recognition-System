function iris_match = IrisRecognition(iris_code, template_folder)
    % IRIS_RECOGNITION performs iris recognition using Hamming distance comparison on labeled templates.
    %
    %   iris_match = IRIS_RECOGNITION(iris_code, template_folder) performs iris recognition by comparing the
    %   input iris code (logical vector) against a database of labeled templates stored in the specified
    %   folder. The function returns a boolean value indicating whether a match is found or not.
    %
    %   Input:
    %   - iris_code: Input iris code to be recognized, a logical vector.
    %   - template_folder: Path to the folder containing labeled iris templates, a string.
    %
    %   Output:
    %   - iris_match: Boolean value indicating whether a match is found (true) or not (false).

    % Input validation 
    if (~islogical(iris_code) || ~isstring(template_folder))
        error('Invalid input: Iris code must be numeric, template folder path must be a string.');
    end

    % Minimum Hamming distance threshold (adjust based on your system)
    threshold = 4000;
  
    % Initialize variables
    min_distance = Inf;
    matched_label = '';
  
    % Get a list of all template files in the folder
    template_files = dir(fullfile(template_folder, '*.mat')); % Assuming templates are stored in .mat files
  
    % Check if any templates are found
    if (isempty(template_files))
        disp('No template files found in the specified folder.');
        return;
    end
  
    % Loop through each template file
    for i = 1:length(template_files)
        template_file = fullfile(template_folder, template_files(i).name);
        
        % Read the iris code and label from the template file
        [code_db, label] = read_template(template_file);
        
        % Check if the file is a valid template (replace with your validation logic)
        if (~islogical(code_db) || ~isstring(label))
            warning(['Error reading template file: ', template_file]);
            continue; % Skip to next file if reading fails
        end
        
        % Calculate Hamming distance with current code in database
        distance = hamming_distance(iris_code, code_db);
        
        % Update minimum distance and matched info if closer match found
        if (distance < min_distance)
            min_distance = distance;
            matched_label = label;
        end
    end
  
    % Check if minimum distance is below the threshold (potential match)
    iris_match = min_distance < threshold;
    
    % Display results
    if iris_match
        disp('Iris matched!');
        disp(['Matched label:', strtok(matched_label, '_')]);
        disp(['Minimum Hamming distance: ', num2str(min_distance)]);
    else
        disp('Iris not recognized.');
        disp(distance);
    end
end
