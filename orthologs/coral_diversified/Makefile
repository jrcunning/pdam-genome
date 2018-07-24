# orthologs/coral_diversified/Makefile

all: cd_longest_sp_blastout

# Get ortholog groups that are diversified in corals from fastOrtho analysis
coral_diversified_groups.txt: ../../R/Diversification.R ../fastOrtho/ortho.table 
	R --vanilla < $< --args ../fastOrtho/ortho.table $@
	
# Get pdam genes that are in the coral-diversified gene families
coral_diversified_pdam_gene_names.txt: coral_diversified_groups.txt
	grep -o "pdam_........" $< > $@
	
# Test for enrichment of GO terms in the pdam genes in coral-diversified gene families using topGO
coral_diversified_enrichment_GO_pvals.txt: coral_diversified_pdam_gene_names.txt
	R --vanilla < ../../R/topGO.R --args ../../annotation/pdam_genes_GO.txt $< coral_diversified_enrichment

# Get rep set - longest protein in each ortho group
cd_longest.fasta: coral_diversified_groups.txt
	# Remove parenthetical species IDs and split into new files: one ortho group per file
	sed "s/([^)]*)//g" coral_diversified_groups.txt | tail -n +2 | split -l 1 -a 1 - cd_
	# For each ortho group, get longest pdam gene
	for ortho in cd_?;
	do
		cat $ortho | cut -f4 | sed -e 's/ /\'$'\n/g' | awk '/pdam/ {print}' > $ortho'_'
		filter_fasta.py -f ../../annotation/pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta \
		-o $ortho'.fasta' -s $ortho'_'
		R --vanilla < ../R/get_longest.R --args $ortho'.fasta' $ortho'_longest.fasta'
	done
	cat cd_?_longest.fasta > cd_longest.fasta
	grep -o -E "^>\w+" cd_longest.fasta | tr -d ">" > longest_gene-names.txt
	while read gene; do group=$(awk '/'$gene'/ {print $1}' coral_diversified_groups.txt); echo "$gene      $group"; done < longest_gene-names.txt > longest_genes-fams.txt

# BLAST longest rep set proteins against SwissProt database
cd_longest_sp_blastout: cd_longest.fasta
	blastp -db /Volumes/CoralReefFutures/ref/swissprot/uniprot_sprot.fasta -query cd_longest.fasta -evalue 1e-10 -max_target_seqs 100 -out cd_longest_sp_blastout -outfmt '6 qaccver saccver pident qlen slen qcovs evalue bitscore stitle'
	# Get top hits for each one
	sort -k1,2 -k7g cd_longest_sp_blastout | sort -k1,2 -u | sort -k7,7g | sort -k1,1 -u > cd_longest_sp_tophits.txt

