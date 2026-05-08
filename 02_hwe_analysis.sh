                                                                         
# Define paths
PROC_DIR="/Users/classes/bio355b/CURE_projects/uneven_diversity/data_processed"
RESULTS="/Users/classes/bio355b/CURE_projects/uneven_diversity/results"


# Load vcftools
vcftools=/usr/local/bin/vcftools


# Run HWE test on pooled file
$vcftools --vcf $PROC_DIR/filtered_alpine_samples_all.vcf \
--hardy \
--out $RESULTS/filtered_alpine_samples_all

# Run HWE test on each individual populations
$vcftools --vcf $PROC_DIR/gp_pop.recode.vcf \
--hardy \
--out $RESULTS/gp_pop

$vcftools --vcf $PROC_DIR/al_pop.recode.vcf \
--hardy \
--out $RESULTS/al_pop

$vcftools --vcf $PROC_DIR/br_pop.recode.vcf \
--hardy \
--out $RESULTS/br_pop

$vcftools --vcf $PROC_DIR/pl_pop.recode.vcf \
--hardy \
--out $RESULTS/pl_pop

$vcftools --vcf $PROC_DIR/ab_pop.recode.vcf \
--hardy \
--out $RESULTS/ab_pop

$vcftools --vcf $PROC_DIR/sm_pop.recode.vcf \
--hardy \
--out $RESULTS/sm_pop

$vcftools --vcf $PROC_DIR/rh_pop.recode.vcf \
--hardy \
--out $RESULTS/rh_pop

$vcftools --vcf $PROC_DIR/gh_pop.recode.vcf \
--hardy \
--out $RESULTS/gh_pop

$vcftools --vcf $PROC_DIR/cm_pop.recode.vcf \
--hardy \
--out $RESULTS/cm_pop

$vcftools --vcf $PROC_DIR/wh_pop.recode.vcf \
--hardy \
--out $RESULTS/wh_pop
