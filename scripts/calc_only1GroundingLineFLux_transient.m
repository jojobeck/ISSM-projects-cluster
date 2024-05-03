function gl_flx = calc_only1GroundingLineFlux_transient(md,varargin)
    % Parse optional input arguments
    %funciton claculated flu of longgest gounding line  we should only omit pinning points, so check if the first entry after a 'nan' and then the last before the next 'nan' are actually neighbours or not.
    options = pairoptions(varargin{:});
    msk_gl = getfieldvalue(options, 'mask_element', ones(md.mesh.numberofelements,1 )  );
    % Check if the necessary fields are present in md.results.TransientSolution
    if ~isfield(md.results, 'TransientSolution') || isempty(md.results.TransientSolution)
        error('TransientSolution field is missing or empty in md.results.');
    end

    sz = size(md.results.TransientSolution);
    if numel(sz) ~= 2 || sz(1) ~= 1
        error('Unexpected size of md.results.TransientSolution. Expected a 1xN cell array.');
    end

    gl_flx = zeros(sz(2),1);
    for step = 1:numel(md.results.TransientSolution)

       %Get Grounding line segments for this step
       gl1= my_isoline(md, md.results.TransientSolution(step).MaskOceanLevelset, 'value', 0, 'output','matrix','mask',msk_gl);

       %Get speed and thickness for this step at the segment extremities
       vx = InterpFromMesh2d(md.mesh.elements,md.mesh.x,md.mesh.y,md.results.TransientSolution(step).Vx,gl1(:,1),gl1(:,2));
       vy = InterpFromMesh2d(md.mesh.elements,md.mesh.x,md.mesh.y,md.results.TransientSolution(step).Vy,gl1(:,1),gl1(:,2));
       h  = InterpFromMesh2d(md.mesh.elements,md.mesh.x,md.mesh.y,md.results.TransientSolution(step).Thickness,gl1(:,1),gl1(:,2));
       % groudnignline segments are cut with nans,so let us get longest groudning line segment                                                                                                                        
       nan_indices = find(isnan(gl1(:, 1)));
       sz = size(nan_indices);
       if sz(1)>1,
        
           %add 0 nan to start first segement count later
           nan_indices = [0; nan_indices];
           % get length between nans,subtract exta 1 becsuse we have 2 nans :
           nan_indices_length =  nan_indices(2:end) - nan_indices(1:end-1)-1;
           max_in = find(max(nan_indices_length)==nan_indices_length);
           start_i =nan_indices(max_in)+1;%start one after the nan entry
        else
            start_i=1
        end

        
       %Compute flux for each segments
       flux = 0;
       % for i=1:size(gl1,1)-1
       for i=start_i:size(gl1,1) -start_i
          if isnan(gl1(i+1,1))
             break
          end
          x1 = gl1(i,  1); y1 = gl1(i,  2);
          x2 = gl1(i+1,1); y2 = gl1(i+1,2);

          lx = -(y1-y2); ly = x1-x2;
          L  = sqrt(lx^2 + ly^2);
          Nx=lx./L; Ny=ly./L;

          Vx=(vx(i)+vx(i+1))/2;
          Vy=(vy(i)+vy(i+1))/2;
          H =(h(i) +h( i+1))/2;
          secflux = H.*(Vx.*Nx+Vy.*Ny).*L;

          flux = flux + secflux;
       end

       %Convert form volume to mass in Gt/yr
       flux = flux*md.materials.rho_ice/10^12;
       gl_flx(step)=abs(flux);

    end
end
