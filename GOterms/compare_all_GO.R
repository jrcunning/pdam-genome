spis <- read.delim("GOterms/spis_ips_GO.txt", header=F, stringsAsFactors=F)
adig <- read.delim("GOterms/adig_ips_GO.txt", header=F, stringsAsFactors=F)
pdam <- read.delim("GOterms/all_pdam_genes.txt", header=F, stringsAsFactors=F)
ofav <- read.delim("GOterms/ofav_ips_GO.txt", header=F, stringsAsFactors=F)

spisGO <- unlist(strsplit(spis$V2, split=", "))
pdamGO <- unlist(strsplit(adig$V2, split=", "))

sharedGO <- intersect(spisGO, pdamGO)


enrichGO <- function(x, y) {
  xGO <- unlist(strsplit(get(x)$V2, split=", "))
  yGO <- unlist(strsplit(get(y)$V2, split=", "))
  sharedGO <- intersect(xGO, yGO)
  pvals <- NA
  for (i in 1:length(sharedGO)) {
    GO <- sharedGO[i]
    prop.pdam <- table(!grepl(GO, pdam$V2))
    prop.spis <- table(!grepl(GO, spis$V2))
    pvals[i] <- prop.test(rbind(prop.pdam, prop.spis),
                          alternative="greater")$p.value
  }
  return(list(sharedGO=sharedGO, pvals=pvals))
}

pdam.vs.spis <- enrichGO("pdam", "spis")
sig1 <- with(pdam.vs.spis, sharedGO[pvals < 0.00000000001])

pdam.vs.ofav <- enrichGO("pdam", "ofav")
sig2 <- with(pdam.vs.ofav, sharedGO[pvals < 0.00000000001])

pdam.vs.adig <- enrichGO("pdam", "adig")
sig3 <- with(pdam.vs.adig, sharedGO[pvals < 0.00000000001])

pdam.vs.all <- intersect(intersect(sig1, sig2), sig3)
write.table(pdam.vs.all, file="GOterms/pdam.vs.all.txt", col.names=F, row.names=F, quote=F)


table(grepl("GO:0006810", spis$V2))
table(grepl("GO:0006810", pdam$V2))

spis.vs.ofav <- enrichGO("spis", "ofav")
sig <- with(spis.vs.ofav, sharedGO[pvals < 0.00000000001])


