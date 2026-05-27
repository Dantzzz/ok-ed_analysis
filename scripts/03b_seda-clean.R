####################################
# Title: Clean Data (SEDA)
# Author: Dantz Farrow
# Last Modified: 05/27/2026
####################################

# --- Pre-processing ---
seda_transform <- seda_raw %>% 
  select(
    district_id = sedaadmin,
    district_name = sedaadminname,
    year,
    cs_score = cs_mn_avg_ol,
    cs_score_se = cs_mn_avg_ol_se,
    cs_score_se_adj = cs_mn_avg_ol_se_adj
  )

# --- Export Dataset/Clean Up Env ---
write_csv(seda_transform, file.path(TRANSFORMED, "seda_transform.csv"))
saveRDS(seda_transform, file.path(TRANSFORMED, "seda_transform.rds"))
rm(seda_raw, seda_transform)