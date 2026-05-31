####################################
# Title: Main File for Pipeline
# Author: Dantz Farrow
# Last Modified: 05/30/2026
# Notes: For troubleshooting, follow code-block annotations & trace output
####################################

# --- 1. Load Packages, Paths, Helper Functions
source("scripts/01_setup.R")   ### Load packages & global paths

# --- 2. Load & Examine Raw Data
source("scripts/02_pre-exam.R") ### Populate Raw Datasets from /data/raw/

if(!file.exists(file.path(path[2], "nces-seda.rds"))) {
# --- 3. Clean Data (NCES & SEDA)
  source("scripts/process/03a_nces-clean.R") ### Output: data/transformed/nces.rds
  source("scripts/process/03b_seda-clean.R") ### Output: data/transformed/seda.rds
  
# --- 4. Merge Data
  source("scripts/process/04_merge.R") ### Output: data/transformed/nces-seda.rds
} else {
  message("Merged data found. Bypass wrangling stage...")
}

# --- 5. Exploratory Data Analysis
source("scripts/analysis/05a_eda-uni.R") ### Output: output/
source("scripts/analysis/05b_eda-multi.R") ### Output: output/

# --- 6. Cross-sectional Analysis
source("scripts/analysis/06_analyze.R") ### Output: reports/