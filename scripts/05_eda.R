####################################
# Title: Exploratory Data Analysis
# Author: Dantz Farrow
# Last Modified: 05/28/2026
####################################

# --- Load Data ---
df <- read_rds(file.path(path[2], "nces-seda.rds"))

# --- Inspect ---
summary(df)           # summary stats

hist(df$enrollment)   # heavily right-skewed 

hist(df$cs_score)     # normal distribution

hist(df$year)       
df %>% distinct(year) # missing 2020, 2021 (Covid-19)

df %>% count(locale)  # skewed rural
df %>% count(is_rural) 
