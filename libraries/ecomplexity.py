import numpy as np
import pandas as pd

# Traditional ECI, defined in "The Atlas of Economic Complexity" (2011)
# ECI wants an MCP_exp matrix as an input.
# You can specify whether you want the RCA or RPOP variant, and the threshold to binarize
# The threshold should be 0.25 if variant is RPOP
# Returns two dataframes, with ECI and PCI respectively
def eci(mcp, variant = "rca", threshold = 1):
   # Binarize the MCP matrix
   mcp_rca = pd.pivot_table(data = mcp, index = "prod", columns = "exporter", values = variant).fillna(0.0) >= threshold
   # The following is the derivation as it appears in the Technical box 2.1 of "The Atlas of Economic Complexity"
   # The number of products exported by a country
   diversity = mcp_rca.sum(axis = 0)
   # The number of countries exporting a product
   ubiquity = mcp_rca.sum(axis = 1)
   # Matrices normalized by row/column sums
   mcp_rca1 = (mcp_rca / diversity).T
   mcp_rca2 = (mcp_rca.T / ubiquity).T
   # Mcc to calculate ECI, Mpp to calculate PCI
   mcc = mcp_rca1.dot(mcp_rca2)
   mpp = mcp_rca2.dot(mcp_rca1)
   # ECI (PCI) is the eigenvector associated with the second largest eigenvalue of Mcc (Mpp)
   eci_W, eci_v = np.linalg.eig(mcc)
   pci_W, pci_v = np.linalg.eig(mpp)
   # Need to argsort because numpy will return eigenvalues in a random order
   eci = np.real(eci_v[:,eci_W.argsort()[::-1]])[:,1]
   pci = np.real(pci_v[:,pci_W.argsort()[::-1]])[:,1]
   # Standardize the vectors
   eci = (eci - np.mean(eci)) / np.std(eci)
   pci = (pci - np.mean(pci)) / np.std(pci)
   eci_df = pd.DataFrame()
   eci_df["exporter"] = mcp_rca.columns
   eci_df["eci"] = eci
   pci_df = pd.DataFrame()
   pci_df["prod"] = mcp_rca.index
   pci_df["pci"] = pci
   # Flip the vectors in case the eigenvectors were returned sorted the wrong way around
   if eci_df[eci_df["exporter"] == "JPN"].iloc[0]["eci"] < 0:
      eci_df["eci"] *= -1
   if pci_df[pci_df["prod"] == "2709"].iloc[0]["pci"] > 0:
      pci_df["pci"] *= -1
   return eci_df, pci_df

# Fitness as defined in "A New Metrics for Countries' Fitness and Products' Complexity" (2012) -- there is a 2018 version I haven't looked at yet
# Fitness wants an MCP_exp matrix as an input.
# You can specify whether you want the RCA or RPOP variant, and the threshold to binarize
# The threshold should be 0.25 if variant is RPOP
# Returns two dataframes, with Fitness and Complexity respectively
def fitness12(mcp, variant = "rca", threshold = 1):
   # Binarize the MCP matrix
   mcp_rca = pd.pivot_table(data = mcp, index = "prod", columns = "exporter", values = variant).fillna(0.0) >= threshold
   # Starting condition is that all products/countries have the same complexity/fitness
   complexity = np.ones(mcp_rca.shape[0])
   fitness = np.ones(mcp_rca.shape[1])
   tol = 1
   # Iterate until convergence
   while tol > 0.0001:
      # The following is the derivation as it appears in the 2012 paper
      new_fitness = mcp_rca.T.dot(complexity)
      new_fitness /= new_fitness.mean()
      new_complexity = 1 / mcp_rca.dot(1 / fitness)
      new_complexity /= new_complexity.mean()
      tol = (np.abs(complexity - new_complexity).mean() + np.abs(fitness - new_fitness).mean()) / 2
      complexity = new_complexity.copy()
      fitness = new_fitness.copy()
   return fitness.reset_index().rename(columns = {0: "fitness12"}), complexity.reset_index().rename(columns = {0: "complexity12"})
