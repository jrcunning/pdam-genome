#!/bin/bash

# Get start positions of all genes on each scaffold
# $1 = gff.gz
# $2 = fasta.gz
# $3 = output basename

gunzip $1 | awk '$3 == "gene" {print}' | cut -f1,4 > $3.genes.txt

# Get total length of each scaffold
gunzip $2 | samtools faidx
cut -f1-2 $2.fai > $3.scaffold.lengths.txt



# Run R script to calc gene density
R --vanilla < genedens.R --args $3.genes.txt $3.scaffold.lengths.txt
