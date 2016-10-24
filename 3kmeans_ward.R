# K-means and Ward clustering methods
# Includes time measuares
# Base breast-cancer is used, but the process is the same for all bases

library(farff)
library(NbClust)

# Load rules and simillarity matrix
arff_data = readARFF("breast_cancer_2/breast_cancer_rules.arff")
sim <- read.table("breast_cancer_2/breast_cancer.sim.txt",sep="\t")
# Dissimillarity matrix
dissim <- (-1)*(sim - 1)
dissim <- as.dist(dissim)

# Measure silhouette and make clusters
# KMEANS
start <- Sys.time()
nb_kmeans <- NbClust(data = arff_data, diss = dissim, distance = NULL, min.nc = 5, max.nc = 50, method = "kmeans", index = "silhouette")
end <- Sys.time()
kmeans_time <- end - start

# WARD
start <- Sys.time()
nb_ward <- NbClust(data=arff_data, diss = dissim, distance = NULL, min.nc = 5, max.nc = 50, method = "ward.D2", index = "silhouette")
end <- Sys.time()
ward_time <- end - start

# Write results to file
writeLines(as.character(t(nb_kmeans$Best.partition)), "kmeans.out", sep=" ")
writeLines(as.character(t(nb_ward$Best.partition)), "ward.out", sep=" ")

# Time for one simple interation
start <- Sys.time()
nc_kmeans <- (nb_kmeans$Best.nc)[1]
kmeans_result <- kmeans(arff_data, nc_kmeans)
end <- Sys.time()
single_kmeans_time <- end - start

start <- Sys.time()
nc_ward <- (nb_ward$Best.nc)[1]
ward_result <- hclust(dissim, method = "ward.D2")
result_cluster <- cutree(ward_result, k = nc_ward)
end <- Sys.time()
single_ward_time <- end - start

# Results
kmeans_time
single_kmeans_time
ward_time
single_ward_time

(nb_kmeans$Best.nc)[1]
(nb_ward$Best.nc)[1]
