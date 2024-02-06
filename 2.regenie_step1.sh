#!/bin/bash
#$ -N regenie_step1
#$ -l h_rt=24:00:00
#$ -l h_vmem=128G
#$ -pe sharedmem 1
#$ -e logs
#$ -o logs
#$ -M email
#$ -m baes

## shell script to run regenie in alspac
## STEP 1
. /etc/profile.d/modules.sh

# add regenie to executable path
module load phys/compilers/gcc/11.2.0
export PATH='/exports/igmm/eddie/GenScotDepression/users/poppy/regenie/build:$PATH'

# specify file paths
GENOTYPED=/path/to/genotyped/data/directory
QCD=/path/to/QCd/files
PHENO=/path/to/phenotype/file
OUTPUT=/path/to/output/directory

## step 1 is performed on the genotyped data
# --extract SNPs that pass the QC filter (generate in PLINK)
# --bt = binary traits

regenie_v3.3 \
  --step 1 \
  --bed $GENOTYPED/whole_genome_bfiles_prefix \
  --extract $QCD/snps_pass_qc.snplist \
  --phenoFile $PHENO/pheno_file \
  --phenoCol pheno_col \
  --bsize 1000 \
  --bt \
  --out $OUTPUT/fit_bin_out_dep
