# Peter van Galen, 241126
# This script generates a matrix where the color indicates the number of differences between molecular barcodes.

# Load packages
library(stringdist)
library(tidyverse)

# Start with a clean slate
rm(list=ls())

# Load data: refer to a .txt file that contains barcodes, one per line. All barcodes should be the same length.
barcodes_df <- read.table("/Users/vangalen/Desktop/bcs.txt", sep = "\t", na.strings = "NA", header = F)

# Calculate differences in barcodes
barcodes2_df <- barcodes_df %>% mutate(V1 = paste0(V1, "_", row_number())) %>%
  mutate(V1 = factor(V1, levels = unique(V1)))
hamming_tib <- tibble(Var1 = rep(barcodes2_df$V1, times = nrow(barcodes2_df)), Var2 = rep(barcodes2_df$V1, each = nrow(barcodes2_df))) %>%
  rowwise() %>%
  mutate(Distance = stringdist(sub("_.*", "", Var1), sub("_.*", "", Var2), method = "hamming")) %>%
  ungroup()

# Plot
ggplot(hamming_tib, aes(x = Var1, y = Var2, fill = Distance)) +
  geom_tile() +
  scale_fill_gradientn(colors = c("darkred", "darkred", "orangered", "darkgreen", "forestgreen", rep("limegreen", max(hamming_tib$Distance)-4)),
    breaks = c(0:max(hamming_tib$Distance)),   
    guide = "legend") +
  scale_x_discrete(labels = function(x) sub("_.*", "", x)) +
  scale_y_discrete(labels = function(x) sub("_.*", "", x)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.title = element_blank(),
        aspect.ratio = 1)

