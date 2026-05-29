####################################
# Title: Merge Transformed Data
# Author: Dantz Farrow
# Last Modified: 05/28/2026
####################################

# --- Load Transformed Data ---
nces <- read_rds(file.path(TRANSFORM, "nces_transform.rds"))
seda <- read_rds(file.path(TRANSFORM, "seda_transform.rds"))


# --- Merge Datasets ---
# merge_left retained for optional examination; 
# merge_inner proceeds along pipeline

# enrollment & cs_score == F
merge_left <- nces %>% 
  left_join(seda, by = c("fips_full", "year")) %>% 
  select(fips = fips_full, district = district_name.x, year, enrollment, cs_score)
glimpse(merge_left)

# enrollment & cs_score == T
merge_inner <- nces %>% 
  # join on composite key
  inner_join(seda, by = c("fips_full", "year")) %>% 
  # Column select/rename
  select(fips = fips_full, district = district_name.x, year, enrollment, cs_score, locale)

# dtype validation
glimpse(merge_inner) # NOTE: tech & ilc drop w/ join; charter remain

# --- Post-merge Clean ---
merge_final <- merge_inner %>% 
  # drop charters / out of scope
  filter(!str_detect(district, regex("charter|College B|Inde", ignore_case = T)))

# --- Export Data/Clean Up Env---
write_rds(merge_final, file.path(TRANSFORM, "nces-seda.rds"))
write_csv(merge_final, file.path(TRANSFORM, "nces-seda.csv"))
rm(merge_inner, merge_left, merge_final, nces, seda)