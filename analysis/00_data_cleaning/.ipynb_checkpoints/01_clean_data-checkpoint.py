import pandas as pd

df = pd.concat([pd.read_stata(f"country_partner_hsproduct4digit_year_{y}.dta") for y in range(2011, 2015)])
df = df.drop(["location_id", "partner_id", "product_id", "import_value", "hs_eci", "hs_coi"], 1)

df = df[~df["hs_product_code"].isin(set(["9999", "XXXX"])) & ~df["location_code"].isin(set(["ANS",])) & ~df["partner_code"].isin(set(["ANS",]))]
df.columns = ("year", "dollars", "exporter", "importer", "prod")
df = df[["exporter", "importer", "prod", "year", "dollars"]]

country_size = df.groupby(by = "exporter")["dollars"].sum() + df.groupby(by = "importer")["dollars"].sum()
product_size = df.groupby(by = "prod")["dollars"].sum()

countries = set(country_size[country_size > 1.15e10].index)
products = set(product_size[product_size > 2.5e9].index)

df = df[df["exporter"].isin(countries) & df["importer"].isin(countries) & df["prod"].isin(products)]
df = df[df["dollars"] > 0]
df = df.groupby(by = ["exporter", "importer", "prod"])["dollars"].sum().reset_index()

pop = pd.read_csv("pop.csv")
pop = pop[pop["exporter"].isin(countries)]
pop["pop"] = pop[["2011", "2012", "2013", "2014"]].mean(axis = 1)

mccp = df.copy()
mccp = mccp.merge(pop[["exporter", "pop"]], on = "exporter").merge(pop[["exporter", "pop"]], left_on = "importer", right_on = "exporter", suffixes = ("_expop", "_impop"))
mccp["pop"] = mccp["pop_expop"] + mccp["pop_impop"]
mccp = mccp.drop(["exporter_impop", "pop_expop", "pop_impop"], 1).rename(columns = {"exporter_expop": "exporter"})
pop_tot = mccp.drop_duplicates(subset = ["exporter", "importer"])["pop"].sum()
link_sum = mccp.groupby(by = ["exporter", "importer"])["dollars"].sum().reset_index()
prod_sum = mccp.groupby(by = "prod")["dollars"].sum().reset_index()
mccp = mccp.merge(link_sum, on = ["exporter", "importer"], suffixes = ("", "_linksum")).merge(prod_sum, on = "prod", suffixes = ("", "_prodsum"))
mccp["rca"] = (mccp["dollars"] / mccp["dollars_linksum"]) / (mccp["dollars_prodsum"] / mccp["dollars"].sum())
mccp["rpop"] = (mccp["dollars"] / mccp["pop"]) / (mccp["dollars_prodsum"] / pop_tot)
mccp = mccp.drop(["pop", "dollars_linksum", "dollars_prodsum"], 1)
mccp.to_csv("mccp.csv", index = False, sep = "\t")

mcp_exp = df.copy()
mcp_exp = mcp_exp.groupby(by = ["exporter", "prod"])["dollars"].sum().reset_index()
mcp_exp = mcp_exp.merge(pop[["exporter", "pop"]], on = "exporter")
pop_tot = mcp_exp.drop_duplicates(subset = "exporter")["pop"].sum()
exp_sum = mcp_exp.groupby(by = "exporter")["dollars"].sum().reset_index()
prod_sum = mcp_exp.groupby(by = "prod")["dollars"].sum().reset_index()
mcp_exp = mcp_exp.merge(exp_sum, on = "exporter", suffixes = ("", "_expsum")).merge(prod_sum, on = "prod", suffixes = ("", "_prodsum"))
mcp_exp["rca"] = (mcp_exp["dollars"] / mcp_exp["dollars_expsum"]) / (mcp_exp["dollars_prodsum"] / mcp_exp["dollars"].sum())
mcp_exp["rpop"] = (mcp_exp["dollars"] / mcp_exp["pop"]) / (mcp_exp["dollars_prodsum"] / pop_tot)
mcp_exp = mcp_exp.drop(["pop", "dollars_expsum", "dollars_prodsum"], 1)
mcp_exp.to_csv("mcp_exp.csv", index = False, sep = "\t")

mcp_imp = df.copy()
mcp_imp = mcp_imp.groupby(by = ["importer", "prod"])["dollars"].sum().reset_index()
mcp_imp = mcp_imp.merge(pop[["exporter", "pop"]], right_on = "exporter", left_on = "importer").drop("exporter", 1)
pop_tot = mcp_imp.drop_duplicates(subset = "importer")["pop"].sum()
imp_sum = mcp_imp.groupby(by = "importer")["dollars"].sum().reset_index()
prod_sum = mcp_imp.groupby(by = "prod")["dollars"].sum().reset_index()
mcp_imp = mcp_imp.merge(imp_sum, on = "importer", suffixes = ("", "_impsum")).merge(prod_sum, on = "prod", suffixes = ("", "_prodsum"))
mcp_imp["rca"] = (mcp_imp["dollars"] / mcp_imp["dollars_impsum"]) / (mcp_imp["dollars_prodsum"] / mcp_imp["dollars"].sum())
mcp_imp["rpop"] = (mcp_imp["dollars"] / mcp_imp["pop"]) / (mcp_imp["dollars_prodsum"] / pop_tot)
mcp_imp = mcp_imp.drop(["pop", "dollars_impsum", "dollars_prodsum"], 1)
mcp_imp.to_csv("mcp_imp.csv", index = False, sep = "\t")


