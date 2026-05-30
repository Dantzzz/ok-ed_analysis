####################################
# Title: 
# Author: Dantz Farrow
# Last Modified:
####################################

# --- Enrollment ---
model <- lm(cs_score ~ enrollment, data = df)
summary(model)
