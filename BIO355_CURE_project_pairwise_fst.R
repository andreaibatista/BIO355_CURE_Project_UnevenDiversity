library(tidyverse)
library(ggplot2)


fst_summary <- tribble(
  ~pop1, ~pop2, ~mean_fst,
  
  "ab_pop", "al_pop", -0.00448028,
  "ab_pop", "br_pop", -0.0253298,
  "ab_pop", "cm_pop", 0.0163498,
  "ab_pop", "gh_pop", -0.0156251,
  "ab_pop", "gp_pop", -0.0162338,
  "ab_pop", "pl_pop", -0.0217918,
  "ab_pop", "rh_pop", -0.00401602,
  "ab_pop", "sm_pop", -0.0223204,
  "ab_pop", "wh_pop", 0.0350594,
  
  "al_pop", "br_pop", -0.0103713,
  "al_pop", "cm_pop", 0.0247316,
  "al_pop", "gh_pop", -0.0384381,
  "al_pop", "gp_pop", -0.0100945,
  "al_pop", "pl_pop", -0.00104511,
  "al_pop", "rh_pop", -0.0476828,
  "al_pop", "sm_pop", -0.0135973,
  "al_pop", "wh_pop", 0.0416802,
  
  "br_pop", "cm_pop", 0.00274038,
  "br_pop", "gh_pop", -0.0198136,
  "br_pop", "gp_pop", -0.0137083,
  "br_pop", "pl_pop", -0.0117879,
  "br_pop", "rh_pop", -0.0120266,
  "br_pop", "sm_pop", -0.0393489,
  "br_pop", "wh_pop", 0.0473503,
  
  "cm_pop", "gh_pop", 0.0346021,
  "cm_pop", "gp_pop", 0.0305155,
  "cm_pop", "pl_pop", 0.0166131,
  "cm_pop", "rh_pop", 0.0326771,
  "cm_pop", "sm_pop", 0.013721,
  "cm_pop", "wh_pop", 0.0441351,
  
  "gh_pop", "gp_pop", -0.0205173,
  "gh_pop", "pl_pop", -0.0160563,
  "gh_pop", "rh_pop", -0.0411743,
  "gh_pop", "sm_pop", -0.0203782,
  "gh_pop", "wh_pop", 0.0469688,
  
  "gp_pop", "pl_pop", -0.00910353,
  "gp_pop", "rh_pop", -0.0104874,
  "gp_pop", "sm_pop", -0.00549328,
  "gp_pop", "wh_pop", 0.0426989,
  
  "pl_pop", "rh_pop", -3.09064e-05,
  "pl_pop", "sm_pop", -0.0152009,
  "pl_pop", "wh_pop", -0.00637558,
  
  "rh_pop", "sm_pop", -0.00299712,
  "rh_pop", "wh_pop", 0.049176,
  
  "sm_pop", "wh_pop", 0.040107
)


fst_plot <- bind_rows(
  fst_summary,
  fst_summary %>% rename(pop1 = pop2, pop2 = pop1)
)

diag_df <- tibble(
  pop1 = c(
    "ab_pop", "al_pop", "br_pop", "cm_pop", "gh_pop",
    "gp_pop", "pl_pop", "rh_pop", "sm_pop", "wh_pop"
  ),
  pop2 = c(
    "ab_pop", "al_pop", "br_pop", "cm_pop", "gh_pop",
    "gp_pop", "pl_pop", "rh_pop", "sm_pop", "wh_pop"
  ),
  mean_fst = 0
)

fst_plot <- bind_rows(fst_plot, diag_df)



ggplot(fst_plot, aes(x = pop1, y = pop2, fill = mean_fst)) +
  geom_tile() +
  geom_text(aes(label = round(mean_fst, 3)), size = 3) +
  scale_fill_gradient(low = "yellow", high = "red") +
  theme_classic() +
  labs(
    title = "Pairwise FST among populations",
    x = "Population 1",
    y = "Population 2",
    fill = "Mean FST"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



fst_summary <- fst_summary %>%
  mutate(comparison = paste(pop1, "vs", pop2))

ggplot(fst_summary, aes(x = comparison, y = mean_fst)) +
  geom_col() +
  theme_classic() +
  labs(
    title = "Pairwise mean FST",
    x = "Population comparison",
    y = "Mean FST"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

