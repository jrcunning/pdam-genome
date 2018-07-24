# orthologs/species_diversified/Makefile

all: ofavd_longest.txt adigd_longest.txt spisd_longest.txt species_specific_expansions_tophits.txt

adig_diversified.txt: ../../R/species_diversification.R
	R --vanilla < $<

spis_diversified.txt: ../../R/species_diversification.R
	R --vanilla < $<

ofav_diversified.txt: ../../R/species_diversification.R
	R --vanilla < $<

adigd_longest.txt: adig_diversified.txt
	tail -n +2 adig_diversified.txt | cut -f1 -d' ' > adig_diversified_orthos.txt
	grep -wf adig_diversified_orthos.txt ../fastOrtho/ortho.table > adig_diversified_orthos2.txt
	# Remove parenthetical species IDs and split into new files: one ortho group per file
	sed "s/([^)]*)//g" adig_diversified_orthos2.txt | split -l 1 -a 1 - adigd_
	# For each ortho group, get name of longest pdam gene
	for ortho in adigd_?
	do
		cat $ortho | cut -f4 | sed -e 's/ /\'$'\n/g' | awk '/aug_v2a/ {print}' > $ortho'_'
		filter_fasta.py -f ../../data/ref/AcroporaDigitifera.pep -o $ortho'.fasta' -s $ortho'_'
		R --vanilla < ../../R/get_longest.R --args $ortho'.fasta' $ortho'_longest.fasta'
	done
	cat adigd_?_longest.fasta > adigd_longest.fasta
	rm adigd_?_* adigd_?.fasta adigd_?
	# Blast to SwissProt
	blastp -db /Users/jrcunning/Projects/acerv-gwas/annotations/swissprot/uniprot_sprot.fasta -query adigd_longest.fasta -evalue 1e-10 -max_target_seqs 100 -out adigd_longest_sp_blastout -outfmt '6 qaccver saccver pident qlen slen qcovs evalue bitscore stitle'
	# Get top hits for each one
	sort -k1,2 -k7g adigd_longest_sp_blastout | sort -k1,2 -u | sort -k7,7g | sort -k1,1 -u > adigd_longest_sp_tophits.txt
	
spisd_longest.txt: spis_diversified.txt
	tail -n +2 spis_diversified.txt | cut -f1 -d' ' > spis_diversified_orthos.txt
	grep -wf spis_diversified_orthos.txt ../fastOrtho/ortho.table > spis_diversified_orthos2.txt
	# Remove parenthetical species IDs and split into new files: one ortho group per file
	sed "s/([^)]*)//g" spis_diversified_orthos2.txt | split -l 1 -a 1 - spisd_
	# For each ortho group, get name of longest pdam gene
	for ortho in spisd_?
	do
		cat $ortho | cut -f4 | sed -e 's/ /\'$'\n/g' | awk '/Spis/ {print}' > $ortho'_'
		filter_fasta.py -f ../../data/ref/StylophoraPistillata.pep -o $ortho'.fasta' -s $ortho'_'
		R --vanilla < ../../R/get_longest.R --args $ortho'.fasta' $ortho'_longest.fasta'
	done
	cat spisd_?_longest.fasta > spisd_longest.fasta
	rm spisd_?_* spisd_?.fasta spisd_?
	# Blast to SwissProt
	blastp -db /Users/jrcunning/Projects/acerv-gwas/annotations/swissprot/uniprot_sprot.fasta -query spisd_longest.fasta -evalue 1e-10 -max_target_seqs 100 -out spisd_longest_sp_blastout -outfmt '6 qaccver saccver pident qlen slen qcovs evalue bitscore stitle'
	# Get top hits for each one
	sort -k1,2 -k7g spisd_longest_sp_blastout | sort -k1,2 -u | sort -k7,7g | sort -k1,1 -u > spisd_longest_sp_tophits.txt
	
	
ofavd_longest.txt: ofav_diversified.txt
	tail -n +2 ofav_diversified.txt | cut -f1 -d' ' > ofav_diversified_orthos.txt
	grep -wf ofav_diversified_orthos.txt ../fastOrtho/ortho.table > ofav_diversified_orthos2.txt
	# Remove parenthetical species IDs and split into new files: one ortho group per file
	sed "s/([^)]*)//g" ofav_diversified_orthos2.txt | split -l 1 -a 1 - ofavd_
	# For each ortho group, get name of longest pdam gene
	for ortho in ofavd_?
	do
		cat $ortho | cut -f4 | sed -e 's/ /\'$'\n/g' | awk '/ofav/ {print}' > $ortho'_'
		filter_fasta.py -f ../../data/ref/OrbicellaFaveolata.pep -o $ortho'.fasta' -s $ortho'_'
		R --vanilla < ../../R/get_longest.R --args $ortho'.fasta' $ortho'_longest.fasta'
	done
	cat ofavd_?_longest.fasta > ofavd_longest.fasta
	rm ofavd_?_* ofavd_?.fasta ofavd_?
	# Blast to SwissProt
	blastp -db /Volumes/CoralReefFutures/ref/swissprot/uniprot_sprot.fasta -query ofavd_longest.fasta -evalue 1e-10 -max_target_seqs 100 -out ofavd_longest_sp_blastout -outfmt '6 qaccver saccver pident qlen slen qcovs evalue bitscore stitle'
	# Get top hits for each one
	sort -k1,2 -k7g ofavd_longest_sp_blastout | sort -k1,2 -u | sort -k7,7g | sort -k1,1 -u > ofavd_longest_sp_tophits.txt
	
species_specific_expansions_tophits.txt: ofavd_longest_sp_tophits.txt spisd_longest_sp_tophits.txt adigd_longest_sp_tophits.txt
	cat $^ > species_specific_expansions_tophits.txt
	
	

# Match each gene name to ortho group/family
sd_longest_genes-fams.txt: adigd_longest.fasta
	cat *_longest.fasta > sd_longest.fasta
	cat *_orthos2.txt > sd_orthos.txt
	grep -o -E "^>[^\ ]+" sd_longest.fasta | tr -d ">" > sd_longest_gene-names.txt
	while read gene; do group=$(awk '/'$gene'/ {print $1}' sd_orthos.txt); echo "$gene      $group"; done < sd_longest_gene-names.txt > sd_longest_genes-fams.txt

