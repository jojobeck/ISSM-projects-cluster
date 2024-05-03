#PBS -S /bin/bash                                                                                                                                                                                                                                                           
#PBS -P au88
#PBS -q normal
#PBS -l ncpus=1
#PBS -l walltime=04:00:00
#PBS -l mem=190GB
#PBS -l jobfs=200GB
#PBS -M johanna.beckmann@monash.edu
#PBS -l wd
#PBS -l software=matlab_monash
#PBS -o PlotAnalyze.outlog
#PBS -e PlotAnalyze.errlog
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

step=[1]
# step=3
# matlab -nosplash -singleCompThread < analyze_script.m > /scratch/bi77/jb1863/$PBS_JOBID,ananlyze.log
# argName='$arg'
# matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, run('plot_test') , quit" > Plot_Analyze_${PBS_JOBID}.log
matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, run('plot_test_functions(${step},1)') , quit" > PlotAnalyze.log
# matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, analyze_script , quit" > Analyze_${PBS_JOBID}.log