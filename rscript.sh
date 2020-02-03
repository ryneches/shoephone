#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1 # Number of cores
#SBATCH --mem=96G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --partition=production # Partition to submit to
#SBATCH --output=/share/eisenlab/gjospin/misc/David/Project_Mercury/shoephone/R.5.err
#SBATCH --error=/share/eisenlab/gjospin/misc/David/Project_Mercury/shoephone/R.5.err
#SBATCH --time=6:0:0
source /share/eisenlab/gjospin/.profile
module load R/3.6.0 
cd /share/eisenlab/gjospin/misc/David/Project_Mercury/shoephone
#Rscript rscript_20200115.txt
#perl get_distances.pl ps0.redo.cpr.prev.rar
Rscript rscript_20200115.2.txt
