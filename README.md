# BarcodeSimilarity

BarcodeSimilarity.R is a short script to test the similarity of barcodes for Illumina sequencing. It is helpful to ensure no barcode collisions will occur.

You need to load a data frame where each row is a barcode sequence of equal length. The script will generate a figure where the color indicates the number of differences between molecular barcodes.

Two examples are included:
* In the first, we test the similarity between 8 bp Illumina library barcodes using the script BarcodeSimilarity.R and Illumina_libraries/bcs.txt as input. The output is Illumina_libraries/hamming.png (see below).
* In the second, we test the similarity between barcodes of the SunCatcher barcoding system using the similar script McAllister_SunCatcher/McAllister_barcodes.R and McAllister_SunCatcher/BC_sequences.xlsx as input. The output is McAllister_SunCatcher/hamming.pdf.

![Alt text](Illumina_libraries/hamming.png)
