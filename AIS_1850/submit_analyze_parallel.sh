#PBS -S /bin/bash                                                                                                                                                                                                                                                           
#PBS -P au88
#PBS -q normal
#PBS -l ncpus=16
#PBS -l walltime=1:00:00
#PBS -l mem=190GB
#PBS -l jobfs=200GB
#PBS -M johanna.beckmann@monash.edu
#PBS -l wd
#PBS -l software=matlab_monash
#PBS -o Analyze.outlog
#PBS -e Analyze.errlog
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

step=[5]
# matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, run('analyze_clim_fun(${step},${PBS_NCPUS})') , quit" > Analyze.log
# matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS' run('post_analyze_clim(${step})') , quit" > PostAnalyze.log
# matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, run('post_analyze_clim(${step})') , quit" > PostAnalyze.log
matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, run('analyze_clim_fun(${step})') , quit" > PostAnalyze.log
# matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, run('analyze_hist2_fun(${step},${PBS_NCPUS})') , quit" > Analyze.log
