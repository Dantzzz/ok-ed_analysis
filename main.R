####################################
# Title: Main File for Pipeline
# Author: Dantz Farrow
# Last Modified: 05/26/2026
# Notes: For troubleshooting, follow code-block annotations.
####################################

# --- 1. Load Packages, Paths, and Raw Data
source("scripts/01_setup.R")   ### Load packages & global paths

# --- 2. Examine Raw Data
source("scripts/02_pre-exam.R") ### Populate Raw Datasets from /data/raw/

if(!file.exists(file.path(TRANSFORM, "nces-seda.rds"))) {
# --- 3. Clean Data (NCES & SEDA)
  source("scripts/03a_nces-clean.R") ### Output: data/transformed/nces.rds
  source("scripts/03b_seda-clean.R") ### Output: data/transformed/seda.rds
  
# --- 4. Merge Data
  source("scripts/04_merge.R") ### Output: data/transformed/nces-seda.rds
} else {
  message("Merged data found. Bypass wrangling stage...")
}

# --- 5. Exploratory Data Analysis
source("scripts/05_eda.R")