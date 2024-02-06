#!/bin/bash
#$ -N regenie_step2
#$ -l h_rt=48:00:00
#$ -l h_vmem=16G
#$ -pe sharedmem 12
#$ -e logs
#$ -o logs
#$ -M email
#$ -m baes

## STEP 2

# load environment modules
. /etc/profile.d/modules.sh
module load phys/compilers/gcc/11.2.0

# add regenie to executable path - opt1 v3.2.6, opt2 v3.3
export PATH='/exports/igmm/eddie/GenScotDepression/users/poppy/regenie/build:$PATH'

# specify file paths
IMPUTED=/path/to/imputed/data/directory
QCD=/path/to/QCd/files
PHENO=/path/to/phenotype/file
OUTPUT=/path/to/output/directory

# Loop through chromosomes

# --sample indivudals to keep in the analysis

for chr in {1..22}; do
    regenie_v3.3 \
        --step 2 \
        --bgen $IMPUTED/data_chr${chr}.bgen \
        --phenoFile $PHENO/pheno_file \
        --phenoCol pheno_col \
        --sample $GENETIC/data.sample \
        --bsize 1000 \
        --minMAC 100 \
        --minINFO 0.1 \
        --qt \
        --firth --approx \
        --pThresh 0.01 \
        --pred $OUTPUT/fit_bin_out_dep_pred.list \
        --out $OUTPUT/step2_chr${chr}

done


