####################################
# Title: Merge Transformed Data
# Author: Dantz Farrow
# Last Modified: 05/28/2026
####################################

# --- Load Transformed Data ---
nces <- read_rds(file.path(path[2], "nces_transform.rds"))
seda <- read_rds(file.path(path[2], "seda_transform.rds"))


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

# validation
glimpse(merge_inner) # NOTE: tech & ilc drop w/ join; charter remain
colSums(is.na(merge_inner)) # enrollment & locale: 6 NA
merge_inner[is.na(merge_inner$enrollment), ] # 4000798 & 4000797

# --- Post-merge Clean // transform rural & enrollment ---
merge_final <- merge_inner %>% 
  # drop charters / out of scope
  filter(!str_detect(district, regex("charter|College B|Inde", ignore_case = T))) %>% 
  # drop rows w/out enrollment
  filter(!is.na(enrollment)) %>% 
  mutate(
    is_rural = if_else(str_starts(locale, "4"), 1, 0), # rural encoding
    enrollment_log = log10(enrollment) # log transform enrollment
  )

# --- Verify ---
head(merge_final, 15)
tail(merge_final)
colSums(is.na(merge_final))

# --- Export Data/Clean Up Env---
write_rds(merge_final, file.path(path[2], "nces-seda.rds"))
write_csv(merge_final, file.path(path[2], "nces-seda.csv"))
rm(merge_inner, merge_left, merge_final, nces, seda)
