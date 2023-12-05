#PBS -S /bin/bash                                                                                                                                                                                                                                                           
#PBS -P bi77
#PBS -q normal
#PBS -l ncpus=1
#PBS -l walltime=00:05:00
#PBS -l mem=190GB
#PBS -l jobfs=200GB
#PBS -M johanna.beckmann@monash.edu
#PBS -l wd
#PBS -l software=matlab_monash
#PBS -o c1Analyze.outlog
#PBS -e c1Analyze.errlog
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

# argName='$arg'
# matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, analyze_hist2_fun , quit" > c1Analyze.log
matlab -nodisplay -nosplash -r " addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib" -singleCompThread <analyze_hist2_script.m > c1Analyze.log
# matlab -nosplash -singleCompThread < analyze_script.m > /scratch/bi77/jb1863/$PBS_JOBID,ananlyze.log
