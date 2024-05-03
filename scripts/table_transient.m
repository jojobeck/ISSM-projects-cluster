function resultTable = create_table(md, varargin)
    addpath('../scripts/');
    % Parse optional input arguments
    options = pairoptions(varargin{:});
    msk_in = getfieldvalue(options, 'mask', md.mask.ice_levelset);
    msk_gl = getfieldvalue(options, 'mask_element', ones(md.mesh.numberofelements,1));

    % Calculate areas, Vafl, and BMB transient
    [gr_area_t, fl_area_t, Vafl_t, BMB_t] = calc_areas_Vafl_BMB_transient(md, 'mask', msk_in);

    % Calculate SMB and Volume transient
    [SMB, V] = calc_SMB_and_Volume_transient(md, 'mask', msk_in);

    % Calculate grounding line flux transient
    % gl_flux = gccalc_GroundingLineFlux_transient(md, 'mask_element', msk_gl);
    % gl_flux = calc_GroundingLineFLux_transient(md,'mask_element',msk_gl);
    gl_flux = calc_only1GroundingLineFLux_transient(md,'mask_element',msk_gl);
    % Create a table with the results
    resultTable = table(gr_area_t, fl_area_t, Vafl_t, BMB_t, SMB, V, gl_flux, ...
        'VariableNames', {'GroundedArea', 'FloatingArea', 'Vafl', 'BMB', 'SMB', 'Volume', 'GroundingLineFlux'});
end

