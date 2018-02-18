library(tidyverse)

domains <- read.table("coral_diversified/cd_med_Pfam.txt", sep="\t", fill=T, row.names=NULL, 
                      header=F, stringsAsFactors=T, 
                      col.names=c("protein", "md5", "protein.length", "Pfam", 
                       "signature.acc", "signature.descr", "start", "stop", "score", "status",
                       "rundate", "interpro.acc", "interpro.descr", "GO"))
ndom <- nlevels(domains$signature.acc)

prots <- split(domains, f=domains$protein)

# get dimensions for plotting
nprot <- length(prots)
longest <- max(domains$protein.length)

draw.prot <- function(prot, y=1) with(prot, {
  length <- protein.length[1]
  segments(0, y, length, y)
  rect(start, y-0.3, stop, y+0.3, col=rainbow(ndom)[signature.acc])
  #text(prot$start+(prot$stop-prot$start)/2, y+0.1, labels=signature.descr, srt=45)
})

plot(NA, xlim=c(0, longest), ylim=c(1, nprot), axes=F, xlab="", ylab="")

y=1
for (prot in prots) {
  draw.prot(prot, y=y)
  y=y+1
}
