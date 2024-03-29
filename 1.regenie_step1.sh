#!/bin/bash
#$ -N regenie_step1
#$ -l h_rt=24:00:00
#$ -l h_vmem=128G
#$ -pe sharedmem 1
#$ -e logs
#$ -o logs
#$ -M your_email
#$ -m baes

## REGENIE STEP 1 - whole genome regression model is fit to the traits, and a set of genomic predictions are produced as output. Regenie handles relatedness so please retain related indivudals in your data
# This is an example script in the ALSPAC cohort. Please edit for your data and cluster set-up.
 
# Load environment modules and add regenie to executable path
. /etc/profile.d/modules.sh
module load phys/compilers/gcc/11.2.0
export PATH='/exports/igmm/eddie/GenScotDepression/users/poppy/regenie/build:$PATH'

# Specify file paths
ALSPAC=/exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac
GENO=/exports/eddie/scratch/s2421111/alspac_genotyped

## Step 1 is performed on the genotyped data
regenie_v3.3 \
  --step 1 \
  --bed $GENO/data \
  --extract $ALSPAC/whole_genome/snps_pass.snplist \
  --phenoFile $ALSPAC/pheno/alspac_pheno \
  --phenoCol adol_dep \
  --covarFile covs/covariates.txt \
  --covarCol PC{1:10} \
  --bsize 1000 \
  --bt \
  --out $ALSPAC/output/fit_bin_out_dep


# --bed = PLINK binary files prefix for .bed/.bim/.fam files
# --extract = List of SNPs that pass QC filter (We generate this list in PLINK, however if you have already performed sufficient QC on your genotyped data file, you can omit this flag)
# --phenoFile = phenotype file path with the header FID IID pheno_col
# --phenoCol = phenotype column name
# --covarFile = covariate file path with the header FiD IID C1 C2 C3 etc.
# --covarCol = covariate column names
# --bsize = chunk size for analysis
# --bt = binary trait
# --out = path to output file

