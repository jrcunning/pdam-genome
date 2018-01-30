all: coral_diversified_enriched_revigo.png coral_diversified_rep_set.fasta

# Get ortholog groups that are diversified in corals from fastOrtho analysis
coral_diversified_groups.txt: ../R/Diversification.R ../fastOrtho/ortho.table 
	R --vanilla < $< --args ../fastOrtho/ortho.table $@
	
# Get pdam genes that are in the coral-diversified gene families
coral_diversified_pdam_gene_names.txt: coral_diversified_groups.txt
	grep -o "pdam_........" $< > $@
	
# Test for enrichment of GO terms in the pdam genes in coral-diversified gene families using topGO
coral_diversified_enrichment_GO_pvals.txt: coral_diversified_pdam_gene_names.txt
	R --vanilla < ../R/topGO.R --args ../annotation/pdam_genes_GO.txt $< coral_diversified_enrichment

# Use GO enrichment data in REVIGO analysis
coral_diversified_enriched_revigo.csv: coral_diversified_enrichment_GO_pvals.txt
	/anaconda/bin/python ../python/scrape_revigo.py 0.70 yes $< $@
	sed -i '' 's/, / /g' coral_diversified_enrichment_data.csv
	
# Visualize REVIGO output
coral_diversified_enriched_revigo.png: coral_diversified_enriched_revigo.csv
	R --vanilla < ../R/plot_revigo_pvals.R --args $< coral_diversified_enrichment_data.csv $@
	
# Get protein sequences of pdam genes in coral-diversified gene families
coral_diversified_rep_set.fasta: coral_diversified_groups.txt
	pcregrep -o1 "(pdam_........-RA).*" $< > names.txt
	filter_fasta.py -f ../pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta \
	-o coral_diversified_rep_set.fasta \
	-s names.txt
	# Match each gene name to ortho group/family
	while read gene; do group=$(awk '/'$gene'/ {print $1}' coral_diversified_groups.txt); echo "$gene      $group"; done < names.txt > genes-fams.txt

# Get rep set - longest protein in each ortho group
cd_longest.fasta: coral_diversified_groups.txt
	# Remove parenthetical species IDs and split into new files: one ortho group per file
	sed "s/([^)]*)//g" coral_diversified_groups.txt | tail -n +2 | split -l 1 -a 1 - cd_
	# For each ortho group, get name of longest pdam gene
	for ortho in cd_?
	do
		cat $ortho | cut -f4 | sed -e 's/ /\'$'\n/g' | awk '/pdam/ {print}' > $ortho'_'
		grep -f $ortho'_' ../pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta > $ortho'__'
		sort -t'|' -k9,9nr $ortho'__' | head -1 >> cd_longest.txt
		rm $ortho
		rm $ortho'_'
		rm $ortho'__'
	done
	# Get protein sequences for these representative genes
	sed -i '' 's/>//' cd_longest.txt
	filter_fasta.py -f ../pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta -o cd_longest.fasta -s cd_longest.txt
	# Match each gene name to ortho group/family
	cut -d' ' -f1 cd_longest.txt > gene-names.txt
	while read gene; do group=$(awk '/'$gene'/ {print $1}' coral_diversified_groups.txt); echo "$gene      $group"; done < gene-names.txt > genes-fams.txt

# BLAST rep set proteins against nr database
#cd_nr_tophits.txt: coral_diversified_rep_set.fasta
#	# Split into one sequences per file
#	split -l 2 coral_diversified_rep_set.fasta
#	# Blast each sequence separately to remote nr database
#	for filename in xa?; do
#		blastp -db nr -remote -query $filename -evalue 1e-6 -max_target_seqs 100 -out $filename'_blastout' -outfmt '6 qaccver saccver pident qlen slen qcovs evalue bitscore stitle'
#	done
#	# Get top ten hits for each one -- excluding "uncharacterized" or "hypothetical" hits
#	for filename in xa*blastout; do
#		sort -k2,2 -k7g $filename | sort -k2,2 -u | sort -k7,7g | grep -v "uncharacterized" | grep -v "Uncharacterized" | grep -v "hypothetical" | grep -v "PREDICTED" | head -10 > $filename'topten.txt'
#	done
#	# Combine results and get top hit for each sequence
#	cat xa*topten.txt > cd_nr_topten.txt
#	sort -k1,1 -u cd_nr_topten.txt > cd_nr_tophits.txt
	
# BLAST rep set proteins against SwissProt database
cd_longest_sp_blastout: coral_diversified_rep_set.fasta
	blastp -db /Volumes/CoralReefFutures/ref/swissprot/uniprot_sprot.fasta -query cd_longest.fasta -evalue 1e-10 -max_target_seqs 100 -out cd_longest_sp_blastout -outfmt '6 qaccver saccver pident qlen slen qcovs evalue bitscore stitle'
	# Get top hits for each one
	sort -k1,2 -k7g cd_longest_sp_blastout | sort -k1,2 -u | sort -k7,7g | sort -k1,1 -u > cd_longest_sp_tophits.txt
	
	