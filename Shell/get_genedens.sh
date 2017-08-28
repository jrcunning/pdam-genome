#!/bin/bash

# Get start positions of all genes on each scaffold
# $1 = gff.gz
# $2 = fasta.gz
# $3 = output basename

tar -xOzf $1 | awk '$3 == "gene" {print}' | cut -f1,4 > $3.genes.txt

# Get total length of each scaffold
tar -xOzf $2 | samtools faidx -
cut -f1-2 ./-.fai > $3.scaffold.lengths.txt
rm ./-.fai

# Run R script to calc gene density
R --vanilla < ../R/genedens.R --args $3.genes.txt $3.scaffold.lengths.txt $3
