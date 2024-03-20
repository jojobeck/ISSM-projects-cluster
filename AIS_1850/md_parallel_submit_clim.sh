#PBS -S /bin/bash                                                                                                                                                                                                                                                           
#PBS -P au88
#PBS -q normal
#PBS -l ncpus=48
#PBS -l walltime=05:00:00
#PBS -l mem=190GB
#PBS -l jobfs=200GB
#PBS -M johanna.beckmann@monash.edu
#PBS -l wd
#PBS -l software=matlab_monash
#PBS -o HistSubmitclim.outlog
#PBS -e HistSubmitclim.errlog
#PBS -l storage=gdata/au88

export ISSM_DIR=/home/565/jb1863/trunk
source $ISSM_DIR/etc/environment.sh
module purge
module load openmpi/4.1.3
module load netcdf/4.8.0p
module load hdf5/1.10.7p
module load petsc/3.17.4
module load matlab/R2021b
# module load python3/3.11.0
module load matlab_licence/monash
# source $ISSM_DIR/scripts/startup.sh
# step=[17,27,7]
step=[32,33,34,35,36]
step=[35]
# stephist1=[7,8]
# stephist2=[5]
# step=[5,6,7,8]

matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, run('hist_clim_func(${step},1)') , quit" > Hist2Submitclim.log
# matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, run('hist1_from_1850climmean_func(${stephist1},0)') , quit" > Hist1fromClimSubmit.log

# matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, run('hist2_func(${stephist2},1)') , quit" > Hist2Submit.log
##################################
# matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, hist2_script, quit" > Hist2Submit.log
# matlab -nodisplay -nosplash -r "outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, /home/565/jb1863/SAEF/issm_projects/AIS_1850/parallel_hist_script.m, quit" > $PBS_JOBID.log
# matlab  -nodesktop -nosplash -r -singleCompThread "outputDir='$PBS_JOBFS', hist_script.m, quit" > $PBS_JOBID.log
# matlab  -nodesktop -nosplash -r "addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, hist_script.m, quit" > $PBS_JOBID.log
