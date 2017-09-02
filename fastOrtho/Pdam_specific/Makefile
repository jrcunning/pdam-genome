all: pdam_goterms_counts.txt

pdam_goterms_counts.txt: Pdam_specific_all.fasta
	# get names of Pdam-specific genes from fasta file
	grep -o "pdam_[0-9]*" Pdam_specific_all.fasta > pdam_gene_names.txt
	# get 'gene' entries from gff3
	tar -xOzf ../../annotation/pdam.all.renamed.function.domain.gff.tar.gz | awk '($$3 == "gene") {print $$0}' > genes.gff
	# filter gene gff by the names of Pdam-specific genes
	grep -f pdam_gene_names.txt genes.gff > pdam_genes.gff
	rm genes.gff
	# get GO terms
	grep -o "GO:......." pdam_genes.gff > pdam_goterms.txt
	# Get counts of unique goterms
	cat pdam_goterms.txt | sort | uniq -c | awk '{ print $$2 " " $$1}' > pdam_goterms_counts.txt

Pdam_specific_all.fasta: Pdam_specific.txt
	# Get 4th field of each line, write to file named by 1st field, convert each to one protein name per line
	rm -f *.fasta && rm -f Pdam_specific_rep_set.txt && rm -f ORTHOMCL*
	tail -n +2 Pdam_specific.txt | awk '{f=$$1; $$1=$$2=$$3=""; sub("   ", ""); gsub(" ", "\n"); gsub(".PocilloporaDamicornis.", ""); print > f}'
	# Get representative set (1 per family)
	for ORTHO in ORTHOMCL* ; \
	do \
	head -1 $$ORTHO >> Pdam_specific_rep_set.txt ; \
	done
	filter_fasta.py -f ../../pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta -o Pdam_specific_rep_set.fasta -s Pdam_specific_rep_set.txt
	# Get all pdam-specific sequences in fasta
	cat ORTHOMCL* > ORTHOMCL_cat
	filter_fasta.py \
	-f ../../pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta \
	-o Pdam_specific_all.fasta \
	-s ORTHOMCL_cat ; \
        
Pdam_specific.txt:
	R --vanilla < ../../R/Diversification.R --args Pdam_specific.txt
