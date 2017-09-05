all: coral_diversified_goterms_counts.txt

coral_diversified_goterms_counts.txt: coral_diversified_ips.gff3
	grep -o "GO:......." coral_diversified_ips.gff3 > coral_diversified_goterms.txt
	cat coral_diversified_goterms.txt | sort | uniq -c | awk '{ print $$2 " " $$1}' > coral_diversified_goterms_counts.txt

coral_diversified_ips.gff3: CoralDiversified_all.fasta
	interproscan.sh -i $< -b coral_diversified_ips --goterms


CoralDiversified_all.fasta: CoralDiversified.txt
	rm -f *.fasta && rm -f ORTHOMCL*
	tail -n +2 CoralDiversified.txt | awk '{f=$$1; $$1=$$2=$$3=""; sub("   ", ""); gsub("\\([^\\)]+\\)", ""); ; gsub(" ", "\n"); print > f}'
	cd ../../data/ref && cat AcroporaDigitifera.pep AiptasiaPallida.pep AmphimedonQueenslandica.pep AmplexidiscusFenestrafer.pep DiscosomaSp.pep HydraVulgaris.pep MnemiopsisLeidyi.pep NematostellaVectensis.pep OrbicellaFaveolata.pep PocilloporaDamicornis.pep > all.pep
	rm -f CoralDiversified_rep_set.txt

	# Get representative set (1 per family)
	for ORTHO in ORTHOMCL* ; \
	do \
	head -1 $$ORTHO >> CoralDiversified_rep_set.txt ; \
	done
	filter_fasta.py -f ../../data/ref/all.pep -o CoralDiversified_rep_set.fasta -s CoralDiversified_rep_set.txt

	cat ORTHOMCL* > ORTHOMCL_cat
	filter_fasta.py \
	-f ../../data/ref/all.pep \
	-o CoralDiversified_all.fasta \
	-s ORTHOMCL_cat ; \

	# Remove asterisks (A digitifera has asterisks in protein seqs for stop codons)
	sed -i 's/\*//g' CoralDiversified_all.fasta

CoralDiversified.txt: ../ortho.table ../../R/Diversification.R
	R --vanilla < ../../R/Diversification.R --args CoralDiversified.txt
