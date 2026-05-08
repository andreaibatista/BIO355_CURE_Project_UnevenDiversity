# Define paths
PROC_DIR="/Users/classes/bio355b/CURE_projects/uneven_diversity/data_processed"
RESULTS="/Users/classes/bio355b/CURE_projects/uneven_diversity/results"

plink=/usr/local/plink/plink

$plink --bfile "$PROC_DIR/all_alpine_pops_roh-temporary" \
  --allow-extra-chr \
  --homozyg \
  --homozyg-snp 25 \
  --homozyg-kb 1000 \
  --homozyg-het 1 \
  --homozyg-density 50 \
  --homozyg-gap 1000 \
  --homozyg-window-snp 25 \
  --homozyg-window-het 1 \
  --homozyg-window-missing 5 \
  --homozyg-window-threshold .05 \
  --out "$RESULTS/all_alpine_pops_roh"
