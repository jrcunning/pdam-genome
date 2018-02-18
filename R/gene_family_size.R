load("fastOrtho/counts.RData")

cols <- c("skyblue", "mediumorchid", "pink1",  "gray60")
pdam.counts <- hist(counts$Pdam[counts$Pdam>0], breaks=2^(seq(0,8,1)), right=FALSE, plot=F)
spis.counts <- hist(counts$Spis[counts$Spis>0], breaks=2^(seq(0,8,1)), right=FALSE, plot=F)
ofav.counts <- hist(counts$Ofav[counts$Ofav>0], breaks=2^(seq(0,8,1)), right=FALSE, plot=F)
adig.counts <- hist(counts$Adig[counts$Adig>0], breaks=2^(seq(0,8,1)), right=FALSE, plot=F)
logdat <- log10(rbind(pdam.counts$counts, spis.counts$counts,
                      ofav.counts$counts, adig.counts$counts))
logdat[is.infinite(logdat)] <- NA

png(filename="figures/gene_family_size.png", width=3.5, height=2.5, units="in", res=300)
par(mar=c(2,2,1,1), mgp=c(1,0.1,0), tcl=-0.2, cex.axis=0.75)
bars <- barplot(logdat, beside=T, space=c(0,0), axes=F, col=alpha(cols,0.5),
                xlab="Gene family size", ylab="Number of gene families", xpd=NA)
axis(side=1, at=c(0,4,8,12,16,20,24,28,32),
     labels=c(1,2,4,8,16,32,64,128,256))
axis(side=2, at=c(0,1,2,3,4), labels=c(1,10,100,1000,10000), line=-0.4)
legend("topright", pch=22, pt.bg=alpha(cols, 0.5), pt.cex=1.5, bty="n",
       legend=c("Pdam", "Spis", "Ofav", "Adig"))
dev.off()