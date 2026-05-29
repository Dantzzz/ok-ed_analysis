####################################
# Title: Raw Data Exploration
# Author: Dantz Farrow
# Last Modified: 05/28/2026
####################################

# --- Load Raw Data ---
seda_raw <- read_csv(file.path(path[1], "seda_admindist_annual_cs_2025.1.csv")) %>%
  filter(fips == 40 & year > 2013 & subcat == "all")  # Filter relevant data on load

nces_raw <- read_csv(
  here(path[1], "ELSI_csv_export_6391540499159388704263.csv"),
  skip = 6,
  n_max = 626) # strip metadata

# --- Shape & Structure + Notes ---
glimpse(nces_raw)
# Notes: 
# - Dim: 626 x 37
# - Rename: "Agency Name", "Agency ID", "Locale...", "Total Stu.."
# - Pivot: "Locale..", "Total Stu.."
# - Drop: "State Name..", "ANSI.."
# - Sub NAs: locale & enrollment

glimpse(seda_raw)
# Notes: 
# - Dim: 4650 x 20
# - Retain: sedadmin, sedaadminname, year, cs_mn_avg_ol, .._se, .._se_adj
# - Join key: sedaadmin + year (join key)

# --- Check Missing Values ---
colSums(is.na(seda_raw)) # none
colSums(nces_raw == "†", na.rm = TRUE) # masked †
