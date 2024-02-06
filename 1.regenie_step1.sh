#!/bin/bash
#$ -N regenie_step1
#$ -l h_rt=24:00:00
#$ -l h_vmem=128G
#$ -pe sharedmem 1
#$ -e logs
#$ -o logs
#$ -M your_email
#$ -m baes

## REGENIE STEP 1 - whole genome regression model is fit to the traits, and a set of genomic predictions are produced as output

# This is an example script in the ALSPAC cohort. Please edit for your data and cluster set-up.
 
# Load environment modules 
. /etc/profile.d/modules.sh
module load phys/compilers/gcc/11.2.0

# Add regenie to executable path
export PATH='/exports/igmm/eddie/GenScotDepression/users/poppy/regenie/build:$PATH'

# Specify file paths
ALSPAC=/exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac
GENO=/exports/eddie/scratch/s2421111/alspac_genotyped

## step 1 is performed on the genotyped data

# Run step 1
regenie_v3.3 \
  --step 1 \
  --bed $GENO/data \
  --extract $ALSPAC/whole_genome/snps_pass.snplist \
  --phenoFile $ALSPAC/pheno/alspac_pheno \
  --phenoCol adol_dep \
  --bsize 1000 \
  --bt \
  --out $ALSPAC/output/fit_bin_out_dep

# --bed = PLINK binary files prefix for .bed/.bim/.fam files
# --extract = List of SNPs that pass QC filter (We generate this list in PLINK, however if you have already performed sufficient QC on your genotyped data file, you can omit this flag)
# --phenoFile = path to your phenotype file with the header FID IID pheno_col
# --phenoCol = phenotype column name
# --bsize = chunk size for analysis
# --bt = binary trait
# --out = path to output file

