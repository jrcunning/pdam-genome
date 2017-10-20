all: pdam_specific_enrichment coral_specific_enrichment coral_diversified_enrichment 

coral_diversified_enrichment: all_pdam_genes.txt ../fastOrtho/CoralDiversified/coral_diversified_pdam_gene_names.txt
	R --vanilla < ../R/topGO.R --args $^ $@

coral_specific_enrichment: all_pdam_genes.txt ../fastOrtho/Coral_specific/coral_specific_pdam_gene_names.txt
	R --vanilla < ../R/topGO.R --args $^ $@

pdam_specific_enrichment: all_pdam_genes.txt ../fastOrtho/Pdam_specific/pdam_specific_gene_names.txt
	R --vanilla < ../R/topGO.R --args $^ $@

all_pdam_genes.txt: ../annotation/genes.gff
	sed -n 's/.*ID=\([^;]*\).*Ontology_term=\(.*\)/\1\t\2/p' $< | sed 's/,/, /g' | sed 's/;//g' > $@

../annotation/genes.gff:
	tar -xOzf ../annotation/pdam.all.renamed.function.domain.gff.tar.gz | awk '($$3 == "gene") {print $$0}' > $@
