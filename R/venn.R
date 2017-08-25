# Venn diagram of the three corals
library(VennDiagram)
corals <- counts[,1:3]
corals <- corals[rowSums(corals) > 0, ]

# Calculate each intersection
#Pdam <- with(corals, nrow(corals[Pdam >0 & Adig==0 & Ofav==0, ]))
#Adig <- with(corals, nrow(corals[Pdam==0 & Adig >0 & Ofav==0, ]))
#Ofav <- with(corals, nrow(corals[Pdam==0 & Adig==0 & Ofav >0, ]))
#PdamAdig <- with(corals, nrow(corals[Pdam >0 & Adig >0 & Ofav==0, ]))
#PdamOfav <- with(corals, nrow(corals[Pdam >0 & Adig==0 & Ofav >0, ]))
#AdigOfav <- with(corals, nrow(corals[Pdam==0 & Adig >0 & Ofav >0, ]))
#all3 <- with(corals, nrow(corals[Pdam >0 & Adig >0 & Ofav >0, ]))

Pdam <- with(corals, nrow(corals[Pdam >0, ]))
Adig <- with(corals, nrow(corals[Adig >0, ]))
Ofav <- with(corals, nrow(corals[Ofav >0, ]))
PdamAdig <- with(corals, nrow(corals[Pdam >0 & Adig >0, ]))
AdigOfav <- with(corals, nrow(corals[Ofav >0 & Adig >0, ]))
PdamOfav <- with(corals, nrow(corals[Pdam >0 & Ofav >0, ]))
all3 <- with(corals, nrow(corals[Pdam >0 & Adig >0 & Ofav >0, ]))

draw.triple.venn(category = c("Pdam", "Adig", "Ofav"),
                 area1 = Pdam, area2 = Adig, area3 = Ofav, 
                 n12 = PdamAdig, 
                 n23 = AdigOfav, 
                 n13 = PdamOfav, 
                 n123 = all3,
                 lty = "blank", 
                 fill = c("skyblue", "pink1", "mediumorchid"))



# Quadruple with aiptasia
Pdam <- with(counts, nrow(counts[Pdam >0, ]))
Adig <- with(counts, nrow(counts[Adig >0, ]))
Ofav <- with(counts, nrow(counts[Ofav >0, ]))
Aipt <- with(counts, nrow(counts[Aipt >0, ]))
PdamAdig <- with(counts, nrow(counts[Pdam >0 & Adig >0, ]))
PdamAipt <- with(counts, nrow(counts[Pdam >0 & Aipt >0, ]))
AdigOfav <- with(counts, nrow(counts[Ofav >0 & Adig >0, ]))
PdamOfav <- with(counts, nrow(counts[Pdam >0 & Ofav >0, ]))
AdigAipt <- with(counts, nrow(counts[Aipt >0 & Adig >0, ]))
OfavAipt <- with(counts, nrow(counts[Ofav >0 & Aipt >0, ]))
PdamAdigOfav <- with(counts, nrow(counts[Pdam >0 & Adig >0 & Ofav >0, ]))
PdamAdigAipt <- with(counts, nrow(counts[Pdam >0 & Adig >0 & Aipt >0, ]))
PdamOfavAipt <- with(counts, nrow(counts[Pdam >0 & Aipt >0 & Ofav >0, ]))
AdigOfavAipt <- with(counts, nrow(counts[Aipt >0 & Adig >0 & Ofav >0, ]))
all4 <- with(counts, nrow(counts[Pdam >0 & Adig >0 & Ofav >0 & Aipt >0, ]))

draw.quad.venn(category = c("Pdam", "Adig", "Ofav", "Aipt"),
               area1 = Pdam, area2 = Adig, area3 = Ofav, area4=Aipt,
               n12 = PdamAdig, 
               n13 = PdamOfav, 
               n14 = PdamAipt,
               n23 = AdigOfav, 
               n24 = AdigAipt,
               n34 = OfavAipt,
               n123 = PdamAdigOfav,
               n124 = PdamAdigAipt,
               n134 = PdamOfavAipt,
               n234 = AdigOfavAipt,
               n1234 = all4,
               lty = "blank", 
               fill = c("skyblue", "pink1", "mediumorchid", "gray80"))




#
nfam <- function(spp) {
  out <- counts
  for (sp in spp) {
    out <- out[out[, sp] > 0, ]
  }
  nrow(out)
}

nfam(c("Pdam", "Ofav"))

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

plotGeneFams(c("Pdam", "Aipt"), category=c("Pdam", "Aipt"))
plotGeneFams(c("Pdam", "Ofav"), category=c("Pdam", "Ofav"))
plotGeneFams(c("Disc", "Ampl"), category=c("Disc", "Ampl"))
