library(tidyverse)
library(ggplot2)

# Read ROH summary 
roh_indiv <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/all_alpine_pops_roh.hom.indiv", header = TRUE, stringsAsFactors = FALSE)

# Read het files per population
ab_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/ab_pop.het", header = TRUE)
al_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/al_pop.het", header = TRUE)
br_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/br_pop.het", header = TRUE)
cm_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/cm_pop.het", header = TRUE)
gh_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/gh_pop.het", header = TRUE)
gp_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/gp_pop.het", header = TRUE)
pl_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/pl_pop.het", header = TRUE)
rh_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/rh_pop.het", header = TRUE)
sm_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/sm_pop.het", header = TRUE)
wh_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/wh_pop.het", header = TRUE)


# Assign label to each population
ab_pop$Population <- "ab_pop"
al_pop$Population <- "al_pop"
br_pop$Population <- "br_pop"
cm_pop$Population <- "cm_pop"
gh_pop$Population <- "gh_pop"
gp_pop$Population <- "gp_pop"
pl_pop$Population <- "pl_pop"
rh_pop$Population <- "rh_pop"
sm_pop$Population <- "sm_pop"
wh_pop$Population <- "wh_pop"


# Combine heterozygosity population datasets 
het <- rbind(gp_pop, al_pop, br_pop, pl_pop, ab_pop, sm_pop, rh_pop, gh_pop, cm_pop, wh_pop)


# Assign total genome length
genome_length <- 1499192610

# Calculate FROH
roh_indiv <- roh_indiv %>%
  mutate(FROH = KB / genome_length)


head(roh_indiv$IID)
head(het$INDV)


# Combine dataframes
combined <- roh_indiv %>%
  left_join(het, by = c("IID" = "INDV"))


# Omit NAs
combined_clean <- na.omit(combined)


# Plot number of ROHs per individual by population
ggplot(combined_clean, aes(x = Population, y = NSEG, fill = Population)) +
  geom_boxplot() +
  theme_classic() +
  labs(
    title = "Number of ROHs per individual",
    x = "Population",
    y = "Number of ROHs"
  )


# Inspect outlier points
boxplot.stats(combined_clean$NSEG)$out


combined_clean %>%
  filter(NSEG %in% boxplot.stats(NSEG)$out)


Q1 <- quantile(combined_clean$NSEG, 0.25)
Q3 <- quantile(combined_clean$NSEG, 0.75)
IQR <- Q3 - Q1


# Plot data without outliers to better observe ROH patterns
combined_no_outliers <- combined_clean %>%
  filter(NSEG >= (Q1 - 1.5 * IQR),
         NSEG <= (Q3 + 1.5 * IQR))


# Plot - Number of ROHs per individual by population
ggplot(combined_no_outliers, aes(x = Population, y = NSEG, fill = Population)) +
  geom_boxplot() +
  theme_classic() +
  labs(
    title = "Number of ROHs per individual",
    x = "Population",
    y = "Number of ROHs"
  )


# Plot - Total ROH length per individual by population
ggplot(combined_clean, aes(x = Population, y = KB, fill = Population)) +
  geom_boxplot() +
  theme_classic() +
  labs(
    title = "Total ROH length per individual",
    x = "Population",
    y = "Total ROH length (kb)"
  )


# Plot - FROH by population
ggplot(combined_clean, aes(x = Population, y = FROH, fill = Population)) +
  geom_boxplot() +
  theme_classic() +
  labs(
    title = "ROH-based inbreeding coefficient",
    x = "Population",
    y = "FROH"
  )


# Plot - Heterozygosity-based F by population
ggplot(combined_clean, aes(x = Population, y = F, fill = Population)) +
  geom_boxplot() +
  theme_classic() +
  labs(
    title = "Heterozygosity-based inbreeding coefficient",
    x = "Population",
    y = "F"
  )


# Plot - Compare FROH and heterozygosity-based F
ggplot(combined_clean, aes(x = F, y = FROH, color = Population)) +
  geom_point(size = 2) +
  theme_classic() +
  labs(
    title = "Heterozygosity-based F vs. FROH",
    x = "PLINK heterozygosity-based F",
    y = "FROH"
  )


# Plot - Compare total ROH length and heterozygosity-based F
ggplot(combined_clean, aes(x = F, y = KB, color = Population)) +
  geom_point(size = 2) +
  theme_classic() +
  labs(
    title = "Total ROH length vs heterozygosity-based F",
    x = "PLINK heterozygosity-based F",
    y = "Total ROH length (kb)"
  )


