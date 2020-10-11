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
####################################
## RUN CYCLE 0 A : 0
###################################
## Mesh, BC and IC preparation
topoSet
changeDictionary
## Parallel calculation preparation
decomposePar
## run
mpirun -np $SLURM_NTASKS $OF_APP -parallel > logfile 2>&1
## construction of the latest time results required for next phase simulation
reconstructPar -latestTime
## save results in a specific directory and preparation for the next phase
mkdir resu-cycle-0
mv 0 processor* logfile postProcessing resu-cycle-0
cp -r constant Allrun* system resu-cycle-0
#
####################################
## RUN CYCLE 0 B : 0.03
####################################
## get New BC for phase B from preprocess directory
cp ../preprocess/CV2cyclefiles/changeDictionaryDict-0.03 system/changeDictionaryDict
cp ../preprocess/CV2cyclefiles/CV2inoutBC-0.03.csv system/CV2inoutBC.csv
cp ../preprocess/CV2cyclefiles/CV2param-0.03 constant/CV2param
## change the final time simulation
FILE=system/controlDict
STARTTIME="endTime         0.030;"
ENDTIME="endTime         0.125;"
sed -i "s/${STARTTIME}/${ENDTIME}/" $FILE
## apply new BC keeping internal field
changeDictionary
## Parallel calculation preparation
decomposePar
## run
mpirun -np $SLURM_NTASKS $OF_APP -parallel > logfile 2>&1
## construction of the latest time results required for next cycle simulation
reconstructPar -latestTime
## save results in a specific directory and preparation for the next cycle
mkdir resu-cycle-0.03
mv 0.03 processor* logfile postProcessing resu-cycle-0.03
cp -r constant Allrun* system resu-cycle-0.03
###################################
## RUN CYCLE 1 A : 0.125
####################################
### get New BC for phase A from preprocess directory
cp ../preprocess/CV2cyclefiles/changeDictionaryDict-0.125 system/changeDictionaryDict
cp ../preprocess/CV2cyclefiles/CV2inoutBC-0.125.csv system/CV2inoutBC.csv
cp ../preprocess/CV2cyclefiles/CV2param-0.125 constant/CV2param
### change the final time simulation
FILE=system/controlDict
STARTTIME="endTime         0.125;"
ENDTIME="endTime         0.155;"
sed -i "s/${STARTTIME}/${ENDTIME}/" $FILE
## apply new BC keeping internal field
changeDictionary
## Parallel calculation preparation
decomposePar
## run
mpirun -np $SLURM_NTASKS $OF_APP -parallel > logfile 2>&1
## construction of the latest time results required for next cycle simulation
reconstructPar -latestTime
## save results in a specific directory and preparation for the next cycle
mkdir resu-cycle-0.125
mv 0.125 processor* logfile postProcessing resu-cycle-0.125
cp -r constant Allrun* system resu-cycle-0.125
#
###################################
### RUN CYCLE 1 B : 0.155
#####################################
#
### get New BC for phase A from preprocess directory
cp ../preprocess/CV2cyclefiles/changeDictionaryDict-0.155 system/changeDictionaryDict
cp ../preprocess/CV2cyclefiles/CV2inoutBC-0.155.csv system/CV2inoutBC.csv
cp ../preprocess/CV2cyclefiles/CV2param-0.155 constant/CV2param
#### change the final time simulation
FILE=system/controlDict
STARTTIME="endTime         0.155;"
ENDTIME="endTime         0.250;"
sed -i "s/${STARTTIME}/${ENDTIME}/" $FILE
### apply new BC keeping internal field
changeDictionary
### Parallel calculation preparation
decomposePar
### run
mpirun -np $SLURM_NTASKS $OF_APP -parallel > logfile 2>&1
### construction of the latest time results required for next cycle simulation
reconstructPar -latestTime
### save results in a specific directory and preparation for the next cycle
mkdir resu-cycle-0.155
mv 0.155 processor* logfile postProcessing resu-cycle-0.155
cp -r constant Allrun* system resu-cycle-0.155
#
##################################
### RUN CYCLE 2 A : 0.250
#####################################
#
### get New BC for phase A from preprocess directory
cp ../preprocess/CV2cyclefiles/changeDictionaryDict-0.250 system/changeDictionaryDict
cp ../preprocess/CV2cyclefiles/CV2inoutBC-0.25.csv system/CV2inoutBC.csv
cp ../preprocess/CV2cyclefiles/CV2param-0.250 constant/CV2param
#### change the final time simulation
FILE=system/controlDict
STARTTIME="endTime         0.250;"
ENDTIME="endTime         0.280;"
sed -i "s/${STARTTIME}/${ENDTIME}/" $FILE
#
### apply new BC keeping internal field
changeDictionary
### Parallel calculation preparation
decomposePar
### run
mpirun -np $SLURM_NTASKS $OF_APP -parallel > logfile 2>&1
## construction of the latest time results required for next cycle simulation
reconstructPar -latestTime
## save results in a specific directory and preparation for the next cycle
mkdir resu-cycle-0.250
mv 0.25 processor* logfile postProcessing resu-cycle-0.250
cp -r constant Allrun* system resu-cycle-0.250
#
#
##################################
### RUN CYCLE 2 B : 0.280
###################################
#
### get New BC for phase A from preprocess directory
cp ../preprocess/CV2cyclefiles/changeDictionaryDict-0.280 system/changeDictionaryDict
cp ../preprocess/CV2cyclefiles/CV2inoutBC-0.28.csv system/CV2inoutBC.csv
cp ../preprocess/CV2cyclefiles/CV2param-0.280 constant/CV2param
### change the final time simulation
FILE=system/controlDict
STARTTIME="endTime         0.280;"
ENDTIME="endTime         0.375;"
sed -i "s/${STARTTIME}/${ENDTIME}/" $FILE
### apply new BC keeping internal field
changeDictionary
### Parallel calculation preparation
decomposePar
### run
mpirun -np $SLURM_NTASKS $OF_APP -parallel > logfile 2>&1
## construction of the latest time results required for next cycle simulation
reconstructPar -latestTime
## save results in a specific directory and preparation for the next cycle
mkdir resu-cycle-0.280
mv 0.28 processor* logfile postProcessing resu-cycle-0.280
cp -r constant Allrun* system resu-cycle-0.280
#
