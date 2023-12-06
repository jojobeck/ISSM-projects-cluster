#PBS -S /bin/bash                                                                                                                                                                                                                                                           
#PBS -P bi77
#PBS -q normal
#PBS -l ncpus=4
#PBS -l walltime=12:05:00
#PBS -l mem=190GB
#PBS -l jobfs=200GB
#PBS -M johanna.beckmann@monash.edu
#PBS -l wd
#PBS -l software=matlab_monash
#PBS -o Analyze.outlog
#PBS -e Analyze.errlog
#PBS -l storage=gdata/bi77

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
# matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, run('analyze_hist2_fun(${step})') , quit" > Analyze.log
# matlab -nosplash -singleCompThread < analyze_script.m > /scratch/bi77/jb1863/$PBS_JOBID,ananlyze.log
# argName='$arg'
matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, run('analyze_hist2_fun(${step},${PBS_NCPUS})') , quit" > Analyze.log
# matlab numberOfWorkers-nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, analyze_hist2_fun , quit" > Analyze.log

#####PBS -l nnodes=1
###PBS -l ncpus_per_node=4
