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