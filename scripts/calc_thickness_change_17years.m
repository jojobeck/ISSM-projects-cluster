function dhdt = calc_thickness_change_17years(md, i)
    % Calculate the rate of thickness change over 17 years
    
    % Input validation
    if nargin < 2
        error('Not enough input arguments. Please provide md and i.');
    end
    
    % Check if md is of the expected class
    if ~isa(md, 'model')
        error('Invalid md object. Please provide an object of the expected class.');
    end
    
    % Check if i is a positive integer
    if ~isnumeric(i) || ~isscalar(i) || i < 1 || mod(i, 1) ~= 0
        error('Invalid input type or value for i. Please provide a positive integer.');
    end
    
    % Check if the requested time steps are available
    numTimeSteps = numel(md.results.TransientSolution);
    if i + 17 > numTimeSteps
        error('Invalid time step index. The requested time steps are not available.');
    end
    
    % Extract thickness values
    h1 = md.results.TransientSolution(i).Thickness;
    h2 = md.results.TransientSolution(i + 17).Thickness;
    
    % Check for NaN values in thickness data
    if any(isnan(h1)) || any(isnan(h2))
        dhdt = NaN;  % Handle NaN values in thickness data
    else
        % Calculate the rate of thickness change
        dhdt = (h1 - h2) / 17;
    end
end

