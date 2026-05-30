####################################
# Title: 
# Author: Dantz Farrow
# Last Modified:
####################################

##################################################
#           Bivariate Inspection             
##################################################
# scatter w/ trend line (enrollment vs cs_score)
plot <- df %>%
  ggplot(aes(x = enrollment, y = cs_score)) +
  geom_point(alpha = 0.12) +
  scale_x_log10() +
  geom_smooth(method = "lm") + # trend line
  labs(
    title = "Enrollment vs. Academic Performance (2014-2024)",
    x = "Total Enrollment (log scale)",
    y = "Cohort Standardized Score"
  )
ggsave(paste0(path[3], "/scatter_enrollment-cs-score.pdf"), plot = plot)

# 
plot <- df %>%
  ggplot(aes(x = enrollment, y = cs_score)) +
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
ggsave(paste0(path[3], "/scatter_enrollment-cs-score_rural.pdf"), plot = plot)
