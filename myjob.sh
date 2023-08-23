#!/bin/bash
#SBATCH -J test
#SBATCH -o job_output/test-%J.out
#SBATCH -e job_output/test-%J.err
#SBATCH --nodes 1
#SBATCH --time=1:00:00
#SBATCH --mem-per-cpu=16G

# Some important variables to check (Can be removed later)
module load java/14.0.1
# Add your job command here
fd_name="data/all_data"
out="LIB058683_GEN00257688_M4-CD21lo-HC_S16"
mixcr analyze rnaseq-bcr-full-length --species mouse \
    $fd_name/${out}_L001_R1_001.fastq.gz \
    $fd_name/${out}_L001_R2_001.fastq.gz \
    result/$out
