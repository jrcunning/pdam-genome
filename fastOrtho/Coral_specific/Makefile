
coral_specific_goterms_counts.txt: coral_specific_ips.gff3
	grep -o "GO:......." coral_specific_ips.gff3 > coral_specific_goterms.txt
	cat coral_specific_goterms.txt | sort | uniq -c | awk '{ print $$2 " " $$1}' > coral_specific_goterms_counts.txt


coral_specific_ips.gff3: Coral_specific_all.fasta
	interproscan.sh -i $< -b coral_specific_ips --goterms


Coral_specific_all.fasta: Coral_specific.txt
	# Remove existing fasta files (will be rewritten here)
	rm -f *.fasta && rm -f Coral_specific_rep_set.txt && rm ORTHOMCL* \
	# Write each coral-specific gene family to ORTHOMCL* file with list of member genes
	tail -n +2 Coral_specific.txt | awk '{f=$$1; $$1=$$2=$$3=""; sub("   ", ""); gsub("\\([^\\)]+\\)", ""); ; gsub(" ", "\n"); print > f}'
        
	# Combine protein sequences from all genomes into all.pep
	cd ../../data/ref && cat AcroporaDigitifera.pep AiptasiaPallida.pep AmphimedonQueenslandica.pep AmplexidiscusFenestrafer.pep DiscosomaSp.pep HydraVulgaris.pep MnemiopsisLeidyi.pep NematostellaVectensis.pep OrbicellaFaveolata.pep PocilloporaDamicornis.pep > all.pep

	# Get the first sequence in each family as a representative set
	for ORTHO in ORTHOMCL* ; \
	do \
	head -1 $$ORTHO >> Coral_specific_rep_set.txt ; \
	done
	filter_fasta.py -f ../../data/ref/all.pep -o Coral_specific_rep_set.fasta -s Coral_specific_rep_set.txt

	# Get all sequences in all families
	# Combine lists of genes in all ortholog groups
	cat ORTHOMCL* > ORTHOMCL_cat
	filter_fasta.py \
	-f ../../data/ref/all.pep \
	-o Coral_specific_all.fasta \
	-s ORTHOMCL_cat
	
	# Remove asterisks (A digitifera has asterisks in protein seqs for stop codons)
	sed -i "" 's/\*//g' Coral_specific_all.fasta
