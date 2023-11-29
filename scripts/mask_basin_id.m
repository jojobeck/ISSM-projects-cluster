function mask = mask_basin_id(md, num)
    % Create a mask based on the specified basin ID
    
    % Input validation
    if nargin < 2
        error('Not enough input arguments. Please provide md and num.');
    end
    
    % Check if md is of the expected class
    if ~isa(md, 'model')
        error('Invalid md object. Please provide an object of the expected class.');
    end
    
    % Check if num is a positive integer
    if ~isnumeric(num) || ~isscalar(num) || num < 1 || mod(num, 1) ~= 0
        error('Invalid input type or value for num. Please provide a positive integer.');
    end
    
    % Check if the specified basin ID exists in the basalforcings
    if isempty(md.basalforcings) || isempty(md.basalforcings.basin_id)
        error('Invalid md object. Missing or empty basin_id field in basalforcings.');
    end
    
    % Create the mask based on the specified basin ID
    msk = md.basalforcings.basin_id == num;
    
    % Apply the mask to basin_id and calculate areas
    basin = md.basalforcings.basin_id;
    basin(~msk) = nan;
    areas = GetAreas(md.mesh.elements, md.mesh.x, md.mesh.y);
    
    % Create data_vertices using sparse matrix
    data_vertices = sparse(md.mesh.elements(:), ones(numel(md.mesh.elements), 1), repmat(areas .* basin, 3, 1), md.mesh.numberofvertices, 1);
    
    % Check for NaN values in data_vertices
    ms = isnan(data_vertices);
    
    % Replace NaN values with a specified basin id
    data_vertices(~ms) = num;
    
    % Create the final mask
    mask = ~ms;
end

