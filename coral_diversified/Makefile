all: coral_diversified_enriched_revigo.png coral_diversified_rep_set.fasta

# Get ortholog groups that are diversified in corals from fastOrtho analysis
coral_diversified_groups.txt: ../R/Diversification.R ../fastOrtho/ortho.table 
	R --vanilla < $< --args ../fastOrtho/ortho.table $@
	
# Get pdam genes that are in the coral-diversified gene families
coral_diversified_pdam_gene_names.txt: coral_diversified_groups.txt
	grep -o "pdam_........" $< > $@
	
# Test for enrichment of GO terms in the pdam genes in coral-diversified gene families using topGO
coral_diversified_enrichment_GO_pvals.txt: coral_diversified_pdam_gene_names.txt
	R --vanilla < ../R/topGO.R --args ../annotation/pdam_genes_GO.txt $< coral_diversified_enrichment

# Use GO enrichment data in REVIGO analysis
coral_diversified_enriched_revigo.csv: coral_diversified_enrichment_GO_pvals.txt
	/anaconda/bin/python ../python/scrape_revigo.py 0.70 yes $< $@
	
# Visualize REVIGO output
coral_diversified_enriched_revigo.png: coral_diversified_enriched_revigo.csv
	R --vanilla < ../R/plot_revigo_pvals.R --args $< coral_diversified_enrichment_data.csv $@
	
# Get protein sequences of pdam genes in coral-diversified gene families
coral_diversified_rep_set.fasta: coral_diversified_groups.txt
	pcregrep -o1 "(pdam_........-RA).*" $< > names.txt
	filter_fasta.py -f ../pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta \
	-o coral_diversified_rep_set.fasta \
	-s names.txt
	rm names.txt



