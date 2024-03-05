function transient_flowline_extraction(md, exp_file,res)
sz= size(md.results.TransientSolution);
data = [];
gl = [];
thickness = [];
time=[];
for t = 1:sz(2)
    disp(t);
    [~,~,~,~,~,data(:,t)]=SectionValues(md,md.results.TransientSolution(t).Vel,exp_file,res);
    [~,~,~,~,~,gl(:,t)]=SectionValues(md,md.results.TransientSolution(t).MaskOceanLevelset,exp_file,res);
    [~,~,~,~,~,thickness(:,t)]=SectionValues(md,md.results.TransientSolution(t).Thickness,exp_file,res);
    [~,~,~,~,~,surface(:,t)]=SectionValues(md,md.results.TransientSolution(t).Surface,exp_file,res);
    [~,~,~,~,~,base(:,t)]=SectionValues(md,md.results.TransientSolution(t).Base,exp_file,res);
    time =[time t];
end
model_name= md.miscellaneous.name;
[~, basename, ~] = fileparts(exp_file);
dataOut = array2table(data, 'VariableNames', string(time));
glOut = array2table(gl, 'VariableNames', string(time));
thicknessOut = array2table(thickness, 'VariableNames', string(time));
surfaceOut= array2table(surface, 'VariableNames', string(time));
baseOut= array2table(base, 'VariableNames', string(time));
directory = 'Data/Tables';
if ~exist(directory, 'dir')
    mkdir(directory);
end
filename = fullfile(directory, sprintf('%s_temporalVelocity_%s.csv', basename,model_name));

writetable(dataOut, filename);

filename = fullfile(directory, sprintf('%s_temporalGl_%s.csv', basename,model_name));
writetable(glOut,filename);
filename = fullfile(directory, sprintf('%s_temporalThickness_%s.csv', basename,model_name));
writetable(thicknessOut, filename);
filename = fullfile(directory, sprintf('%s_temporalSurface_%s.csv', basename,model_name));
writetable(surfaceOut, filename);
filename = fullfile(directory, sprintf('%s_temporalBase_%s.csv', basename,model_name));
writetable(baseOut, filename);
