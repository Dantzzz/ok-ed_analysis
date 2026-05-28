####################################
# Title: Main File for Pipeline
# Author: Dantz Farrow
# Last Modified: 05/26/2026
# Description: 
# Notes: For troubleshooting, follow code-block annotations.
####################################

# --- 1. Load Packages, Paths, and Raw Data
source("scripts/01_setup.R") ### Populate Raw Datasets from /data/raw/

# --- 2. Examine Raw Data
source("scripts/02_pre-exam.R") ### No output

# --- 3. Clean Data (NCES & SEDA)
# TODO: conditional to check generated files exist
source("scripts/03a_nces-clean.R") ### Output: data/transformed/nces.rds
source("scripts/03b_seda-clean.R") ### Output: data/transformed/seda.rds

# --- 4. Merge Datasets
source("scripts/04_merge.R")

# --- 5. Exploratory Data Analysis