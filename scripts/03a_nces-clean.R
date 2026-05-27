####################################
# Title: Clean Data (NCES)
# Author: Dantz Farrow
# Last Modified: 05/26/2026
####################################

# --- Pre-processing ---
nces_proc <- nces_raw %>%
  # drop unnecessary columns
  select(1, 26, 15:25, 4:14) %>%
  # modify column names
  rename_with(~paste0("locale_", str_sub(.x, -7, -1)), starts_with("Locale")) %>% 
  rename_with(~paste0("enrollment_", str_sub(.x, -7, -1)), starts_with("Total")) %>% 
  rename_with(~paste0("fips_full"), starts_with("Agency ID")) %>% 
  rename(district_name = "Agency Name")

# --- Pivot & Sub NULL Values ---
nces_long <- nces_proc %>% 
  # pivot processed data on enrollment
  pivot_longer(
    cols = starts_with("enrollment"),
    names_to = "year",
    names_prefix = "enrollment_",
    values_to = "enrollment"
  ) %>%
  # substitute NAs and cast to numeric
  mutate(enrollment = na_if(enrollment, "†")) %>% 
  mutate(enrollment = as.numeric(enrollment))

locale_long <- nces_proc %>% 
  # pivot locales into new df
  pivot_longer(
    cols = starts_with("locale"),
    names_to = "year",
    names_prefix = "locale_",
    values_to = "locale"
  ) %>% 
  mutate(locale = na_if(locale, "†")) %>% 
  select(fips_full, year, locale)

nces_clean <- nces_long %>% 
  # drop locale wide cols
  select(1:2, 14:15) %>% 
  # rejoin locale_long
  left_join(locale_long, by = c("fips_full", "year"))

# --- Export Dataset & Clean Up Env ---
write_csv(nces_clean, file.path(TRANSFORMED, "nces_final.csv"))
rm(locale_long, nces_long, nces_proc, nces_raw)
