all: coral_diversified_pdam_gene_names.txt

coral_diversified_pdam_gene_names.txt: CoralDiversified_groups.txt
	grep -o "pdam_........" CoralDiversified_groups.txt > $@

CoralDiversified_groups.txt: ../ortho.table ../../R/Diversification.R
	R --vanilla < ../../R/Diversification.R --args CoralDiversified_groups.txt
