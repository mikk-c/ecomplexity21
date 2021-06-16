library(relaimpo);
library(stargazer);

df <- read.csv("growth_regression_table.csv", sep = "\t");

# First we run a light version of the regression without the government indicators
# This replicates more or less the original regression in the Atlas Table 3.2.1 column 2
# This runs it for GDP PC
m1 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rca + eci_rca, data = df);
m2 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rpop + eci_rpop, data = df);
m3 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rca + fitness12_rca, data = df);
m4 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rpop + fitness12_rpop, data = df);
m5 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rca + ann_rca, data = df);
m6 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rpop + ann_rpop, data = df);
m7 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rca + var_rca, data = df);
m8 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rpop + var_rpop, data = df);
m9 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rca + moran_rca, data = df);
m10 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rpop + moran_rpop, data = df);

stargazer(m1, m3, m5, m7, m9, title = "GDP PC RCA", align = TRUE, df = FALSE);
stargazer(m2, m4, m6, m8, m10, title = "GDP PC RPOP", align = TRUE, df = FALSE);

# And this runs it for GDP PC PPP
m1 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rca + eci_rca, data = df);
m2 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rpop + eci_rpop, data = df);
m3 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rca + fitness12_rca, data = df);
m4 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rpop + fitness12_rpop, data = df);
m5 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rca + ann_rca, data = df);
m6 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rpop + ann_rpop, data = df);
m7 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rca + var_rca, data = df);
m8 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rpop + var_rpop, data = df);
m9 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rca + moran_rca, data = df);
m10 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rpop + moran_rpop, data = df);

stargazer(m1, m3, m5, m7, m9, title = "GDP PC PPP RCA", align = TRUE, df = FALSE);
stargazer(m2, m4, m6, m8, m10, title = "GDP PC PPP RPOP", align = TRUE, df = FALSE);

# Now we run the full regression with the government quality indicators to get a R2 decomposition
# This should more or less replicate what is in the Atlas Figure 4.1
# This runs it for GDP PC (first RCA then RPOP)
m1 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rca + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + eci_rca, data = df);
m2 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rpop + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + eci_rpop, data = df);
m3 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rca + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + fitness12_rca, data = df);
m4 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rpop + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + fitness12_rpop, data = df);
m5 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rca + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + ann_rca, data = df);
m6 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rpop + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + ann_rpop, data = df);
m7 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rca + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + var_rca, data = df);
m8 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rpop + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + var_rpop, data = df);
m9 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rca + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + moran_rca, data = df);
m10 <- lm(log(gdppc_end / gdppc_start) ~ log(gdppc_start) + nat_res_share_increase + export_share_increase + diversity_rpop + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + moran_rpop, data = df);

eci_rca_relaimpo <- calc.relimp(m1, type = "pmvd");
eci_rpop_relaimpo <- calc.relimp(m2, type = "pmvd");
fitness12_rca_relaimpo <- calc.relimp(m3, type = "pmvd");
fitness12_rpop_relaimpo <- calc.relimp(m4, type = "pmvd");
ann_rca_relaimpo <- calc.relimp(m5, type = "pmvd");
ann_rpop_relaimpo <- calc.relimp(m6, type = "pmvd");
var_rca_relaimpo <- calc.relimp(m7, type = "pmvd");
var_rpop_relaimpo <- calc.relimp(m8, type = "pmvd");
moran_rca_relaimpo <- calc.relimp(m9, type = "pmvd");
moran_rpop_relaimpo <- calc.relimp(m10, type = "pmvd");

# I put everything in a Latex table ready to be pasted into a paper. This is for RCA
cat("\n\\begin{table}\n\\centering\n\\begin{tabular}{l|rrrrr}\n")
cat("Variable & eci\\_rca & fitness\\_rca & ann\\_rca & var\\_rca & moran\\_rca\\\\\n\\hline\n")
for(v in names(eci_rca_relaimpo$pmvd)[1:length(eci_rca_relaimpo$pmvd) - 1]){
   cat(paste(gsub("_", "\\\\_", v), sprintf("%.4f", eci_rca_relaimpo$pmvd[[v]]), sprintf("%.4f", fitness12_rca_relaimpo$pmvd[[v]]), sprintf("%.4f", ann_rca_relaimpo$pmvd[[v]]), sprintf("%.4f", var_rca_relaimpo$pmvd[[v]]), sprintf("%.4f", moran_rca_relaimpo$pmvd[[v]]), sep = " & "));
   cat("\\\\\n");
}
cat("\\hline\n");
# The lines above were for the control variables, this last line records the contribution to the R2 of our predictor
cat(paste("*", sprintf("%.4f", eci_rca_relaimpo$pmvd[["eci_rca"]]), sprintf("%.4f", fitness12_rca_relaimpo$pmvd[["fitness12_rca"]]), sprintf("%.4f", ann_rca_relaimpo$pmvd[["ann_rca"]]), sprintf("%.4f", var_rca_relaimpo$pmvd[["var_rca"]]), sprintf("%.4f", moran_rca_relaimpo$pmvd[["moran_rca"]]), sep = " & "));
cat("\\\\\n");
cat("\\end{tabular}\n\\caption{GDP PC R2 contributions}\n\\label{tab:gdppcr2contr-rca}\n\\end{table}\n\n");

# Again for RPOP
cat("\n\\begin{table}\n\\centering\n\\begin{tabular}{l|rrrrr}\n")
cat("Variable & eci\\_rpop & fitness\\_rpop & ann\\_rpop & var\\_rpop & moran\\_rpop\\\\\n\\hline\n")
for(v in names(eci_rpop_relaimpo$pmvd)[1:length(eci_rpop_relaimpo$pmvd) - 1]){
   cat(paste(gsub("_", "\\\\_", v), sprintf("%.4f", eci_rpop_relaimpo$pmvd[[v]]), sprintf("%.4f", fitness12_rpop_relaimpo$pmvd[[v]]), sprintf("%.4f", ann_rpop_relaimpo$pmvd[[v]]), sprintf("%.4f", var_rpop_relaimpo$pmvd[[v]]), sprintf("%.4f", moran_rpop_relaimpo$pmvd[[v]]), sep = " & "));
   cat("\\\\\n");
}
cat("\\hline\n");
cat(paste("*", sprintf("%.4f", eci_rpop_relaimpo$pmvd[["eci_rpop"]]), sprintf("%.4f", fitness12_rpop_relaimpo$pmvd[["fitness12_rpop"]]), sprintf("%.4f", ann_rpop_relaimpo$pmvd[["ann_rpop"]]), sprintf("%.4f", var_rpop_relaimpo$pmvd[["var_rpop"]]), sprintf("%.4f", moran_rpop_relaimpo$pmvd[["moran_rpop"]]), sep = " & "));
cat("\\\\\n");
cat("\\end{tabular}\n\\caption{GDP PC R2 contributions}\n\\label{tab:gdppcr2contr-rpop}\n\\end{table}\n\n");

# And this runs it for GDP PC PPP (first RCA then RPOP)
m1 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rca + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + eci_rca, data = df);
m2 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rpop + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + eci_rpop, data = df);
m3 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rca + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + fitness12_rca, data = df);
m4 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rpop + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + fitness12_rpop, data = df);
m5 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rca + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + ann_rca, data = df);
m6 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rpop + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + ann_rpop, data = df);
m7 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rca + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + var_rca, data = df);
m8 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rpop + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + var_rpop, data = df);
m9 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rca + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + moran_rca, data = df);
m10 <- lm(log(gdppcppp_end / gdppcppp_start) ~ log(gdppcppp_start) + nat_res_share_increase + export_share_increase + diversity_rpop + rulelaw + corrupt + govteffectiv + voice + polstab + regqual + moran_rpop, data = df);

eci_rca_relaimpo <- calc.relimp(m1, type = "pmvd");
eci_rpop_relaimpo <- calc.relimp(m2, type = "pmvd");
fitness12_rca_relaimpo <- calc.relimp(m3, type = "pmvd");
fitness12_rpop_relaimpo <- calc.relimp(m4, type = "pmvd");
ann_rca_relaimpo <- calc.relimp(m5, type = "pmvd");
ann_rpop_relaimpo <- calc.relimp(m6, type = "pmvd");
var_rca_relaimpo <- calc.relimp(m7, type = "pmvd");
var_rpop_relaimpo <- calc.relimp(m8, type = "pmvd");
moran_rca_relaimpo <- calc.relimp(m9, type = "pmvd");
moran_rpop_relaimpo <- calc.relimp(m10, type = "pmvd");

cat("\n\\begin{table}\n\\centering\n\\begin{tabular}{l|rrrrr}\n")
cat("Variable & eci\\_rca & fitness\\_rca & ann\\_rca & var\\_rca & moran\\_rca\\\\\n\\hline\n")
for(v in names(eci_rca_relaimpo$pmvd)[1:length(eci_rca_relaimpo$pmvd) - 1]){
   cat(paste(gsub("_", "\\\\_", v), sprintf("%.4f", eci_rca_relaimpo$pmvd[[v]]), sprintf("%.4f", fitness12_rca_relaimpo$pmvd[[v]]), sprintf("%.4f", ann_rca_relaimpo$pmvd[[v]]), sprintf("%.4f", var_rca_relaimpo$pmvd[[v]]), sprintf("%.4f", moran_rca_relaimpo$pmvd[[v]]), sep = " & "));
   cat("\\\\\n");
}
cat("\\hline\n");
cat(paste("*", sprintf("%.4f", eci_rca_relaimpo$pmvd[["eci_rca"]]), sprintf("%.4f", fitness12_rca_relaimpo$pmvd[["fitness12_rca"]]), sprintf("%.4f", ann_rca_relaimpo$pmvd[["ann_rca"]]), sprintf("%.4f", var_rca_relaimpo$pmvd[["var_rca"]]), sprintf("%.4f", moran_rca_relaimpo$pmvd[["moran_rca"]]), sep = " & "));
cat("\\\\\n");
cat("\\end{tabular}\n\\caption{GDP PC PPP R2 contributions}\n\\label{tab:gdppcpppr2contr-rca}\n\\end{table}\n\n");

cat("\n\\begin{table}\n\\centering\n\\begin{tabular}{l|rrrrr}\n")
cat("Variable & eci\\_rpop & fitness\\_rpop & ann\\_rpop & var\\_rpop & moran\\_rpop\\\\\n\\hline\n")
for(v in names(eci_rpop_relaimpo$pmvd)[1:length(eci_rpop_relaimpo$pmvd) - 1]){
   cat(paste(gsub("_", "\\\\_", v), sprintf("%.4f", eci_rpop_relaimpo$pmvd[[v]]), sprintf("%.4f", fitness12_rpop_relaimpo$pmvd[[v]]), sprintf("%.4f", ann_rpop_relaimpo$pmvd[[v]]), sprintf("%.4f", var_rpop_relaimpo$pmvd[[v]]), sprintf("%.4f", moran_rpop_relaimpo$pmvd[[v]]), sep = " & "));
   cat("\\\\\n");
}
cat("\\hline\n");
cat(paste("*", sprintf("%.4f", eci_rpop_relaimpo$pmvd[["eci_rpop"]]), sprintf("%.4f", fitness12_rpop_relaimpo$pmvd[["fitness12_rpop"]]), sprintf("%.4f", ann_rpop_relaimpo$pmvd[["ann_rpop"]]), sprintf("%.4f", var_rpop_relaimpo$pmvd[["var_rpop"]]), sprintf("%.4f", moran_rpop_relaimpo$pmvd[["moran_rpop"]]), sep = " & "));
cat("\\\\\n");
cat("\\end{tabular}\n\\caption{GDP PC PPP R2 contributions}\n\\label{tab:gdppcpppr2contr-rpop}\n\\end{table}\n\n");