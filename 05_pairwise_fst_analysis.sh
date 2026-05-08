PROC_DIR="/Users/classes/bio355b/CURE_projects/uneven_diversity/data_processed"
RESULTS="/Users/classes/bio355b/CURE_projects/uneven_diversity/results"
POOLED_VCF="/Users/classes/bio355b/CURE_projects/uneven_diversity/data_processed/filtered_alpine_samples_all.recode.vcf"
POP_DIR="/Users/classes/bio355b/CURE_projects/uneven_diversity/tmp_pairwise_fst"


POPS=(ab_pop al_pop br_pop cm_pop gh_pop gp_pop pl_pop rh_pop sm_pop wh_pop)

mkdir -p "$RESULTS"

# Loop through all unique population pairs
for ((i=0; i<${#POPS[@]}; i++))
do
  for ((j=i+1; j<${#POPS[@]}; j++))
  do
    pop1=${POPS[$i]}
    pop2=${POPS[$j]}

   echo "Processing $pop1 vs $pop2"

    vcftools --vcf "$POOLED_VCF" \
      --weir-fst-pop "$PROC_DIR/${pop1}.txt" \
      --weir-fst-pop "$PROC_DIR/${pop2}.txt" \
      --out "$RESULTS/${pop1}_vs_${pop2}_fst"

  done
done

echo "All pairwise FST comparisons done."
