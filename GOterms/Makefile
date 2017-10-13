all: pdam_specific_enrichment coral_specific_enrichment coral_diversified_enrichment

coral_diversified_enrichment: all_pdam_genes.txt coral_diversified_gene_names.txt
	R --vanilla < ../R/topGO.R --args $^ $@

coral_diversified_gene_names.txt: ../fastOrtho/CoralDiversified/CoralDiversified.txt
	grep -o pdam_[0-9]* $< > $@

coral_specific_enrichment: all_pdam_genes.txt coral_specific_gene_names.txt
	R --vanilla < ../R/topGO.R --args $^ $@

coral_specific_gene_names.txt: ../fastOrtho/Coral_specific/Coral_specific.txt
	grep -o pdam_[0-9]* $< > $@

pdam_specific_enrichment: all_pdam_genes.txt pdam_specific_gene_names.txt
	R --vanilla < ../R/topGO.R --args $^ $@

pdam_specific_gene_names.txt: ../fastOrtho/Pdam_specific/pdam_gene_names.txt
	cp $< $@

all_pdam_genes.txt: ../annotation/genes.gff
	sed -n 's/.*ID=\([^;]*\).*Ontology_term=\(.*\)/\1\t\2/p' $< | sed 's/,/, /g' | sed 's/;//g' > $@

../annotation/genes.gff:
	tar -xOzf ../annotation/pdam.all.renamed.function.domain.gff.tar.gz | awk '($$3 == "gene") {print $$0}' > $@
