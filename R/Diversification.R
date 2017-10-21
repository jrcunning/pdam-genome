library(stringr)
library(tidyverse)

args = commandArgs(trailingOnly=TRUE)

dat <- read.delim(args[1],header=F,sep="\t")
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

# Count singletons -- not included in ortho.table
nPdam <- as.numeric(system('grep -c ">" ../data/ref/PocilloporaDamicornis.pep', intern=T))
nSpis <- as.numeric(system('grep -c ">" ../data/ref/StylophoraPistillata.pep', intern=T))
nAdig <- as.numeric(system('grep -c ">" ../data/ref/AcroporaDigitifera.pep', intern=T))
nOfav <- as.numeric(system('grep -c ">" ../data/ref/OrbicellaFaveolata.pep', intern=T))
nAmpl <- as.numeric(system('grep -c ">" ../data/ref/AmplexidiscusFenestrafer.pep', intern=T))
nDisc <- as.numeric(system('grep -c ">" ../data/ref/DiscosomaSp.pep', intern=T))
nAipt <- as.numeric(system('grep -c ">" ../data/ref/AiptasiaPallida.pep', intern=T))
nNema <- as.numeric(system('grep -c ">" ../data/ref/NematostellaVectensis.pep', intern=T))
nHydr <- as.numeric(system('grep -c ">" ../data/ref/HydraVulgaris.pep', intern=T))
nMnem <- as.numeric(system('grep -c ">" ../data/ref/MnemiopsisLeidyi.pep', intern=T))
nAmph <- as.numeric(system('grep -c ">" ../data/ref/AmphimedonQueenslandica.pep', intern=T))

singles <- vector()
singles["Pdam"] <- nPdam - sum(counts$Pdam)
singles["Spis"] <- nSpis - sum(counts$Spis)
singles["Adig"] <- nAdig - sum(counts$Adig)
singles["Ofav"] <- nOfav - sum(counts$Ofav)
singles["Ampl"] <- nAmpl - sum(counts$Ampl)
singles["Disc"] <- nDisc - sum(counts$Disc)
singles["Aipt"] <- nAipt - sum(counts$Aipt)
singles["Nema"] <- nNema - sum(counts$Nema)
singles["Hydr"] <- nHydr - sum(counts$Hydr)
singles["Mnem"] <- nMnem - sum(counts$Mnem)
singles["Amph"] <- nAmph - sum(counts$Amph)
nsingles <- sum(singles)

z <- rep(0, 11)
Pdamsingles <- matrix(rep(replace(z, 1, 1), singles["Pdam"]), byrow=T, ncol=11)
Spissingles <- matrix(rep(replace(z, 2, 1), singles["Spis"]), byrow=T, ncol=11)
Adigsingles <- matrix(rep(replace(z, 3, 1), singles["Adig"]), byrow=T, ncol=11)
Ofavsingles <- matrix(rep(replace(z, 4, 1), singles["Ofav"]), byrow=T, ncol=11)
Amplsingles <- matrix(rep(replace(z, 5, 1), singles["Ampl"]), byrow=T, ncol=11)
Discsingles <- matrix(rep(replace(z, 6, 1), singles["Disc"]), byrow=T, ncol=11)
Aiptsingles <- matrix(rep(replace(z, 7, 1), singles["Aipt"]), byrow=T, ncol=11)
Nemasingles <- matrix(rep(replace(z, 8, 1), singles["Nema"]), byrow=T, ncol=11)
Hydrsingles <- matrix(rep(replace(z, 9, 1), singles["Hydr"]), byrow=T, ncol=11)
Mnemsingles <- matrix(rep(replace(z, 10, 1), singles["Mnem"]), byrow=T, ncol=11)
Amphsingles <- matrix(rep(replace(z, 11, 1), singles["Amph"]), byrow=T, ncol=11)


allsingles <- rbind(Pdamsingles, Spissingles, Adigsingles, Ofavsingles,
                    Amplsingles, Discsingles, Aiptsingles, Nemasingles, Hydrsingles,
                    Mnemsingles, Amphsingles)
colnames(allsingles) <- names(counts)

counts <- rbind(counts, allsingles)


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
pdamOnly <- na.omit(dat[which(pdam>0 & nonpdam==0),])

if (args[2]=="Pdam_specific_groups.txt") write.table(pdamOnly,"Pdam_specific_groups.txt",quote=F,row.names=F,col.names=T,sep="\t")
coralOnly <- dat[which(coralMin>0 & noncorMax==0),]
if (args[2]=="Coral_specific_groups.txt") write.table(coralOnly, "Coral_specific_groups.txt",quote=F,row.names=F,col.names=T,sep="\t")

# Spis-specific
spis <- counts[,2]
nonspis <- apply(counts[,-2],1,max)
length(which(spis>0 & nonspis==0))
spisOnly <- dat[which(spis>0 & nonspis==0),]
if (args[2]=="Spis_specific.txt") write.table(spisOnly, "Spis_specific.txt",quote=F,row.names=F,col.names=T,sep="\t")

# Ofav-specific
ofav <- counts[,4]
nonofav <- apply(counts[,-4],1,max)
length(which(ofav>0 & nonofav==0))
ofavOnly <- dat[which(ofav>0 & nonofav==0),]
if (args[2]=="Ofav_specific.txt") write.table(ofavOnly, "Ofav_specific.txt",quote=F,row.names=F,col.names=T,sep="\t")

# Adig-specific
adig <- counts[,3]
nonadig <- apply(counts[,-3],1,max)
length(which(adig>0 & nonadig==0))
adigOnly <- dat[which(adig>0 & nonadig==0),]
if (args[2]=="Adig_specific.txt") write.table(adigOnly, "Adig_specific.txt",quote=F,row.names=F,col.names=T,sep="\t")

###Diversification in corals
if (args[2]=="coral_diversified_groups.txt") {
  minanth <- apply(counts[,c(coral,morph,anem)],1,min)
  sumcor <- apply(counts[,coral],1,sum)
  pgens <- counts[which(minanth>0 & sumcor>20),] # genes to test
  divp <- c()
  for (g in rownames(pgens)) {
    g1 <- sum(counts[g,1:4]) # total copies of the gene in corals
    g2 <- sum(counts[g,5:8]) # total copies of the gene in non-coral anthozoans
    n1 <- sum(counts[-which(rownames(counts) %in% g),1:4]) # total copies of OTHER genes in corals
    n2 <- sum(counts[-which(rownames(counts) %in% g),5:8]) # total copies of OTHER genes in non-coral anthozoans
    divp[g] <- fisher.test(cbind(c(g1,g2),c(n1,n2)),
                           alternative="greater")$p.value
  }
  divadj <- p.adjust(divp,method="fdr")
  #dir <- apply(pgens,1,function(x) mean(x[1:4])-mean(x[5:8]))
  divs <- pgens[divadj<0.01,]
  divs
  pdivGens <- dat[dat$Group%in%rownames(divs),]
  write.table(pdivGens,"coral_diversified_groups.txt",quote=F,row.names=F,col.names=T,sep="\t")
}

