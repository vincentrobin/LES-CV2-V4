#!/bin/bash
#SBATCH -J CV2
#SBATCH --nodes=10
#SBATCH --constraint=HSW24|BDW28
#SBATCH --ntasks=240
#SBATCH --ntasks-per-node=24
#SBATCH --threads-per-core=1
#SBATCH --mem=30GB
#SBATCH --time=20:00:00
#SBATCH --output CV2.output
#
module purge
module load intel/17.2
module load openmpi/intel/2.0.1
module load openfoam
source /opt/software/occigen/applications/OpenFOAM/4.1/intel/17.2/openmpi/intel/2.0.1/OpenFOAM-4.1/etc/bashrc
#
#----------------------------------------------------------
# Launch job
#----------------------------------------------------------
OF_APP=CV2Foam250620
#
##################################
### RUN CYCLE 2 B : 0.280
###################################
#
#changeDictionary
### Parallel calculation preparation
decomposePar
### run
mpirun -np $SLURM_NTASKS $OF_APP -parallel > logfile 2>&1
## construction of the latest time results required for next cycle simulation
reconstructPar -latestTime
#
