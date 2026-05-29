####################################
# Title: Exploratory Data Analysis
# Author: Dantz Farrow
# Last Modified: 05/28/2026
####################################

# --- Load Data ---
 nces_seda <- read_rds(file.path(TRANSFORM, "nces-seda.rds"))

# List school names
nces_seda %>% 
  distinct(district) %>% 
  pull(district)