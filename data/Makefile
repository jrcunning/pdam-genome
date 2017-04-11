all: filter/pdam.fasta


# Remove "alien" scaffolds to generate putative coral assembly: "pdam.fasta"
filter/pdam.fasta: filter/blast_results/alien_IDs.txt
	seqkit grep --invert-match --pattern-file filter/blast_results/alien_IDs.txt filter/allseqs.fasta > filter/pdam0.fasta
	# Remove size annotations from coral assembly (interferes with downstream processing)
	sed -e 's/\[[^][]*\]//g' filter/pdam0.fasta > filter/pdam.fasta
	rm filter/pdam0.fasta

# Combine significant hits to bacteria, viruses, and Symbiodinium as "aliens"
filter/blast_results/alien_IDs.txt: filter/blast_results/*_filtered.txt
	gawk '($$11 < 1e-20) && ($$12 > 1000)' filter/blast_results/sym_blast_results_filtered.txt  > filter/blast_results/aliens.txt
	gawk '($$11 < 1e-20) && ($$12 > 1000)' filter/blast_results/bac_blast_results_filtered.txt >> filter/blast_results/aliens.txt
	gawk '($$11 < 1e-20) && ($$12 > 1000)' filter/blast_results/vir_blast_results_filtered.txt >> filter/blast_results/aliens.txt
	cut -f1 filter/blast_results/aliens.txt > filter/blast_results/alien_IDs.txt

# Filter and sort Symbiodinium BLAST output
filter/blast_results/sym_blast_results_filtered.txt: filter/blast_results/sym_blast_results.txt
	sort -u -k1,1 $< > filter/blast_results/sym_blast_results_filtered.txt

# BLAST scaffolds against Symbiodinium database
filter/blast_results/sym_blast_results.txt: filter/allseqs.fasta ref/sym_blastdb.nal
	blastn -query $< -db ref/sym_blastdb -outfmt 6 -max_target_seqs 1 -num_threads 15 -evalue 1e-5 > filter/blast_results/sym_blast_results.txt

# Filter and sort bacterial BLAST output
filter/blast_results/bac_blast_results_filtered.txt: filter/blast_results/bac_blast_results.txt
	sort -u -k1,1 $< > filter/blast_results/bac_blast_results_filtered.txt

# Filter and sort viral BLAST output
filter/blast_results/vir_blast_results_filtered.txt: filter/blast_results/vir_blast_results.txt
	sort -u -k1,1 $< > filter/blast_results/vir_blast_results_filtered.txt

# BLAST scaffolds against bacterial database
filter/blast_results/bac_blast_results.txt: filter/allseqs.fasta ref/bacteria/bac_blastdb.nal
	blastn -query $< -db ref/bacteria/bac_blastdb -outfmt 6 -max_target_seqs 1 -num_threads 15 -evalue 1e-5 > filter/blast_results/bac_blast_results.txt

# BLAST scaffolds against viral database
filter/blast_results/vir_blast_results.txt: filter/allseqs.fasta ref/viruses/vir_blastdb.nsq
	blastn -query $< -db ref/viruses/vir_blastdb -outfmt 6 -max_target_seqs 1 -num_threads 15 -evalue 1e-5 > filter/blast_results/vir_blast_results.txt

# Make viral BLAST database
ref/viruses/vir_blastdb.nsq: ref/viruses/phantome_db.fasta
	makeblastdb -dbtype nucl -in $< -out ref/viruses/vir_blastdb

# Download viral genomes
ref/viruses/phantome_db.fasta:
	cd ref/viruses && make
	cd ..

# Make bacteria BLAST database
ref/bacteria/bac_blastdb.nal: ref/bacteria/all_complete_Gb_bac.fasta
	makeblastdb -dbtype nucl -in $< -out ref/bacteria/bac_blastdb

# Download complete bacterial genomes
all_complete_Gb_bac.fasta: 
	cd ref/bacteria && make
	cd ..

# Make Cnidarian BLAST database
ref/cni_blastdb.nal: ref/PocilloporaDamicornis_transcriptome.fa ref/adi_v1.0.scaffold.fa ref/Spis.genome.scaffold.final.fa ref/Nemve1.fasta ref/GCA_001417965.1_Aiptasia_genome_1.1_genomic.fna
	bash Shell/make_blastdb.sh ref/cni_blastdb $^

# Make Symbiodinium BLAST database
ref/sym_blastdb.nal:
	bash Shell/make_blastdb.sh ref/sym_blastdb ref/symbB.v1.0.genome.fa ref/Smic.genome.scaffold.final.fa

# Add length annotations to scaffolds
filter/allseqs.fasta: weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta
	cat weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta | seqkit fx2tab --length | awk -F "\t" '{print $$1"["$$4"]\t"$$2}' | seqkit tab2fx > filter/allseqs.fasta




