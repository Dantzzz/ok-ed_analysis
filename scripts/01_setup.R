####################################
# Title: 01. Set Up - Packages, Paths, & Raw Data
# Author: Dantz Farrow
# Last Modified: 05/27/2026
####################################

# --- Packages ---
library(dplyr); library(here); library(ggplot2); library(readr)
library(stringr); library(tidyr)

# --- File Paths (Global) ---
RAW <- here("data", "raw")
TRANSFORM <- here("data", "transformed")
OUT <- here("output")

# --- Load Raw Data ---
seda_raw <- read_csv(file.path(RAW, "seda_admindist_annual_cs_2025.1.csv")) %>%
  filter(fips == 40 & year > 2013 & subcat == "all")     # Filter relevant data on load

nces_raw <- read_csv(
  here(RAW, "ELSI_csv_export_6391540499159388704263.csv"),
  skip = 6,
  n_max = 626) # strip metadata