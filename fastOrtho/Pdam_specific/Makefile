SHELL := /bin/bash

all: pdam_specific_goterms_counts.txt

pdam_specific_goterms_counts.txt: pdam_specific_gene_names.txt
	# get 'gene' entries from pdam gff3
	tar -xOzf ../../annotation/pdam.all.renamed.function.domain.gff.tar.gz | awk '($$3 == "gene") {print $$0}' > genes.gff
	# filter gene gff by the names of Pdam-specific genes
	awk 'NR==FNR{a[$$1];next} $$2 in a{print $$0}' pdam_specific_gene_names.txt FS="=|;" genes.gff > pdam_specific_genes.gff
	# get and count GO terms
	grep -o "GO:......." pdam_specific_genes.gff | sort | uniq -c | awk '{ print $$2 " " $$1}' > pdam_specific_goterms_counts.txt
	# Clean up
	rm pdam_specific_genes.gff
	rm genes.gff

pdam_specific_gene_names.txt: Pdam_specific_groups.txt Pdam_singletons.txt
	cat Pdam_singletons.txt > pdam_specific_gene_names.txt
	grep -o "pdam_........" Pdam_specific_groups.txt >> pdam_specific_gene_names.txt

Pdam_singletons.txt:
	comm -13 <(grep -o "pdam_........" ../ortho.table | sort) <(grep -o "pdam_........" ../../pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta | sort) > Pdam_singletons.txt
        
Pdam_specific_groups.txt:
	R --vanilla < ../../R/Diversification.R --args Pdam_specific_groups.txt
