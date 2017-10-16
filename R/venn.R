library(stringr)
library(tidyverse)

args = commandArgs(trailingOnly=TRUE)

dat <- read.delim("fastOrtho/ortho.table",header=F,sep="\t")
colnames(dat) <- c("Group", "Genes", "Taxa", "IDs")
dat5 <- filter(dat, Taxa>=1)
dim(dat5) #23380

counts <- data.frame(matrix(nrow=nrow(dat5),ncol=11))
rownames(counts) <- dat5$Group
colnames(counts) <- c("Pdam","Spis","Adig","Ofav","Ampl","Disc","Aipt","Nema","Hydr","Mnem","Amph")

counts$Pdam <- apply(dat5,1,function(x) str_count(x[4],"Pocillopora"))
counts$Spis <- apply(dat5,1,function(x) str_count(x[4],"Stylophora"))
counts$Adig <- apply(dat5,1,function(x) str_count(x[4],"Acropora"))
counts$Ofav <- apply(dat5,1,function(x) str_count(x[4],"Orbicella"))
counts$Ampl <- apply(dat5,1,function(x) str_count(x[4],"Amplexidiscus"))
counts$Disc <- apply(dat5,1,function(x) str_count(x[4],"Discosoma"))
counts$Aipt <- apply(dat5,1,function(x) str_count(x[4],"Aiptasia"))
counts$Nema <- apply(dat5,1,function(x) str_count(x[4],"Nematostella"))
counts$Hydr <- apply(dat5,1,function(x) str_count(x[4],"Hydra"))
counts$Mnem <- apply(dat5,1,function(x) str_count(x[4],"Mnemiopsis"))
counts$Amph <- apply(dat5,1,function(x) str_count(x[4],"Amphimedon"))


# Venn diagram of the three corals
library(VennDiagram)
corals <- counts[,1:4]
corals <- corals[rowSums(corals) > 0, ]

# Function to get total number of ortholog groups in a species (or shared by a group of species)
nfam <- function(spp) {
  out <- counts
  for (sp in spp) {
    out <- out[out[, sp] > 0, ]
  }
  nrow(out)
}

nfam(c("Pdam"))
nfam(c("Pdam", "Ofav"))
nfam(c("Pdam", "Adig"))
nfam(c("Pdam", "Spis"))
nfam(c("Pdam", "Ofav", "Adig"))

# Function to plot venn diagram of ortholog groups across n species
plotGeneFams <- function(a, ...) {
  grid.newpage()
  if (length(a) == 1) {
    out <- draw.single.venn(nfam(a), ...)
  }
  if (length(a) == 2) {
    out <- draw.pairwise.venn(nfam(a[1]), nfam(a[2]), nfam(a[1:2]), ...)
  }
  if (length(a) == 3) {
    out <- draw.triple.venn(nfam(a[1]), nfam(a[2]), nfam(a[3]), nfam(a[1:2]), 
                            nfam(a[2:3]), nfam(a[c(1, 3)]), nfam(a), ...)
  }
  if (length(a) == 4) {
    out <- draw.quad.venn(nfam(a[1]), nfam(a[2]), nfam(a[3]), nfam(a[4]), 
                          nfam(a[1:2]), nfam(a[c(1, 3)]), nfam(a[c(1, 4)]), nfam(a[2:3]), 
                          nfam(a[c(2, 4)]), nfam(a[3:4]), nfam(a[1:3]), nfam(a[c(1, 2, 4)]), 
                          nfam(a[c(1, 3, 4)]), nfam(a[2:4]), nfam(a), ...)
  }
  if (!exists("out")) 
    out <- "Oops"
  return(out)
}

plotGeneFams(c("Pdam", "Adig", "Ofav"), category = c("Pdam", "Adig", "Ofav"), 
             lty = "blank", fill = c("skyblue", "pink1", "mediumorchid"))

plotGeneFams(c("Pdam", "Aipt"), category=c("Pdam", "Aipt"), lty="blank", fill = c("skyblue", "pink1"))
plotGeneFams(c("Pdam", "Ofav"), category=c("Pdam", "Ofav"), lty="blank", fill = c("skyblue", "pink1"))
plotGeneFams(c("Disc", "Ampl"), category=c("Disc", "Ampl"), lty="blank", fill = c("skyblue", "pink1"))

png("figures/coral_venn.png", width=4, height=3, units="in", res=300)
plotGeneFams(c("Pdam", "Ofav", "Spis", "Adig"), category=c("Pdam", "Ofav", "Spis", "Adig"), 
             lty="blank", fill=c("skyblue", "pink1", "mediumorchid", "gray60"))
dev.off()

counts$Scleractinia <- apply(counts[, 1:4], 1, function(x) as.numeric(any(x==0)==FALSE))
counts$Corallimorpharia <- apply(counts[, 5:6], 1, function(x) as.numeric(any(x==0)==FALSE))
counts$Actinaria <- apply(counts[, 7:8], 1, function(x) as.numeric(any(x==0)==FALSE))
counts$Anthomedusae <- sapply(counts[, 9], function(x) as.numeric(any(x==0)==FALSE))
counts$allBasal <- apply(counts[, 10:11], 1, function(x) as.numeric(any(x==0)==FALSE))

png("figures/cni_venn.png", width=4, height=3, units="in", res=300)
plotGeneFams(c("Scleractinia", "Corallimorpharia", "Actinaria", "Anthomedusae"), 
             category=c("Scleractinia", "Corallimorpharia", "Actinaria", "Anthomedusae"),
             lty="blank", fill=c("skyblue", "pink1", "mediumorchid", "gray60"))
dev.off()

png("figures/antho_venn.png", width=4, height=3, units="in", res=300)
plotGeneFams(c("Scleractinia", "Corallimorpharia", "Actinaria"), 
             category=c("Scleractinia", "Corallimorpharia", "Actinaria"),
             lty="blank", fill=c("skyblue", "pink1", "mediumorchid"))
dev.off()



genedist <- function(a, b) {
  1 - (nfam(c(a, b)) / (nfam(a) + nfam(b)))
}

genedist("Pdam", "Spis")
genedist("Pdam", "Adig")
genedist("Pdam", "Ofav")

l <- t(combn(c("Pdam", "Spis", "Adig", "Ofav"), 2))
gd <- apply(l, 1, function(p) genedist(p[1], p[2]))
df <- data.frame(cbind(l, gd))
dm <- reshape(df, direction="wide", idvar="V2", timevar="V1")
dm <- cbind(rbind(rep(NA, 4), dm), rep(NA, 4))
dm <- dm[,-1]
rownames(dm) <- c("Pdam", "Spis", "Adig", "Ofav")
colnames(dm) <- c("Pdam", "Spis", "Adig", "Ofav")
dm

plot(hclust(as.dist(dm)))


l <- t(combn(c("Scleractinia", "Corallimorpharia", "Actinaria", "Anthomedusae"), 2))
gd <- apply(l, 1, function(p) genedist(p[1], p[2]))
df <- data.frame(cbind(l, gd))
dm <- reshape(df, direction="wide", idvar="V2", timevar="V1")
dm <- cbind(rbind(rep(NA, 4), dm), rep(NA, 4))
dm <- dm[,-1]
rownames(dm) <- c("Scleractinia", "Corallimorpharia", "Actinaria", "Anthomedusae")
colnames(dm) <- c("Scleractinia", "Corallimorpharia", "Actinaria", "Anthomedusae")
dm

plot(hclust(as.dist(dm)))

