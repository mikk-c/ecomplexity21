# Economic Complexity Comparisons

Requirements:

1. Python 3.6 or newer with the following packages (everything can be installed with pip):
- Pandas
- Numpy
- Scipy
- Networkx 2.*
- xarray
- pyemd (but it's not curcial, it can be commented out from the network_distance library)

2. R 4 or newer with the following packages
- stargazer
- relaimpo (from https://prof.beuth-hochschule.de/fileadmin/prof/groemp/downloads/relaimpo\_2.2-2.tar.gz, then install.packages("relaimpo_2.2-2.tar.gz", repos = NULL, type="source");)

Open questions:

- Should the Annihilation complexity be iterative?
- Does it make any sense to calculate and include in the updates an importer complexity?
- Can we build a special Product Space in which network variance works better than it does now? (It'd be one with the core made of simple products and branches that progressively get more demanding in capabilities)

