#!/bin/bash
#$ -N step1_episodes
#$ -l h_rt=24:00:00
#$ -l h_vmem=128G
#$ -pe sharedmem 1
#$ -e /exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac/logs
#$ -o /exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac/logs
#$ -M p.grimes@ed.ac.uk
#$ -m baes

## shell script to run regenie in alspac
## STEP 1
. /etc/profile.d/modules.sh

# add regenie to executable path
#module load phys/compilers/gcc/9.3.0
module load phys/compilers/gcc/11.2.0

#export PATH="/exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/bin/regenie:$PATH"
export PATH='/exports/igmm/eddie/GenScotDepression/users/poppy/regenie/build:$PATH'

# specify file paths
ALSPAC=/exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac
SCRATCH=/exports/eddie/scratch/s2421111/alspac_genotyped

## step 1 on the genotyped data
# --extract SNPs that pass the QC filter
# --keep related siblings (remove mums) 
# --bt = binary traits, --qt = quantitative traits
regenie_v3.3 \
  --step 1 \
  --bed $SCRATCH/data \
  --extract $ALSPAC/whole_genome/genotyped/snps_pass_genotyped.snplist \
  --phenoFile $ALSPAC/pheno/alspac_pheno \
  --phenoCol episodes \
  --bsize 1000 \
  --qt \
  --out $ALSPAC/output/fit_bin_out_epi
