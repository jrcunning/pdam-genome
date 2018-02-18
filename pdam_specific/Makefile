SHELL := /bin/bash

all: pdam_specific_enriched_revigo.png

# Get pdam-specific ortholog groups from fastOrtho analysis
Pdam_specific_groups.txt: ../R/Diversification.R ../fastOrtho/ortho.table 
	R --vanilla < $< --args ../fastOrtho/ortho.table Pdam_specific_groups.txt
	
# Get pdam singletons (no orthologs in other genomes from fastOrtho)
Pdam_singletons.txt: ../fastOrtho/ortho.table
	comm -13 <(grep -o "pdam_........" ../fastOrtho/ortho.table | sort) <(grep -o "pdam_........" ../pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta | sort) > Pdam_singletons.txt

# Combine pdam singletons and genes in pdam-specific ortholog groups: all pdam-specific genes
pdam_specific_gene_names.txt: Pdam_specific_groups.txt Pdam_singletons.txt
	cat Pdam_singletons.txt > pdam_specific_gene_names.txt
	grep -o "pdam_........" Pdam_specific_groups.txt >> pdam_specific_gene_names.txt

# Test for enrichment of GO terms in pdam-specific gene set using topGO
pdam_specific_enrichment_GO_pvals.txt: pdam_specific_gene_names.txt
	R --vanilla < ../R/topGO.R --args ../annotation/pdam_genes_GO.txt $< pdam_specific_enrichment
	cp pdam_specific_enrichment_data.csv ../output/Supplementary_Data_S4.csv

# Use GO enrichment data in REVIGO analysis
pdam_specific_enriched_revigo.csv: pdam_specific_enrichment_GO_pvals.txt
	/anaconda/bin/python ../python/scrape_revigo.py 0.70 yes $< $@
	sed -i '' 's/, / /g' pdam_specific_enrichment_data.csv
	
# Visualize REVIGO output
pdam_specific_enriched_revigo.png: pdam_specific_enriched_revigo.csv
	R --vanilla < ../R/plot_revigo_pvals.R --args $< pdam_specific_enrichment_data.csv $@
	
