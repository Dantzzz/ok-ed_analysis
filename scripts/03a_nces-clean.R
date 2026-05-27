####################################
# Title: Clean Data (NCES)
# Author: Dantz Farrow
# Last Modified: 05/26/2026
####################################

# --- Pre-processing
nces_clean <- nces_raw %>%
  # drop unnecessary columns
  select(1, 26, 15:25, 4:14) %>%
  # modify column names
  rename_with(~paste0("locale_", str_sub(.x, -7, -1)), starts_with("Locale")) %>% 
  rename_with(~paste0("enrollment_", str_sub(.x, -7, -1)), starts_with("Total")) %>% 
  rename_with(~paste0("fips_full"), starts_with("Agency ID")) 

# --- Pivot NCES to Long ---

# --- Mutate Across Datasets to Maintain Uniqueness ---

# --- Exclude Charter Schools ---