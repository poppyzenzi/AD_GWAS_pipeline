####################################################################################################

## REGENIE outputs -log10P values
## You will need to convert these to raw P values for the final result and for plotting

# Navigate to results directory
cd /exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac/output

# Convert -log10P to raw P (check col number, here -log10P is col #13)
awk '{printf "%s %.10f\n", $0, 10^(-$13)}' alspac_adoldep_EUR.regenie > alspac_P_adoldep_EUR.regenie

# Rename new column 'P'
sed -i -e '1s/1.0000000000/P/' alspac_P_adoldep_EUR.regenie

# (You could also do this in R if preferred) 

####################################################################################################
