function [gr_area_t,fl_area_t,Vafl_t,BMB_t] = calc_areas_Vafl_BMB_transient(md,varargin)
    options = pairoptions(varargin{:});
    msk_in = getfieldvalue(options, 'mask', md.mask.ice_levelset);
    ice_levelset =msk_in;
    % Check if the necessary fields are present in md.results.TransientSolution
    if ~isfield(md.results, 'TransientSolution') || isempty(md.results.TransientSolution)
        error('TransientSolution field is missing or empty in md.results.');
    end

    sz = size(md.results.TransientSolution);
    if numel(sz) ~= 2 || sz(1) ~= 1
        error('Unexpected size of md.results.TransientSolution. Expected a 1xN cell array.');
    end

    gr_area_t = zeros(sz(2),1);
    fl_area_t = zeros(sz(2),1);
    Vafl_t = zeros(sz(2),1);
    BMB_t= zeros(sz(2),1);

    ice_levelset =msk_in;
    bathymetry = md.geometry.bed;
    rho_ice = md.materials.rho_ice;
    rho_water = md.materials.rho_water;
    for step = 1:numel(md.results.TransientSolution)


       areas = GetAreas(md.mesh.elements,md.mesh.x,md.mesh.y);
       ocean_mask=md.results.TransientSolution(step).MaskOceanLevelset;
       SurfaceOnElements= mean(md.results.TransientSolution(step).Surface(md.mesh.elements),2);
       BedOnElements = mean(bathymetry(md.mesh.elements),2);
       BmbOnElements= mean(md.results.TransientSolution(step).BasalforcingsFloatingiceMeltingRate(md.mesh.elements),2);
       ThicknessvaluesOnElements= mean(md.results.TransientSolution(step).Thickness(md.mesh.elements),2);
       total_icevolume= 0;
       totalVolume_above_flotation= 0;

       floating_bmb= 0;

       floating_area = 0;
       grounded_area = 0;
       for elem=1:md.mesh.numberofelements,
          mask = ocean_mask(md.mesh.elements(elem,: ));
          ice_mask=ice_levelset(md.mesh.elements(elem,:));
          bed = BedOnElements(elem);
          surface = SurfaceOnElements(elem);
          dh =surface-bed+min(rho_water/rho_ice*bed,0.);
          if ice_mask(1)<0 | ice_mask(2)<0 | ice_mask(3)<0, % there is some ice in there so add the values
             if mask(1)>0 & mask(2)>0 & mask(3)>0, % all grounded
                grounded_area = grounded_area + areas(elem);
                totalVolume_above_flotation= totalVolume_above_flotation+ areas(elem)*dh;
             elseif mask(1)<0 & mask(2)<0 & mask(3)<0, % all floating,
               floating_area = floating_area + areas(elem);
               floating_bmb= floating_bmb+ areas(elem)*BmbOnElements(elem);
             else
                if mask(1)*mask(2)*mask(3)>0,
                   mainlyfloating = 0 ;
                else
                   mainlyfloating = 1;
                end
                if mask(1)*mask(2)>0, % nodes 1 and 2 are similar, get points on on segement 3-1 and 3-2
                   s1 = mask(3)/(mask(3)-mask(2));
                   s2 = mask(3)/(mask(3)-mask(1));
                elseif  mask(2)*mask(3)>0, % nodes 2 and 3 are similar , get points on on segement 2-1 and 3-1
                   s1 = mask(1)/(mask(1)-mask(2));
                   s2 = mask(1)/(mask(1)-mask(3));
                elseif  mask(1)*mask(3)>0, % nodes 1 and 3 are similar
                   s1 = mask(2)/(mask(2)-mask(1));
                   s2 = mask(2)/(mask(2)-mask(3));
                else
                   error('not possible');
                end
                if mainlyfloating==1,
                   phi = (1-s1*s2);
                else
                   phi = s1*s2;
                end
                grounded_area = grounded_area + phi*areas(elem);
                floating_area = floating_area + (1-phi)*areas(elem);
                totalVolume_above_flotation= totalVolume_above_flotation+ phi*areas(elem)*dh;
                floating_bmb= floating_bmb+ (1-phi)*areas(elem)*BmbOnElements(elem);
             end
          else
             %do nothing since there is no ice
          end
       end

       floating_bmb=floating_bmb*md.materials.rho_ice/10^12;
       BMB_t(step)=floating_bmb;
       gr_area_t(step)=grounded_area;
       fl_area_t(step)=floating_area;
       Vafl_t(step)=totalVolume_above_flotation;

    end
end

