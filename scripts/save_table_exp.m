function save_table_exp(md, expfile)

    [in_elements]=ContourToMesh(md.mesh.elements,md.mesh.x,md.mesh.y,expfile,'element',0);
    [in_nodes]=ContourToMesh(md.mesh.elements,md.mesh.x,md.mesh.y,expfile,'node',1);
    msk = mask_as_icelevelset(md,in_nodes);


    % Create the table using your create_table function
    resultTable = table_transient(md, 'mask', msk, 'mask_element',in_elements);

    % Extract the basin name from md.miscellaneous.name
    basinName = md.miscellaneous.name;

    [~, basename, ~] = fileparts(expfile);
    % Replace invalid characters in the filename
    % basinName = strrep(basinName, ' ', '_'); % Replace spaces with underscores
    % basinName = regexprep(basinName, '[^\w_.-]', ''); % Remove invalid characters
    directory = 'Data/Tables';
    if ~exist(directory, 'dir')
        mkdir(directory);
    end

    filename = fullfile(directory, sprintf('AggregatedValues_%s_Exp_area_%s.csv', basinName, basename));

    % Save the table to a CSV file with the basin name and number
    writetable(resultTable, filename);
end
