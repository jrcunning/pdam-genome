library(stringr)
library(tidyverse)

args = commandArgs(trailingOnly=TRUE)

dat <- read.delim("../ortho.table",header=F,sep="\t")
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

###Groupings
coral <- 1:4
morph <- 5:6
anem <- 7:8
hyd <- 9
out <- 10:11
cnid <- c(coral,morph,anem,hyd)


coralMin <- apply(counts[,coral],1,min)
length(which(coralMin>0)) #7962 found in all corals (core coral genome)
anemMin <- apply(counts[,anem],1,min)
cnidMin <- apply(counts[,cnid],1,min)
length(which(cnidMin>0)) #found in all cnidarians 2367
noncorMax <- apply(counts[,-c(coral)],1,max)
nonanemMax <- apply(counts[,-anem],1,max)
length(which(coralMin>0 & noncorMax==0)) #in corals only 370
length(which(anemMin>0 & nonanemMax==0)) #in anemones only 495

noncorcnidMax <- apply(counts[,c(morph,anem,hyd)],1,max)
length(which(coralMin>0 & noncorcnidMax==0)) #387
nonanemcnidMax <- apply(counts[,c(morph,coral,hyd)],1,max)
length(which(anemMin>0 & nonanemcnidMax==0)) #535

coralMax <- apply(counts[,coral],1,max)
noncorcnidMin <- apply(counts[,c(morph,anem,hyd)],1,min)
length(which(coralMax==0 & noncorcnidMin>0)) #Lost in corals 1

anemMax <- apply(counts[,anem],1,max)
nonanemcnidMin <- apply(counts[,c(morph,coral,hyd)],1,min)
length(which(anemMax==0 & nonanemcnidMin>0)) #Lost in anemones 5

coreCoral <- counts[coralMin>0,]
coralOnly <- counts[coralMin>0 & noncorMax==0,]

###Species-specific genes
k=1
pdam <- counts[,k]
nonpdam <- apply(counts[,-k],1,max)
length(which(pdam>0 & nonpdam==0)) #560 in pdam only
pdamOnly <- dat[which(pdam>0 & nonpdam==0),]

if (args[1]=="Pdam_specific.txt") write.table(pdamOnly,"Pdam_specific.txt",quote=F,row.names=F,col.names=T,sep="\t")
coralOnly <- dat[which(coralMin>0 & noncorMax==0),]
if (args[1]=="Coral_specific.txt") write.table(coralOnly, "Coral_specific.txt",quote=F,row.names=F,col.names=T,sep="\t")

# Spis-specific
spis <- counts[,2]
nonspis <- apply(counts[,-2],1,max)
length(which(spis>0 & nonspis==0))
spisOnly <- dat[which(spis>0 & nonspis==0),]
if (args[1]=="Spis_specific.txt") write.table(spisOnly, "Spis_specific.txt",quote=F,row.names=F,col.names=T,sep="\t")

# Ofav-specific
ofav <- counts[,4]
nonofav <- apply(counts[,-4],1,max)
length(which(ofav>0 & nonofav==0))
ofavOnly <- dat[which(ofav>0 & nonofav==0),]
if (args[1]=="Ofav_specific.txt") write.table(ofavOnly, "Ofav_specific.txt",quote=F,row.names=F,col.names=T,sep="\t")

# Adig-specific
adig <- counts[,3]
nonadig <- apply(counts[,-3],1,max)
length(which(adig>0 & nonadig==0))
adigOnly <- dat[which(adig>0 & nonadig==0),]
if (args[1]=="Adig_specific.txt") write.table(adigOnly, "Adig_specific.txt",quote=F,row.names=F,col.names=T,sep="\t")

###Diversification in corals
anth <- apply(counts[,c(coral,morph,anem)],1,min)
pgens <- counts[which(anth>0),]
divp <- c()
for (i in 1:nrow(pgens)) {
#	print(i)
	g1 <- sum(pgens[i,1:3])
	g2 <- sum(pgens[i,4:7])
	n1 <- sum(pgens[-i,1:3])
	n2 <- sum(pgens[-i,4:7])
	divp[i] <- fisher.test(cbind(c(g1,g2),c(n1,n2)))$p.value
}
divadj <- p.adjust(divp,method="fdr")
dir <- apply(pgens,1,function(x) mean(x[1:3])-mean(x[4:7]))
divs <- pgens[divadj<0.01 & dir>0,]
pdivGens <- dat[dat$Group%in%rownames(divs),]
if (args[1]=="CoralDiversified.txt") write.table(pdivGens,"CoralDiversified.txt",quote=F,row.names=F,col.names=T,sep="\t")

