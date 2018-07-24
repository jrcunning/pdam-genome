load("../fastOrtho/counts.RData")

# which are the most diversified gene families in each coral species?
# TEST DIFFS FOR ALL SHARED GENES
corals <- counts[, 1:4]
shared <- corals[apply(corals, 1, min)>0, ]
genestotest <- rownames(shared[apply(shared, 1, function(x) max(x)>=10),])
divp <- c()
for (g in genestotest) {
  adig1 <- sum(corals[g,3])
  adig0 <- sum(corals[-which(rownames(corals) %in% g),3])
  spis1 <- sum(corals[g,2])
  spis0 <- sum(corals[-which(rownames(corals) %in% g),2])
  pdam1 <- sum(corals[g,1])
  pdam0 <- sum(corals[-which(rownames(corals) %in% g),1])
  ofav1 <- sum(corals[g,4])
  ofav0 <- sum(corals[-which(rownames(corals) %in% g),4])
  tab <- matrix(c(adig1, spis1, pdam1, ofav1, adig0, spis0, pdam0, ofav0), nrow=4,
                dimnames=list("Species"=c("Adig", "Spis", "Pdam", "Ofav"),
                              "GeneFam"=c("Member", "NonMember")))
  tab <- as.table(tab)
  set.seed(5234)
  divp[g] <- fisher.test(tab, simulate.p.value=TRUE)$p.value
}
padj <- p.adjust(divp, method = "fdr")
divs <- shared[names(padj[padj < 0.01]), ]

##### of those with differences among corals, do pairwise comparisons
res <- data.frame(matrix(NA, ncol=ncol(divs), nrow=nrow(divs),
                         dimnames=list("Groups"=rownames(divs), "Species"=colnames(divs))))

for (g in rownames(divs)) {
  adig1 <- sum(corals[g,3])
  adig0 <- sum(corals[-which(rownames(corals) %in% g),3])
  spis1 <- sum(corals[g,2])
  spis0 <- sum(corals[-which(rownames(corals) %in% g),2])
  pdam1 <- sum(corals[g,1])
  pdam0 <- sum(corals[-which(rownames(corals) %in% g),1])
  ofav1 <- sum(corals[g,4])
  ofav0 <- sum(corals[-which(rownames(corals) %in% g),4])
  tab <- matrix(c(adig1, spis1, pdam1, ofav1, adig0, spis0, pdam0, ofav0), nrow=4,
                dimnames=list("Species"=c("Adig", "Spis", "Pdam", "Ofav"),
                              "GeneFam"=c("Member", "NonMember")))
  tab <- as.table(tab)
  ptab <- RVAideMemoire::fisher.multcomp(tab, p.method="fdr")
  fullptab <- rcompanion::fullPTable(ptab$p.value)
  ord <- with(data.frame(prop.table(tab, 1))[1:4,], order(Freq, decreasing=T))
  fullptab.ord <- fullptab[ord, ord]
  lett <- multcompView::multcompLetters(fullptab.ord)$Letters
  lett <- lett[order(match(names(lett), colnames(divs)))]
  res[g, ] <- lett
  data.frame(prop.table(tab, 1))[1:4,]
}

# Find cases where only one coral is significantly higher than all the others (with all others being not different)
obvidivs <- divs[apply(res, 1, function(x) (sum(x=="a")==1) & sum(x=="b")==3), ]
obvires <- res[apply(res, 1, function(x) (sum(x=="a")==1) & sum(x=="b")==3), ]
obvires[obvires=="a"] <- 1
obvires[obvires=="b"] <- 0
obvires2 <- sapply(obvires, as.numeric)
rownames(obvires2) <- rownames(obvires)
colSums(obvires2)

# Write results for diversified genefams in each species to text files
adigdiv <- obvidivs[obvires$Adig==1, ]
write.table(adigdiv, file="adig_diversified.txt", quote=F)

spisdiv <- obvidivs[obvires$Spis==1, ]
write.table(spisdiv, file="spis_diversified.txt", quote=F)

ofavdiv <- obvidivs[obvires$Ofav==1, ]
write.table(ofavdiv, file="ofav_diversified.txt", quote=F)

pdamdiv <- obvidivs[obvires$Pdam==1, ]
write.table(pdamdiv, file="pdam_diversified.txt", quote=F)
