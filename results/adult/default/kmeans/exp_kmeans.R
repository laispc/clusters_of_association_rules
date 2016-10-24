# Packages
library(farff)
library(ggplot2)
library(factoextra)
library(cluster)
library(NbClust)

# Load rules set .arff into a data frame
arff_data = readARFF("../adult_rules.arff")

# Simillarity matrix
sim_matrix <- read.table("../adult.sim.txt",sep="\t")

# Dissimillarity matrix
dissim_matrix = (1 - sim_matrix)

# KMEANS
nb_result_kmeans <- NbClust(data = arff_data, diss = dissim_matrix, distance = NULL, min.nc = 5, max.nc = 100, method = "kmeans", index = "all")

# Graphic with results!
fviz_nbclust(nb_result_kmeans) + theme_minimal()

save.image("kmeans.RData")
