all: coral_specific_pdam_gene_names.txt

coral_specific_pdam_gene_names.txt: Coral_specific_groups.txt
	grep -o "pdam_........" $< > $@

Coral_specific_groups.txt: ../ortho.table ../../R/Diversification.R
	R --vanilla < ../../R/Diversification.R --args Coral_specific_groups.txt
