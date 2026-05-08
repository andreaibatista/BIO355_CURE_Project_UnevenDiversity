library(tidyverse)
library(ggplot2)
library(dplyr)


ab_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/ab_pop.hwe", header = TRUE)
al_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/al_pop.hwe", header = TRUE)
br_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/br_pop.hwe", header = TRUE)
cm_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/cm_pop.hwe", header = TRUE)
gh_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/gh_pop.hwe", header = TRUE)
gp_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/gp_pop.hwe", header = TRUE)
pl_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/pl_pop.hwe", header = TRUE)
rh_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/rh_pop.hwe", header = TRUE)
sm_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/sm_pop.hwe", header = TRUE)
wh_pop <- read.table("/Users/classes/bio355b/CURE_projects/uneven_diversity/results/wh_pop.hwe", header = TRUE)

# Add population labels
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

# Combine populations
hwe_all <- bind_rows(ab_pop, al_pop, br_pop, cm_pop, gh_pop, gp_pop, pl_pop, rh_pop, sm_pop, wh_pop)


alpha <- 0.05

hwe_all <- hwe_all %>%
  mutate(deviates = P_HWE < alpha)

hwe_summary$Group <- case_when(
  hwe_summary$Population %in% c("gp_pop") ~ "Source population",
  hwe_summary$Population %in% c("al_pop", "br_pop", "pl_pop") ~ "Primary reintroduction",
  hwe_summary$Population %in% c("ab_pop", "sm_pop") ~ "Secondary mixed reintroduction",
  hwe_summary$Population %in% c("rh_pop", "gh_pop", "cm_pop", "wh_pop") ~ "Secondary reintroduction"
)

hwe_summary <- hwe_all %>%
  group_by(Population) %>%
  summarise(
    total_loci = n(),
    n_deviating = sum(deviates, na.rm = TRUE),
    proportion = n_deviating / total_loci,
    .groups = "drop"
  )

hwe_summary
sum(hwe_all$deviates, na.rm = TRUE)

hwe_summary$percent <- hwe_summary$proportion * 100

ggplot(hwe_summary, aes(x = Population, y = proportion)) +
  geom_col(fill = "steelblue", color = "black") +
  geom_text(aes(label = round(proportion, 3)), vjust = -0.4) +
  ylim(0, 1) +
  theme_minimal() +
  labs(
    title = "Proportion of Loci Deviating from HWE",
    x = "Population",
    y = "Proportion"
  )

ggplot(hwe_summary, aes(x = Population, y = percent, fill = Group)) +
  geom_col(color = "black") +
  geom_text(aes(label = round(percent, 2)), vjust = -0.3) +
  theme_minimal() +
  labs(
    title = "HWE Deviation Across Populations",
    y = "Percent of loci deviating (%)",
    x = "Population"
  )

ggplot(hwe_summary, aes(x = Population, y = proportion, color = Group)) +
  geom_point(size = 4) +
  theme_minimal() +
  labs(title = "HWE deviation across populations")


ggplot(hwe_summary, aes(x = Population, y = proportion, fill = Group)) +
  geom_col(color = "black") +
  geom_hline(yintercept = 0.05, linetype = "dashed") +
  theme_minimal()

write.csv(hwe_summary, "hwe_summary.csv", row.names = FALSE)
