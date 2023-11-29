function dhdt = get_smith_from_md()
%dhdt smith 2003-2019
%save dhdt from smith on model geometry thickness. because interp crashes on cluster 
md = loadmodel('Models/smith_dhdt_thickness.mat');
dhdt= md.geometry.thickness;
