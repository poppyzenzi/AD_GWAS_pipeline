#!/bin/bash

# Specify the directory containing the output files
OUTPUT=/exports/igmm/eddie/GenScotDepression/users/poppy/aGWAS/cohorts/alspac/output

# Your cohort name
COHORT="ALSPAC"

# Specify the output file name
MERGED_OUTPUT=$OUTPUT/${COHORT}_adoldep_EUR.regenie

# Remove any existing merged output file
rm -f $MERGED_OUTPUT

# Loop through the output files and concatenate them
for file in $OUTPUT/step2_chr*.regenie; do
    # Skip the header in all files except the first one
    if [ ! -f $MERGED_OUTPUT ]; then
        cat "$file" >> "$MERGED_OUTPUT"
    else
        tail -n +2 "$file" >> "$MERGED_OUTPUT"
    fi
done

# After merging please:
#  Convert -log10P values to raw P if applicable

###############################################################################
