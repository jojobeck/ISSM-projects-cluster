function dhdt_smith =get_smith(md)
% gives thickness change form smith et al
p_vel = './../Data/Fields/';
vel_set ='Smithfloatgrounded_projbedmachine.nc'
bedm = fullfile(p_vel, vel_set);
dhdt_smith = interpBedmachineAntarctica(md.mesh.x,md.mesh.y,'dh','cubic',bedm);%2003-2019

