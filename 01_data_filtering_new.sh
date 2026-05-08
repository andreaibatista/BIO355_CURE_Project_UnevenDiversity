
# Define paths
RAW_VCF="/Users/classes/bio355b/CURE_projects/uneven_diversity/data_raw"
PROC_DIR="/Users/classes/bio355b/CURE_projects/uneven_diversity/data_processed"

# Define vcftools 
vcftools=/usr/bin/vcftools

# Remove samples for analysis

vcftools --vcf $RAW_VCF/DRYAD.raw.SNPfile.vcf --keep $RAW_VCF/alpine_samples.txt --remove $RAW_VCF/removed_samples.txt --recode --out $PROC_DIR/filtered_alpine_samples_all

# Create individual vcf files for each population

# Gran Paradiso
vcftools --vcf $PROC_DIR/filtered_alpine_samples_all.vcf --keep $PROC_DIR/gp_pop.txt --recode --out $PROC_DIR/gp_pop

# Albris
vcftools --vcf $PROC_DIR/filtered_alpine_samples_all.vcf --keep $PROC_DIR/al_pop.txt --recode --out $PROC_DIR/al_pop

# Brienzer Rothorn
vcftools --vcf $PROC_DIR/filtered_alpine_samples_all.vcf --keep $PROC_DIR/br_pop.txt --recode --out $PROC_DIR/br_pop

# Pleureur
vcftools --vcf $PROC_DIR/filtered_alpine_samples_all.vcf --keep $PROC_DIR/pl_pop.txt --recode --out $PROC_DIR/pl_pop

# Aletsch Bietschhorn
vcftools --vcf $PROC_DIR/filtered_alpine_samples_all.vcf --keep $PROC_DIR/ab_pop.txt --recode --out $PROC_DIR/ab_pop

# Schwarz Monch
vcftools --vcf $PROC_DIR/filtered_alpine_samples_all.vcf --keep $PROC_DIR/sm_pop.txt --recode --out $PROC_DIR/sm_pop

# Rheinwaldhorn
vcftools --vcf $PROC_DIR/filtered_alpine_samples_all.vcf --keep $PROC_DIR/rh_pop.txt --recode --out $PROC_DIR/rh_pop

# Graue Horner
vcftools --vcf $PROC_DIR/filtered_alpine_samples_all.vcf --keep $PROC_DIR/gh_pop.txt --recode --out $PROC_DIR/gh_pop

# Cape au Moine
vcftools --vcf $PROC_DIR/filtered_alpine_samples_all.vcf --keep $PROC_DIR/cm_pop.txt --recode --out $PROC_DIR/cm_pop

# Weisshorn
vcftools --vcf $PROC_DIR/filtered_alpine_samples_all.vcf --keep $PROC_DIR/wh_pop.txt --recode --out $PROC_DIR/wh_pop



