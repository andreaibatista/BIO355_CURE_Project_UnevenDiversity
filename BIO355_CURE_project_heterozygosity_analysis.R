library(tidyverse)
library(ggplot2)
library(dplyr)

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


het <- rbind(gp_pop, al_pop, br_pop, pl_pop, ab_pop, sm_pop, rh_pop, gh_pop, cm_pop, wh_pop)

names(het)

het$Ho <- 1 - (het$O.HOM. / het$N_SITES)


ggplot(het, aes(x = Population, y = Ho)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Heterozygosity across populations")


het$Group <- case_when(
  het$Population %in% c("gp_pop") ~ "Source population",
  het$Population %in% c("al_pop", "br_pop", "pl_pop") ~ "Primary reintroduction",
  het$Population %in% c("ab_pop", "sm_pop") ~ "Secondary mixed reintroduction",
  het$Population %in% c("rh_pop", "gh_pop", "cm_pop", "wh_pop") ~ "Secondary reintroduction"
)

ggplot(het, aes(x = Population, y = Ho, fill = Group)) +
  geom_boxplot() +
  theme_minimal() +
  labs(
    title = "Heterozygosity across populations",
    fill = "Population type"
  )

ggplot(het, aes(x = Population, y = Ho)) +
  geom_boxplot(fill = "steelblue") +
  facet_wrap(~ Group, scales = "free_x") +
  theme_minimal() +
  labs(title = "Heterozygosity across populations by group")


het <- het %>%
  arrange(Group)

het$Population <- factor(het$Population, levels = unique(het$Population))

ggplot(het, aes(x = Population, y = Ho, fill = Group)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Heterozygosity across populations")

ggplot(het, aes(x = Population, y = Ho, fill = Group)) +
  geom_boxplot() +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

colnames(het)

het_summary <- het %>%
  group_by(Population) %>%
  summarise(
    Ho_mean = mean(O.HOM., na.rm = TRUE),
    He_mean = mean(E.HOM., na.rm = TRUE)
  )

het_summary$Group <- case_when(
  het_summary$Population %in% c("gp_pop") ~ "Source population",
  het_summary$Population %in% c("al_pop", "br_pop", "pl_pop") ~ "Primary reintroduction",
  het_summary$Population %in% c("ab_pop", "sm_pop") ~ "Secondary mixed reintroduction",
  het_summary$Population %in% c("rh_pop", "gh_pop", "cm_pop", "wh_pop") ~ "Secondary reintroduction"
)

ggplot(het_summary, aes(x = He_mean, y = Ho_mean, label = Population)) +
  geom_point(size = 4) +
  geom_text(vjust = -0.5) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
  theme_minimal() +
  labs(
    title = "Observed vs Expected Heterozygosity",
    x = "Expected heterozygosity (He)",
    y = "Observed heterozygosity (Ho)"
  )

ggplot(het_summary, aes(x = He_mean, y = Ho_mean, color = Group)) +
  geom_point(size = 4) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
  theme_minimal() +
  labs(
    title = "Observed vs Expected Heterozygosity by Population Type"
  )

library(dplyr)

summary_table <- het %>%
  group_by(Population, Group) %>%
  summarise(
    n = n(),
    min = min(Ho, na.rm = TRUE),
    Q1 = quantile(Ho, 0.25, na.rm = TRUE),
    median = median(Ho, na.rm = TRUE),
    mean = mean(Ho, na.rm = TRUE),
    Q3 = quantile(Ho, 0.75, na.rm = TRUE),
    max = max(Ho, na.rm = TRUE),
    sd = sd(Ho, na.rm = TRUE)
  )

summary_table
