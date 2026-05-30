####################################
# Title: Exploratory Data Analysis (Univariate)
# Author: Dantz Farrow
# Last Modified: 05/28/2026
####################################

# --- Load Data ---
df <- read_rds(file.path(path[2], "nces-seda.rds"))

##################################################
#             Inspect Variables             
##################################################
summary(df) # summary stats

# --- enrollment ---
# NOTE: log transform enrollment before analysis
plot <- df %>% 
  ggplot(aes(x = enrollment)) + 
  geom_histogram() +
  labs(
    title = "Enrollment Frequency Distribution",
    x = "Total Enrollment (2014-2024)") # export
ggsave(paste0(path[3], "/freq-dist_enrollment.pdf"), plot = plot)

# enrollment distribution (log scale)
# to address proportional diff btwn districts
plot <- df %>% # right skewed
  ggplot(aes(x = enrollment)) + 
  geom_histogram() +
  scale_x_log10() + # log scale
  labs(
    title = "Enrollment Distribution (log scale)",
    x = "Total Enrollment (2014-2024)") # export
ggsave(paste0(path[3], "/freq-dist_enrollment+log.pdf"), plot = plot)

# --- cs_score ---
plot <- df %>%
  ggplot(aes(x = cs_score)) + 
  geom_histogram(binwidth = 0.1) +
  labs(
    title = "SEDA CS Score Distribution (z-score normalized)",
    x = "Cohort Standardized Test Scores (2014-2024)")
ggsave(paste0(path[3], "/freq-dist_cs-score.pdf"), plot = plot)


# --- year ---
hist(df$year)
df %>% distinct(year)  # missing 2020, 2021 (Covid-19)

# --- locale ---
# heavily skewed rural
plot <- df %>% count(locale) %>% 
  ggplot(aes(x = n, y = locale)) +
  geom_col() +
  labs(
    title = "NCES Locale Designation Distribution",
    y = "Locale Designation (2014-2024)", x = "count")
ggsave(paste0(path[3], "/freq-dist_locale.pdf"), plot = plot)

# rural/nonrural bar chart
plot <- df %>% 
  ggplot(aes(x = factor(is_rural, 
                        levels = c(0, 1), 
                        labels = c("No", "Yes")))) +
  geom_bar() +
  labs(
    title = "Rural/Nonrural Comparison",
    x = "Rural"
  )
ggsave(paste0(path[3], "/rural_bar.pdf"), plot = plot)