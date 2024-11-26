# Adolescent depression symptoms GWAS

A repository of example scripts for REGENIE association testing in the elevated symptoms of depression in adolescence GWAS

LINK TO LIVE SOP: https://docs.google.com/document/d/1ppvOzH2Rjb-8Z2eqe86ct03E51MtS25q/edit?usp=sharing&ouid=108956179468703355713&rtpof=true&sd=true

## Instructions

* Install REGENIE if not already installed: https://rgcgithub.github.io/regenie/install/
* To use example scripts as templates:
  + Clone this GitHub repository
```
git clone git@github.com:poppyzenzi/AD_GWAS_pipeline.git
```
  + Edit scripts and set-up as appropriate
* If you already have a pipeline set-up or don't need templates, please still refer to our examples to make sure flags and thresholds correspond 
* After running association testing, please make sure you have converted -log10P values to raw P values (see script `convert-log10P.sh`)
* Generate Manhattan and QQ plots using the `4.plot_results.R` script provided
* Return back to the SOP document for how to upload and report your results

## Contact

For any questions or uncertainties please contact Poppy Grimes at p.grimes@ed.ac.uk 

## REGENIE flag options

These are also included in the shell scripts provided

### Step 1

`--bed`: **PLINK** binary files prefix for .bed/.bim/.fam files

`--extract`: = List of SNPs that pass QC filter (We generate this list in **PLINK**, however if you have already performed sufficient QC on your genotyped data file, you can omit this flag)

`--phenoFile`: Path to your phenotype file with the header `FID IID pheno_col`

`--phenoCol`: Phenotype column name

`--covarFile`: Covariate file path with the header `FID IID C1 C2 C3`

`--covarCol`: Covariate column names

`--bsize`: Chunk size for analysis

`--bt`: Option for binary trait

`--out`: Path to output file


### Step 2 
`--bgen`: Path to imputed data. Here we use the .bgen format split by chromosome. See REGENIE documentation for more info on file input

`--phenoFile`: Path to your phenotype file with the header `FID IID pheno_col`

`--phenoCol`: Phenotype column name

`--sample`: Sample file corresponding to input bgen (can also use `--keep` / `--remove` flags to only include individuals that pass QC filtering, see REGENIE documentation)

`--covarFile`: Covariate file path with the header `FID IID C1 C2 C3`

`--covarCol`: Covariate column names

`--bsize`: Chunk size for analysis

`--minMAC`: Minimum minor allele count

`--minINFO`: Minimum imputation info score

`--bt`: Option for binary trait

`--af-cc` : To output A1FREQ in case/controls separately in the step 2 result file and N_CASES N_CONTROLS

`--firth` `--approx`: Firth LRT, computational speed up

`--pThresh`: P-value threshold to apply firth correction

`--pred`: Path to file containing predictions from **STEP 1**

`--out`: Path to output file(s)


