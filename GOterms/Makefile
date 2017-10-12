all: pdam_specific_enrichment

pdam_specific_enrichment: all_pdam_genes.txt pdam_specific_gene_names.txt
	R --vanilla < ../R/topGO.R --args $^ $@

pdam_specific_gene_names.txt: ../fastOrtho/Pdam_specific/pdam_gene_names.txt
	cp $< $@

all_pdam_genes.txt: ../annotation/genes.gff
	sed -n 's/.*ID=\([^;]*\).*Ontology_term=\(.*\)/\1\t\2/p' ../annotation/genes.gff | sed 's/,/, /g' | sed 's/;//g' > all_pdam_genes.txt
