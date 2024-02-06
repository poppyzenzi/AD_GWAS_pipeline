#!/bin/bash
#$ -N step2_episodes
#$ -l h_rt=48:00:00
#$ -l h_vmem=16G
#$ -pe sharedmem 12
#$ -e /exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac/logs
#$ -o /exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac/logs
#$ -M p.grimes@ed.ac.uk
#$ -m baes

## shell script to run regenie in alspac
## STEP 2

# load environment modules
. /etc/profile.d/modules.sh
#module load phys/compilers/gcc/9.3.0
module load phys/compilers/gcc/11.2.0

# add regenie to executable path - opt1 v3.2.6, opt2 v3.3
#export PATH="/exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/bin/regenie:$PATH"
export PATH='/exports/igmm/eddie/GenScotDepression/users/poppy/regenie/build:$PATH'

# specify file paths
GENETIC=/exports/eddie/scratch/s2421111/alspac_1kg
PHENO=/exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac/pheno
ALSPAC=/exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac

# Loop through chromosomes

for chr in {1..9}; do
    regenie_v3.3 \
        --step 2 \
        --bgen $GENETIC/data_chr0${chr}.bgen \
        --phenoFile $PHENO/alspac_pheno \
        --phenoCol episodes \
        --sample $GENETIC/data.sample \
        --bsize 1000 \
        --minMAC 100 \
        --minINFO 0.1 \
        --qt \
        --firth --approx \
        --pThresh 0.01 \
        --pred $ALSPAC/output/fit_bin_out_epi_pred.list \
        --out $ALSPAC/output/step2_chr${chr}

done

for chr in {10..22}; do
    regenie_v3.3 \
        --step 2 \
        --bgen $GENETIC/data_chr${chr}.bgen \
        --phenoFile $PHENO/alspac_pheno \
        --phenoCol episodes \
        --sample $GENETIC/data.sample \
        --bsize 1000 \
	--minMAC 100 \
	--minINFO 0.1 \
        --qt \
        --firth --approx \
        --pThresh 0.01 \
        --pred $ALSPAC/output/fit_bin_out_epi_pred.list \
        --out $ALSPAC/output/step2_chr${chr}

done

