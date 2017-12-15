all: adig_diversified_ips.tsv spis_diversified_ips.tsv ofav_diversified_ips.tsv

adig_diversified.txt: ../R/species_diversification.R
	R --vanilla < $<

spis_diversified.txt: ../R/species_diversification.R
	R --vanilla < $<

ofav_diversified.txt: ../R/species_diversification.R
	R --vanilla < $<

adig_diversified_rep_set.fasta: adig_diversified.txt
	tail -n +2 adig_diversified.txt | cut -f1 -d' ' > adig_diversified_orthos.txt
	grep -wf adig_diversified_orthos.txt ../fastOrtho/ortho.table > adig_diversified_orthos2.txt
	pcregrep -o1 "(aug_v2a.......t1).*" adig_diversified_orthos2.txt > adig_diversified_rep_set.txt
	filter_fasta.py -f ../data/ref/AcroporaDigitifera.pep \
	-o adig_diversified_rep_set.fasta \
	-s adig_diversified_rep_set.txt
	rm adig_diversified_orthos.txt adig_diversified_orthos2.txt adig_diversified_rep_set.txt
	
spis_diversified_rep_set.fasta: spis_diversified.txt
	tail -n +2 spis_diversified.txt | cut -f1 -d' ' > spis_diversified_orthos.txt
	grep -wf spis_diversified_orthos.txt ../fastOrtho/ortho.table > spis_diversified_orthos2.txt
	pcregrep -o1 "(Spis[0-9]+).*" spis_diversified_orthos2.txt > spis_diversified_rep_set.txt
	filter_fasta.py -f ../data/ref/StylophoraPistillata.pep \
	-o spis_diversified_rep_set.fasta \
	-s spis_diversified_rep_set.txt
	rm spis_diversified_orthos.txt spis_diversified_orthos2.txt spis_diversified_rep_set.txt
	
ofav_diversified_rep_set.fasta: ofav_diversified.txt
	tail -n +2 ofav_diversified.txt | cut -f1 -d' ' > ofav_diversified_orthos.txt
	grep -wf ofav_diversified_orthos.txt ../fastOrtho/ortho.table > ofav_diversified_orthos2.txt
	pcregrep -o1 "(ofav_[^\(]+).*" ofav_diversified_orthos2.txt > ofav_diversified_rep_set.txt
	filter_fasta.py -f ../data/ref/OrbicellaFaveolata.pep \
	-o ofav_diversified_rep_set.fasta \
	-s ofav_diversified_rep_set.txt
	rm ofav_diversified_orthos.txt ofav_diversified_orthos2.txt ofav_diversified_rep_set.txt
	
adig_diversified_ips.tsv: adig_diversified_rep_set.fasta
# Remove asterisks (A digitifera has asterisks in protein seqs for stop codons)
	sed -i 's/\*//g' adig_diversified_rep_set.fasta
	interproscan.sh -i $< -b adig_diversified_ips --goterms

spis_diversified_ips.tsv: spis_diversified_rep_set.fasta
# Remove asterisks (A digitifera has asterisks in protein seqs for stop codons)
	sed -i 's/\*//g' spis_diversified_rep_set.fasta
	interproscan.sh -i $< -b spis_diversified_ips --goterms

ofav_diversified_ips.tsv: ofav_diversified_rep_set.fasta
# Remove asterisks (A digitifera has asterisks in protein seqs for stop codons)
	sed -i 's/\*//g' ofav_diversified_rep_set.fasta
	interproscan.sh -i $< -b ofav_diversified_ips --goterms
