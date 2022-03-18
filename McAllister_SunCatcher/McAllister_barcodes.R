# Peter van Galen, 220316
# This script generates a matrix where the color indicates the number of differences between molecular barcodes.

# Load packages
library(stringdist)
library(gplots)
library(viridisLite)
library(readxl)

# Start with a clean slate
rm(list=ls())

# Load data: refer to a .txt file that contains barcodes, one per line. All barcodes should be the same length.
barcodes_tib <- read_excel("BC_sequences.xlsx", sheet = 4, skip = 1)
barcodes_df <- data.frame(bc = barcodes_tib$`Sequence(5’-3’)`)
rownames(barcodes_df) <- paste(barcodes_tib$`Oligo ID`, barcodes_tib$`Sequence(5’-3’)`)
barcodes_df <- barcodes_df[1:(nrow(barcodes_df)-3),,drop = F]

# Calculate differences in barcodes
ind.mat <- expand.grid(1:nrow(barcodes_df),1:nrow(barcodes_df))
hamming.mat <- matrix( apply(ind.mat,1,function(x,t1) stringdist(t1[x[1],1], t1[x[2],1], method = c("hamming"), useBytes = F),barcodes_df), ncol = nrow( barcodes_df ), nrow = nrow( barcodes_df ) )
colnames(hamming.mat) <- rownames(barcodes_df)
rownames(hamming.mat) <- rownames(barcodes_df)

# Plot. It's best to shift the legend numbers in Illustrator so they're in the middle of the "bar".
mycol <- topo.colors(max(hamming.mat)+1) # Add 1 because 0 is also a value in the matrix.
heatmap.2(hamming.mat, Rowv = F, Colv = F, dendrogram = "none", col = mycol, trace =  "none", margins = c(16,16), density.info = "none", key.xlab = "Hamming distance")

# Save an image
pdf(file = "hamming.pdf", height = 12, width = 12)
heatmap.2(hamming.mat, Rowv = F, Colv = F, dendrogram = "none", col = mycol, trace =  "none", margins = c(16,16), density.info = "none", key.xlab = "Hamming distance")
dev.off()
