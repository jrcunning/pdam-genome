all: coral_core_enriched_revigo.png

# Get coral-core ortholog groups from fastOrtho analysis
coral_core_groups.txt: ../R/Diversification.R ../fastOrtho/ortho.table
	R --vanilla < $< --args ../fastOrtho/ortho.table $@

# Get the pdam genes in the coral-core ortholog groups
coral_core_pdam_gene_names.txt: coral_core_groups.txt
	grep -o "pdam_........" $< > $@
	
# Test for enrichment of GO terms in the pdam genes in coral-specific gene families using topGO
coral_core_enrichment_GO_pvals.txt: coral_core_pdam_gene_names.txt
	R --vanilla < ../R/topGO.R --args ../annotation/pdam_genes_GO.txt $< coral_core_enrichment

# Use GO enrichment data in REVIGO analysis
coral_core_enriched_revigo.csv: coral_core_enrichment_GO_pvals.txt
	/anaconda/bin/python ../python/scrape_revigo.py 0.70 yes $< $@
	
# Visualize REVIGO output
coral_core_enriched_revigo.png: coral_core_enriched_revigo.csv
	R --vanilla < ../R/plot_revigo_pvals.R --args $< coral_core_enrichment_data.csv $@