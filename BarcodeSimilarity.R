# Peter van Galen, 190710
# This script generates a matrix where the color indicates the number of differences between molecular barcodes.

# Load packages
library(stringdist)
library(gplots)

# Start with a clean slate
rm(list=ls())

# Load data: refer to a .txt file that contains barcodes, one per line. All barcodes should be the same length.
barcodes.df <- read.table("/Users/vangalen/Desktop/bcs.txt", sep = "\t", na.strings = "NA", header = F)

# Calculate differences in barcodes
ind.mat <- expand.grid(1:nrow(barcodes.df),1:nrow(barcodes.df))
hamming.mat <- matrix( apply(ind.mat,1,function(x,t1) stringdist(t1[x[1],1], t1[x[2],1], method = c("hamming"), useBytes = F),barcodes.df), ncol = nrow( barcodes.df ), nrow = nrow( barcodes.df ) )
colnames(hamming.mat) <- barcodes.df[,1]
rownames(hamming.mat) <- barcodes.df[,1]

# Plot
mycol <- c("darkred", "darkred", "darkred", "orangered", "orangered", "darkgreen", "darkgreen", "forestgreen", "forestgreen", rep("limegreen", (max(hamming.mat)*2-9)))
heatmap.2(hamming.mat, Rowv = F, Colv = F, dendrogram = "none", col = mycol, trace =  "none", margins = c(10,10), density.info = "none", key.xlab = "Hamming distance")

# Optional: save an image
#pdf(file = "/Users/vangalen/Desktop/hamming.pdf", height = 6, width = 6) # or
#png(file = "/Users/vangalen/Desktop/hamming.png", units = "px", height = 1800, width = 1800, res = 300)
#heatmap.2(hamming.mat, Rowv = F, Colv = F, dendrogram = "none", col = mycol, trace =  "none", margins = c(10,10), density.info = "none", key.xlab = "Hamming distance")
#dev.off()
