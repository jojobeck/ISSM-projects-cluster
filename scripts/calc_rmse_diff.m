function rmse_area=calc_diff(md,diff,ice)
 % Input validation
    if nargin < 3
        error('Not enough input arguments. Please provide md, diff, and ice.');
    end


    % Check if diff and ice are numeric arrays
    if ~isnumeric(diff) || ~islogical(ice)
        error('Invalid input types for diff or ice. Please provide numeric arrays.');
    end

    % Check if diff and ice have the same size
    if ~isequal(size(diff), size(ice))
        error('Size mismatch between diff and ice arrays. Please ensure they have the same size.');
    end

    % Calculate areas
    areas = GetAreas(md.mesh.elements, md.mesh.x, md.mesh.y);

    % Check if areas and ice have the same size
% if ~isequal(size(areas), size(ice))
% error('Size mismatch between areas and ice arrays. Please ensure they have the same size.');
% end

    % Perform the calculation
    if any(isnan(areas)) || any(isnan(diff)) || any(isnan(ice))
        rmse_area = NaN;  % Handle NaN values in areas, diff, or ice
    else
        sum_areas = nansum(areas(ice));

        if sum_areas == 0
            rmse_area = NaN;  % Handle division by zero
        else
            rmse_area = sqrt(nansum(areas(ice) ./ sum_areas .* (diff(ice).^2)));
        end
    end
end
