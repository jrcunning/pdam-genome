library(tidyverse)

# Get command line arguments
args = commandArgs(trailingOnly=TRUE)

window <- 100000

# import a text file with gene positions
# columns should be: chr, position (no end or gene name required)
genes <- read.table(args[1])
colnames(genes) <- c("scaffold", "loc")
genes <- genes[order(genes$scaffold, genes$loc), ]

# scaffold lengths
scafs <- read.table(args[2])
colnames(scafs) <- c("scaffold", "length")
scafs100k <- scafs[scafs$length > window, ]

# subset genes from >100k scafs
geneset <- droplevels(merge(scafs100k, genes))

dd <- plyr::ldply(split(geneset, f=list(geneset$scaffold)), function(scaf) {
  scaf$int <- with(scaf, cut(loc, breaks=seq(0, plyr::round_any(max(length), window), window)))
  scaf %>% group_by(int) %>% summarise_each(funs(count=n()), loc)
})

png(paste(args[3], "hist.png", sep="."), width=3, height=3, units="in", res=300)
hist(dd$count, xlim=c(0,30))
dev.off()

save(dd, file=paste(args[3], "genedens.RData", sep="."))
