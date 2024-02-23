#!/bin/bash
#$ -N regenie_step2
#$ -l h_rt=48:00:00
#$ -l h_vmem=16G
#$ -pe sharedmem 12
#$ -e logs
#$ -o logs
#$ -M your_email
#$ -m baes

## REGENIE STEP 2 - a set of imputed SNPs are tested for association using a Firth logistic regression model

# This is an example script in the ALSPAC cohort. Please edit for your data and cluster set-up. For troubleshooting see the REGENIE documentation: https://rgcgithub.github.io/regenie/options/

# Load environment modules and add regenie to executable path
. /etc/profile.d/modules.sh
module load phys/compilers/gcc/11.2.0
export PATH='/exports/igmm/eddie/GenScotDepression/users/poppy/regenie/build:$PATH'

# Specify file paths
IMPUTED=/exports/eddie/scratch/s2421111/alspac_1kg
ALSPAC=/exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac

# Loop through imputed chromosomes and run step 2
for chr in {1..22}; do
    regenie_v3.3 \
        --step 2 \
        --bgen $IMPUTED/data_chr${chr}.bgen \
        --phenoFile $ALSPAC/pheno/alspac_pheno \
        --phenoCol adol_dep \
        --sample $IMPUTED/data.sample \
	--covarFile covs/covariates.txt \
  	--covarCol PC{1:10} \
        --bsize 1000 \
        --minMAC 100 \
        --minINFO 0.1 \
        --bt \
        --firth --approx \
        --pThresh 0.01 \
        --pred $ALSPAC/fit_bin_out_dep_pred.list \
        --out $ALSPAC/output/step2_chr${chr}

done

## You will then need to merge the output (22 chromosomes into one file)

# --bgen = path to imputed data. Here we use the .bgen format split by chromosome. See REGENIE documention for more info on file input
# --phenoFile = path to your phenotype file with the header FID IID pheno_col
# --phenoCol = phenotype column name
# --sample = sample file corresponding to input bgen (can also use --keep / --remove flags to only include indiviudals that pass QC filtering, see REGENIE documentation)
# --covarFile = covariate file path with the header FiD IID C1 C2 C3 etc.
# --covarCol = covariate column names
# --bsize = chunk size for analysis
# --minMAC = minimum minor allele count
# --minINFO = minimum imputation info score
# --bt = binary trait
# --firth --approx = firth LRT, computational speed up
# --pThresh = P-value threshold to apply firth correction
# --pred = path to file containing predictions from STEP 1
# --out = path to output file(s)


