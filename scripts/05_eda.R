####################################
# Title: Exploratory Data Analysis
# Author: Dantz Farrow
# Last Modified: 05/28/2026
####################################

# List school names
merge_final %>% 
  distinct(district) %>% 
  pull(district)