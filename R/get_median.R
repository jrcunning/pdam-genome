library(Biostrings)

args = commandArgs(trailingOnly=TRUE)

infile <- args[1]
outfile <- args[2]

seqs <- readAAStringSet(infile)
whichmedian <- function(x) which.min(abs(x - median(x)))
median <- seqs[whichmedian(width(seqs))]

writeXStringSet(median, filepath=outfile, format="fasta")


