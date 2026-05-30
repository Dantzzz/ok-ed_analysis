####################################
# Title: Helper Functions for OK-Ed_Analysis
# Author: Dantz Farrow
# Last Modified: 05/30/2026
####################################

# Calculate mode
calc_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}