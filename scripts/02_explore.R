####################################
# Title: Data Exploration
# Author: Dantz Farrow
# Last Modified: 05/27/2026
####################################

# --- Display Data ---
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
# - Join key: sedaadmin + year (join key)

# table(seda_raw$subcat, seda_raw$subgroup)