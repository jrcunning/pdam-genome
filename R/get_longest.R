library(Biostrings)

args = commandArgs(trailingOnly=TRUE)

infile <- args[1]
outfile <- args[2]

seqs <- readAAStringSet(infile)
longest <- seqs[which.max(width(seqs))]

writeXStringSet(longest, filepath=outfile, format="fasta")