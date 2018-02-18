all: coral_specific_enriched_revigo.png

# Get genes associated with the significant GO term signal transduction
coral_specific_signal_transduction_genes.fasta: coral_specific_enrichment
	awk '/Term GO:0007165 genes:/ {print $$5}' coral_specific_enrichment | sed -e 's/,/-RA\'$$'\n/g' | sed 's/"/-RA/' > signal_transduction_gene_names.txt
	filter_fasta.py -f ../pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta -o coral_specific_signal_transduction_genes.fasta -s signal_transduction_gene_names.txt
	cp coral_specific_signal_transduction_genes.fasta ../output/Supplementary_Data_S2.fasta

# Get coral-specific ortholog groups from fastOrtho analysis
Coral_specific_groups.txt: ../R/Diversification.R ../fastOrtho/ortho.table
	R --vanilla < $< --args ../fastOrtho/ortho.table $@

# Get the pdam genes in the coral-specific ortholog groups
coral_specific_pdam_gene_names.txt: Coral_specific_groups.txt
	grep -o "pdam_........" $< > $@
	
# Test for enrichment of GO terms in the pdam genes in coral-specific gene families using topGO
coral_specific_enrichment_GO_pvals.txt: coral_specific_pdam_gene_names.txt
	R --vanilla < ../R/topGO.R --args ../annotation/pdam_genes_GO.txt $< coral_specific_enrichment

# Use GO enrichment data in REVIGO analysis
coral_specific_enriched_revigo.csv: coral_specific_enrichment_GO_pvals.txt
	/anaconda/bin/python ../python/scrape_revigo.py 0.70 yes $< $@
	sed -i '' 's/, / /g' coral_specific_enrichment_data.csv
	
# Visualize REVIGO output
coral_specific_enriched_revigo.png: coral_specific_enriched_revigo.csv
	R --vanilla < ../R/plot_revigo_pvals.R --args $< coral_specific_enrichment_data.csv $@