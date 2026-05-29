####################################
# Title: Clean Data (SEDA)
# Author: Dantz Farrow
# Last Modified: 05/28/2026
####################################

# --- Pre-processing ---
seda_transform <- seda_raw %>% 
  select(
    fips_full = sedaadmin,
    district_name = sedaadminname,
    year,
    cs_score = cs_mn_avg_ol,
    cs_score_se = cs_mn_avg_ol_se,
    cs_score_se_adj = cs_mn_avg_ol_se_adj
  )

# --- Export Data/Clean Up Env ---
write_csv(seda_transform, file.path(path[2], "seda_transform.csv"))
saveRDS(seda_transform, file.path(path[2], "seda_transform.rds"))
rm(seda_raw, seda_transform)