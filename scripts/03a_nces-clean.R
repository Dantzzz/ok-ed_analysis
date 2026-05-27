####################################
# Title: Clean Data (NCES)
# Author: Dantz Farrow
# Last Modified: 05/27/2026
####################################

# --- Pre-processing ---
nces_proc <- nces_raw %>%
  # drop unnecessary columns
  select(1, 26, 15:25, 4:14) %>%
  # modify column names
  # rename_with(., .fn, .cols) 
  rename_with(~paste0("locale_", str_sub(.x, -7, -1)), starts_with("Locale")) %>% 
  rename_with(~paste0("enrollment_", str_sub(.x, -7, -1)), starts_with("Total")) %>% 
  rename(fips_full = starts_with("Agency ID")) %>% 
  rename(district_name = "Agency Name")

# --- Pivot & Sub NULL Values ---
nces_long <- nces_proc %>% 
  # pivot: year, enrollment
  pivot_longer(
    cols = starts_with("enrollment"),
    names_to = "year",
    names_prefix = "enrollment_", # strips prefix
    values_to = "enrollment"
  ) %>%
  # sub NAs
  mutate(enrollment = na_if(enrollment, "†")) %>% 
  # cast numeric
  mutate(enrollment = as.numeric(enrollment))

locale_long <- nces_proc %>% 
  # pivot: year, locale
  pivot_longer(
    cols = starts_with("locale"),
    names_to = "year",
    names_prefix = "locale_",
    values_to = "locale"
  ) %>% 
  # sub NAs
  mutate(locale = na_if(locale, "†")) %>% 
  # fips_full + year = join key
  select(fips_full, year, locale)

nces_transform <- nces_long %>% 
  # drop locale wide cols
  select(district_name, fips_full, year, enrollment) %>% 
  # rejoin locale_long
  left_join(locale_long, by = c("fips_full", "year"))

# --- Export Dataset/Clean Up Env ---
write_csv(nces_transform, file.path(TRANSFORMED, "nces_transform.csv"))
saveRDS(nces_transform, file.path(TRANSFORMED, "nces_transform.rds"))
rm(locale_long, nces_long, nces_proc, nces_raw)
