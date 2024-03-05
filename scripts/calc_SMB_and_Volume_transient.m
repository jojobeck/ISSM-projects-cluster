function [SMB_t,Vol_t] = calc_SMB_and_Volume_transient(md, varargin)
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

    SMB_t = zeros(sz(2),1);
    Vol_t = zeros(sz(2),1);
    % ice_levelset =reinitializelevelset(md,md.mask.ice_levelset);
    for step = 1:numel(md.results.TransientSolution)

       areas = GetAreas(md.mesh.elements,md.mesh.x,md.mesh.y);

       ThicknessvaluesOnElements= mean(md.results.TransientSolution(step).Thickness(md.mesh.elements),2);
       SMBvaluesOnElements= mean(md.results.TransientSolution(step).SmbMassBalance(md.mesh.elements),2);
       total_icevolume= 0;
       total_smb= 0;
       for elem=1:md.mesh.numberofelements,
          ice_mask=ice_levelset(md.mesh.elements(elem,:));
          if ice_mask(1)<0 & ice_mask(2)<0 & ice_mask(3)<0, % there is everywhere ice in there so add the values
                total_smb= total_smb+ areas(elem)*SMBvaluesOnElements(elem);
                total_icevolume=total_icevolume+ areas(elem)*ThicknessvaluesOnElements(elem);
          elseif ice_mask(1)>0 & ice_mask(2)>0 & ice_mask(3)>0,
             %do nothing since there is no ice
          else
            if ice_mask(1)*ice_mask(2)*ice_mask(3)<0,
               mainlyice= 1 ;
            else
               mainlyice= 0;
            end
            if ice_mask(1)*ice_mask(2)>0, % nodes 1 and 2 are similar
                s1 =ice_mask(3)/(ice_mask(3)-ice_mask(2));
                s2 =ice_mask(3)/(ice_mask(3)-ice_mask(1));
            elseif ice_mask(2)*ice_mask(3)>0, % nodes 2 and 3 are similar
                s1 =ice_mask(1)/(ice_mask(1)-ice_mask(2));
                s2 =ice_mask(1)/(ice_mask(1)-ice_mask(3));
            elseif ice_mask(1)*ice_mask(3)>0, % nodes 1 and 3 are similar
                s1 =ice_mask(2)/(ice_mask(2)-ice_mask(1));
                s2 =ice_mask(2)/(ice_mask(2)-ice_mask(3));
            else
                error('not possible');
            end
            if mainlyice==1,
               phi = (1-s1*s2);
            else
                phi = s1*s2;
            end
             total_smb = total_smb + (phi)*areas(elem)*SMBvaluesOnElements(elem);
             total_icevolume=total_icevolume+ (phi)*areas(elem)*ThicknessvaluesOnElements(elem);
          end
       end
       total_smb=total_smb*md.materials.rho_ice/10^12;
       SMB_t(step)=total_smb;
       Vol_t(step)=total_icevolume;
    end
 end
