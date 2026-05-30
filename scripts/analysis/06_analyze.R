####################################
# Title: Cross-Sectional Analysis
# Author: Dantz Farrow
# Last Modified: 05/30/2026
####################################

# --- 1. Preparation ---
# collapse to district level
df_cs <- df %>% 
  group_by(district) %>% 
  summarise(
    enrollment_log10 = mean(enrollment_log10),
    cs_score         = mean(cs_score),
    is_rural         = calc_mode(is_rural))

# --- 2. Pre-Model Plot ---
ggplot(df_cs, aes(x = enrollment_log10, y = cs_score, color = factor(is_rural))) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm", se = T) + # trend lin w/ conf bands
  scale_color_manual(
    values = c("0" = "chartreuse4", "1" = "darkorange"),
    labels = c("0" = "Non-Rural", "1" = "Rural")) +
  labs(
    title = "Enrollment Size vs Academic Performance (2014-2024)",
    subtitle = "Oklahoma Public School Districts (Cross-Sectional Averages)",
    x     = "Enrollment (log scale)",
    y     = "Avg CS Score (z-score normalized)",
    color = "Locale Group") +
  theme_minimal()
ggsave(paste0(path[4], "/01_trends_locale-cs_avg.pdf"), plot = plot)

# --- 3. Pearson Correlation ---
cor.test(df_cs$enrollment_log10, df_cs$cs_score)
# NOTES:
# - positive relationship btwn enrollment and cs_score
# - p-value: 8.017e-06
# - conf int: 0.1130158 - 0.2823416
# - cor: 0.1991648

# --- 4. OLS Regression ---
# Model Notation:
# Yhat = ßsub0 + ßsub1(enrollment_log10) + ßsub2(is_rural) + ßsub3(enrollment_log10 * is_rural) + e
model <- lm(cs_score ~ enrollment_log10 * is_rural, data = df_cs)
summary(model)
plot(model)

# -- 5. Diagnostics ---
pdf(paste0(path[4], "/02_diagnostics.pdf"))
par(mfrow = c(2, 2)) # display multiple
plot(model)
dev.off()