SHELL := /bin/bash

all: pdam_specific_gene_names.txt

pdam_specific_gene_names.txt: Pdam_specific_groups.txt Pdam_singletons.txt
	cat Pdam_singletons.txt > pdam_specific_gene_names.txt
	grep -o "pdam_........" Pdam_specific_groups.txt >> pdam_specific_gene_names.txt

Pdam_singletons.txt:
	comm -13 <(grep -o "pdam_........" ../ortho.table | sort) <(grep -o "pdam_........" ../../pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta | sort) > Pdam_singletons.txt
        
Pdam_specific_groups.txt:
	R --vanilla < ../../R/Diversification.R --args Pdam_specific_groups.txt
