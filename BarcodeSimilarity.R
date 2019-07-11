# Peter van Galen, 190312
# This script generates a matrix where the color indicates the number of differences between molecular barcodes.

# Load packages
library(stringdist)
library(gplots)

# Start with a clean slate
rm(list=ls())

# Load data: refer to a .txt file that contains barcodes, one per line. All barcodes should be the same length.
table1 <- read.table("/Users/vangalen/Desktop/bcs.txt", sep = "\t", na.strings = "NA", header = F)

# Calculate differences in barcodes
ind.mat <- expand.grid(1:nrow(table1),1:nrow(table1))
hamming.mat <- matrix( apply(ind.mat,1,function(x,t1) stringdist(t1[x[1],1], t1[x[2],1], method = c("hamming"), useBytes = F),table1), ncol = nrow( table1 ), nrow = nrow( table1 ) )
colnames(hamming.mat) <- table1[,1]
rownames(hamming.mat) <- table1[,1]

# Plot
mycol <- c("darkred", "darkred", "darkred", "orangered", "orangered", "darkgreen", "darkgreen", "forestgreen", "forestgreen", rep("limegreen", (max(hamming.mat)*2-9)))
heatmap.2(hamming.mat, Rowv = F, Colv = F, dendrogram = "none", col = mycol, trace =  "none", margins = c(10,10), density.info = "none")

# To save a pdf file:
#pdf(file = "/Users/vangalen/Desktop/hamming.pdf", height = 6, width = 6)
#heatmap.2(hamming.mat, Rowv = F, Colv = F, dendrogram = "none", col = mycol, trace =  "none", margins = c(10,10), density.info = "none")
#dev.off()
