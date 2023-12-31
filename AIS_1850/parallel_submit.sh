#PBS -S /bin/bash                                                                                                                                                                                                                                                           
#PBS -P bi77
#PBS -q normal
#PBS -l ncpus=2
#PBS -l walltime=00:05:00
#PBS -l mem=10gb
#PBS -l jobfs=10GB
#PBS -M johanna.beckmann@monash.edu
#PBS -l wd
#PBS -l software=matlab_monash
#PBS -o ParllelSubmit.outlog
#PBS -e ParalleSubmit.errlog
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


# matlab -nosplash -singleCompThread < /home/565/jb1863/SAEF/issm_projects/AIS_1850/hist_script.m > /scratch/bi77/jb1863/$PBS_JOBID.log
matlab -nodisplay -nosplash -r "outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, hist2_script , quit" > ParallelSubmithist.log
# matlab -nodisplay -nosplash -r "outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, /home/565/jb1863/SAEF/issm_projects/AIS_1850/parallel_hist_script.m, quit" > $PBS_JOBID.log
# matlab  -nodesktop -nosplash -r -singleCompThread "outputDir='$PBS_JOBFS', hist_script.m, quit" > $PBS_JOBID.log
# matlab  -nodesktop -nosplash -r "addpath $ISSM_DIR/src/m/dev; devpath; addpath $ISSM_DIR/lib outputDir='$PBS_JOBFS',numberOfWorkers=$PBS_NCPUS, hist_script.m, quit" > $PBS_JOBID.log
