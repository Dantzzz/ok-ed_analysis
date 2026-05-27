####################################
# Title: Main File for Pipeline
# Author: Dantz Farrow
# Last Modified: 05/26/2026
# Notes: For troubleshooting, follow code-block annotations.
####################################

# --- 1. Load Packages, Paths, and Raw Data
### Populate Raw Datasets
source("scripts/01_setup.R")

# --- 2. Examine Data

# --- 3. Clean Data (NCES & SEDA)
### Output: Transformed Datasets
source("scripts/03a_nces-clean.R")
# source("scripts/03b_seda-clean.R")

# --- 4. Consolidate Dataset