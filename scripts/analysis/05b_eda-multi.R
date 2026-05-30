####################################
# Title: Multivariable Analysis
# Author: Dantz Farrow
# Last Modified: 05/30/2026
####################################

# --- Load Data ---
df <- read_rds(file.path(path[2], "nces-seda.rds"))

##################################################
#           Bivariate Examination             
##################################################
# scatter w/ trend line (enrollment vs cs_score)
plot <- df %>%
  ggplot(aes(x = enrollment_log10, y = cs_score)) +
  geom_point(alpha = 0.12) +
  geom_smooth(method = "lm") + # trend line
  labs(
    title = "Enrollment vs. Academic Performance (2014-2024)",
    x = "Total Enrollment (log scale)",
    y = "Cohort Standardized Score"
  )
ggsave(paste0(path[3], "/06_scatter_enroll-cs-score.pdf"), plot = plot)

# scatter side-by-side panels w/ trend line (enrollment vs cs_score)
plot <- df %>%
  ggplot(aes(x = enrollment_log10, y = cs_score)) +
  geom_point(alpha = 0.12) +
  scale_x_log10() +
  geom_smooth(method = "lm") +
  facet_wrap(~factor(is_rural,
                     levels = c(0, 1),
                     labels = c("Non-rural", "Rural"))) +
  labs(
    title = "Enrollment vs. Academic Performance (2014-2024)",
    x = "Total Enrollment (log scale)",
    y = "Cohort Standardized Score"
  )
ggsave(paste0(path[3], "/07_scatter_enroll-cs-score_rural.pdf"), plot = plot)
