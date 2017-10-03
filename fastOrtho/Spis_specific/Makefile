all: Spis_specific_goterms_counts.txt

Spis_specific_goterms_counts.txt: Spis_specific_ips.gff3
	grep -o "GO:......." Spis_specific_ips.gff3 > Spis_specific_goterms.txt
	cat Spis_specific_goterms.txt | sort | uniq -c | awk '{ print $$2 " " $$1}' > Spis_specific_goterms_counts.txt


Spis_specific_ips.gff3: Spis_specific_all.fasta
	interproscan.sh -i $< -b Spis_specific_ips --goterms


Spis_specific_all.fasta: Spis_specific.txt
	# Remove existing fasta files (will be rewritten here)
	rm -f *.fasta && rm -f ORTHOMCL* \
	# Write each Spis-specific gene family to ORTHOMCL* file with list of member genes
	tail -n +2 Spis_specific.txt | awk '{f=$$1; $$1=$$2=$$3=""; sub("   ", ""); gsub("\\([^\\)]+\\)", ""); ; gsub(" ", "\n"); print > f}'
        
	# Get all sequences in all families
	# Combine lists of genes in all ortholog groups
	cat ORTHOMCL* > ORTHOMCL_cat
	filter_fasta.py \
	-f ../../data/ref/StylophoraPistillata.pep \
	-o Spis_specific_all.fasta \
	-s ORTHOMCL_cat

	# Remove asterisks (A digitifera has asterisks in protein seqs for stop codons)
	sed -i 's/\*//g' Spis_specific_all.fasta
        
Spis_specific.txt: ../ortho.table ../../R/Diversification.R
	R --vanilla < ../../R/Diversification.R --args Spis_specific.txt
