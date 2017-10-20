SHELL := /bin/bash

all: coral_diversified_pdam_gene_names.txt coral_diversified_rep_set.fasta

coral_diversified_rep_set.fasta: CoralDiversified_groups.txt
	pcregrep -o1 "(pdam_........-RA).*" $< > names.txt
	filter_fasta.py -f ../../pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta \
	-o coral_diversified_rep_set.fasta \
	-s names.txt
	rm names.txt

coral_diversified_pdam_gene_names.txt: CoralDiversified_groups.txt
	grep -o "pdam_........" CoralDiversified_groups.txt > $@

CoralDiversified_groups.txt: ../ortho.table ../../R/Diversification.R
	R --vanilla < ../../R/Diversification.R --args $@
