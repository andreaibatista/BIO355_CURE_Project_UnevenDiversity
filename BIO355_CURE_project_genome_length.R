library(tidyverse)
library(ggplot2)

bim <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/data_processed/all_alpine_pops_roh-temporary.bim", header = FALSE)

colnames(bim) <- c("CHR", "SNP", "CM", "BP", "A1", "A2")


bim$CHR <- gsub("chr", "", bim$CHR)

bim$CHR <- as.numeric(bim$CHR)

bim_auto <- bim %>%
  filter(CHR %in% 1:29)

chr_lengths <- bim_auto %>%
  group_by(CHR) %>%
  summarise(chr_length = max(BP) - min(BP))

genome_length <- sum(chr_lengths$chr_length)
genome_length

nrow(bim_auto)
range(bim_auto$BP)
sum(chr_lengths$chr_length)
