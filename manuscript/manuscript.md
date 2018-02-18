---
title: The genome of *Pocillopora damicornis* and comparative genomics of scleractinian corals
author:
  - name: Ross Cunning
    email: ross.cunning@gmail.com
    affiliation: RSMAS
    footnote: Corresponding Author
  - name: Rachael A. Bay
    affiliation: UCLA
  - name: Andrew C. Baker
    affiliation: RSMAS
  - name: Nikki Traylor-Knowles
    affiliation: RSMAS
address:
  - code: RSMAS
    address: Department of Marine Biology and Ecology, Rosenstiel School of Marine and Atmospheric Science, University of Miami, Miami, FL 33149, USA
  - code: UCLA
    address: Institute for the Environment and Sustainability, University of California, Los Angeles, Los Angeles, CA 90095, USA
abstract: |
  Abstract text here.
bibliography: library.bib
output: pdf_document
---


# Abstract


# Introduction

  Scleractinian corals serve the critical ecological role of building reefs that provide billions of dollars annually in goods and services [@Costanza2014] and sustain high levels of biodiversity [@Knowlton2010]. Moreover, as basal metazoans, corals provide a model for studying the evolution of key traits such as symbiosis [@Neubauer2016a], immunity [@Quistad2014], and biomineralization [@Takeuchi2016]. However, corals are declining rapidly due to ocean acidification, which impairs coral skeleton formation [@Kleypas1999], and ocean warming, which disrupts their symbiosis with photosynthetic *Symbiodinium* spp. [@Jokiel_1977]. Understanding the genomic architecture of these traits and their responses to climate change is therefore key to understanding corals' success through evolutionary history [@Bhattacharya2016] and in future climate scenarios. In particular, there is great interest in whether corals possess the genetic basis and genetic variation required to acclimatize and/or adapt to rapid climate change [@van_Oppen_2015; @Dixon2015; @Bay2017]. Addressing these questions requires expanding genomic resources for corals, and establishes a fundamental role for comparative genomic analysis in these organisms.

  Genomic resources for corals have expanded rapidly in recent years, with genomic or transcriptomic information available for at least 20 coral species (see @Bhattacharya2016). Comparative analysis of these data has identified genes that may be important in biomineralization, symbiosis, and environmental stress responses [@Bhattacharya2016]. However, complete genome sequences have only been analyzed and compared for two coral species, *Acropora digitifera* and *Stylophora pistillata* [@Voolstra2017], which revealed extensive differences in genomic architecture and content. Therefore, additional complete coral genomes and more comprehensive comparative analysis may be transformative in our understanding of the genomic content and evolutionary history of reef-building corals. 
  
  Here, we present the genome of *Pocillopora damicornis*, one of the most abundant and widespread reef-building corals in the Indo-Pacific. This ecologically important coral is the subject of a large body of research on speciation [@Pinzon2013; @Schmidt-Roach2014; @Johnston2017], population genetics [@Stoddart1984; @Pinzon2011; @Combosch2011; @Thomas2017], symbiosis ecology [@Glynn:2001p7571; @McGinley_2012; @Cunning_2013], and reproduction [@Stoddart1983; @Ward1992; @Schmidt-Roach2012], and is commonly used in experimental biology and physiology. Therefore, availability of the *P. damicornis* genome will advance a number of fields in coral biology, ecology, and evolution, and provides a direct foundation for future studies in transcriptomics, population genomics, and functional genomics. 
  
  Using this genome and other publicly available genomes of corals, Cnidarians, and basal metazoans, we provide the most comprehensive comparative genomic analysis to date in Scleractinia. In particular, we address critical questions such as: 1) what constitutes the 'core genome' common to all corals, 2) what genes are specific to or diversified within corals, and 3) what genes are specific to or diversified within individual coral species, providing insight into the evolution of Scleractinia.

# Materials and Methods

## *P. damicornis* genome sequencing and assembly
  The *P. damicornis* genotype used for sequencing was collected at Isla de Saboga, Panama in March 2005, and cultured indoors at the University of Miami Coral Resource Facility until the time of sampling. Genomic DNA was extracted from two fragments of this genotype in XXX 2016 using XXX protocol. DNA was delivered to Dovetail Genomics (Santa Cruz, CA, USA), where Chicago libraries were prepared and sequenced on an Illumina XXX platform, and genome scaffolds were assembled *de novo* using the HiRise software pipeline [@Putnam2016a]. The Dovetail HiRise scaffolds were then filtered to remove those of potential non-coral origin using BLAST [@Altschul1990] searches against three databases: 1) *Symbiodinium*, containing the genomes of *S. minutum* [@Shoguchi2013] and *S. microadriaticum* [@Aranda2016], 2) bacteria, containing 6954 complete bacterial genomes from NCBI, and 3) viruses, containing 2996 viral genomes from the phantome database (phantome.org; accessed 2017-03-01). Scaffolds with a BLAST hit to any of these databases with an e-value < 10^-20^ and a bitscore > 1000 were considered to be non-coral in origin and removed from the assembly [@Baumgarten2015].

## *P. damicornis* genome annotation
  The filtered assembly was analyzed for completeness using BUSCO [@Simao2015] to search for 978 universal metazoan single-copy orthologs. The `--long` option was passed to BUSCO in order to train the *ab initio* gene prediction software Augustus [@Stanke2004]. Augustus gene prediction parameters were then used in the MAKER pipeline [@Campbell2014] to annotate gene models, using as supporting evidence two RNA-seq datasets from *P. damicornis* [Mayfield?; Traylor-Knowles/Bhattacharya?] and one from closely-related *Stylophora pistillata* [@Voolstra2017], and protein sequences from 20 coral species [@Bhattacharya2016]. Results from this initial MAKER run were used to train a second gene predictor (SNAP [@Korf2004]) prior to an iterative MAKER run to refine gene models. Predicted protein sequences were then extracted from the assembly and putative functional annotations were added by searching for homologous proteins in the Uniprot-Swissprot database [@TheUniProtConsortium2017] using BLAST (E<10^-5^), and protein domains using InterProScan [@Finn2017]. Genome annotation summary statistics were generated using the Genome Annotation Generator software [@Hall2014].

## Comparative genomic analyses
  We identified ortholog groups (gene families) among the predicted proteins of four scleractinians, two corallimorpharians, two anemones, one hydrozoan, one sponge, and one ctenophore (Table 1) using the software fastOrtho (http://enews.patricbrc.org/fastortho/) based on the MCL algorithm with a blastp E-value cutoff of 10^-5^. Based on these orthologous gene families, we defined and extracted several gene sets of interest: 1) gene families that were shared by all four corals (i.e., coral 'core' genes), 2) genes that were present in all four corals but absent from other organisms (i.e., coral-specific genes), 3) gene families that were significantly larger in corals relative to other anthozoans (Binomial generalized linear model, FDR-adjusted *p*<0.01; i.e., coral-diversified genes), 4) gene families that were significantly larger in a single coral species relative to all other corals (pairwise comparisons using Fisher's exact test, FDR-adjusted *p*<0.01; i.e., coral species-specific gene family expansions), and 5) genes present in *P. damicornis* with no orthologs in any other genome (i.e., *P. damicornis*-specific genes).

## Functional characterization
  Putative gene functionality was characterized using Gene Ontology (GO) analysis. GO terms were assigned to predicted *P. damicornis* protein sequences using InterProScan [@Jones2014a]. Significantly enriched GO terms in gene sets of interest relative to the whole genome were identified using the R package topGO [@Alexa2016], and significantly enriched GO terms were clustered and visualized using REVIGO [@Supek2011]. These analyses were implemented using custom scripts in R, Python, and Unix shell, which are available in the accompanying data repository (github.com/jrcunning/pdam-genome).

# Results and discussion


```
## Error in .Call2("new_input_filexp", filepath, PACKAGE = "XVector"): cannot open file 'data/filter/pdam.fasta'
```

```
## Error in eval(expr, envir, enclos): object 'pdam' not found
```

```
## Error in width(pdam): object 'pdam' not found
```

```
## Error in .Call2("new_input_filexp", filepath, PACKAGE = "XVector"): cannot open file 'data/filter/contigs.fasta'
```

```
## Error in eval(expr, envir, enclos): object 'pdam.contigs' not found
```

```
## Error in width(pdam.contigs): object 'pdam.contigs' not found
```

```
## Error in width(pdam.contigs): object 'pdam.contigs' not found
```

```
## Error in file(con, "r"): cannot open the connection
```

```
## Error in gs[1, 2]/10^6: non-numeric argument to binary operator
```

```
## Error in gs[13, 2]/10^6: non-numeric argument to binary operator
```

```
## Error in gs[13, 2]/gs[1, 2]: non-numeric argument to binary operator
```

```
## Error in gs[17, 2]/gs[1, 2]: non-numeric argument to binary operator
```

```
## Error in file(file, "rt"): cannot open the connection
```

```
## Error in file(file, "rt"): cannot open the connection
```

```
## Error in eval(expr, envir, enclos): object 'busco' not found
```

```
## Error in eval(expr, envir, enclos): object 'busco' not found
```

```
## Error in eval(expr, envir, enclos): object 'busco' not found
```

```
## Error in eval(expr, envir, enclos): object 'busco' not found
```

```
## Error in n.blastp.hits/n.genes: non-numeric argument to binary operator
```

```
## Error in n.ips.hits/n.genes: non-numeric argument to binary operator
```



