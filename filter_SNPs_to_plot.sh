## Before plotting we filter SNPS with P <= 1e-03 for computational efficiency in R

# Navigate to directory with sumstats 
cd /exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac/output

# Skipping the header, filter values in the P column
# (check col number in your sumstats, here P is col #15)
awk 'NR > 1 && $15 <= 1e-03' alspac_P_adoldep_EUR.regenie > filtered_alspac_P_adoldep_EUR.regenie
