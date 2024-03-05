

function save_table_basin(md, num)
    addpath('../scripts');
    msk_gl = mask_basin_id(md, num);
    basinelelemt = mean(msk_gl(md.mesh.elements), 2);
    msk_gl = mask_basin_id(md, num, 1);

    % Create the table using your create_table function
    resultTable = table_transient(md, 'mask', msk_gl, 'mask_element', basinelelemt);

    % Extract the basin name from md.miscellaneous.name
    basinName = md.miscellaneous.name;

    % Replace invalid characters in the filename
    % basinName = strrep(basinName, ' ', '_'); % Replace spaces with underscores
    % basinName = regexprep(basinName, '[^\w_.-]', ''); % Remove invalid characters

    % Save the table to the 'Data/Tables' directory with the basin name and number
    directory = 'Data/Tables';
    if ~exist(directory, 'dir')
        mkdir(directory);
    end

    filename = fullfile(directory, sprintf('AggregatedValues_%s_basin_%d.csv', basinName, num));
    writetable(resultTable, filename);
end

