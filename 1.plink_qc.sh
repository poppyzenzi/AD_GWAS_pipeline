#!/bin/bash 
#$ -N plink_qc
#$ -l h_rt=2:00:00
#$ -l h_vmem=64G
#$ -pe sharedmem 1
#$ -e logs
#$ -o logs
#$ -M email
#$ -m baes
#$ -cwd

## Plink QC script for abcd bfiles
# snps that pass filters

# load plink and add to path 
. /etc/profile.d/modules.sh
export PATH="/exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/bin/:$PATH"

# specify file paths
GENETIC=/exports/eddie/scratch/s2421111/abcd/genetics_QCed/genotyped
ABCD=/exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/abcd

# exclude-all to remove dups
# QC on whole genome file
# keep only european indiviudals labelled by k-means clustering

plink2 \
  --bfile $GENETIC/ABCD_release_3.0_QCed_autosomes_clean \
  --mac 100 --maf 0.01 --geno 0.1 --hwe 1e-15 \
  --mind 0.1 \
  --keep abcd_EUR_genotyped_sample.txt \
  --write-snplist allow-dups \
  --rm-dup exclude-all \
  --out $ABCD/output/snps_pass_wg

