# annotation/Makefile
all: gag_out/genome.stats

# Run BUSCO on filtered pdam assembly and train Augustus
busco/run_pdam/short_summary_pdam.txt: ../data/filter/pdam.fasta
	cd /scratch/projects/crf/pdam-genome/busco && \
	python ~/local/busco/BUSCO.py -f -c 96 --long -i ../data/filter/pdam.fasta -o pdam -l ~/local/busco/metazoa_odb9 -m geno

# Run RepeatModeler and RepeatMasker
repeatmasker/pdam.fasta.out: ../data/filter/pdam.fasta
	cd repeatmasker && make
	
# Run initial MAKER annotation, collect results into pdam0.all.gff
pdam.maker.output/pdam0.all.gff: busco/run_pdam/short_summary_pdam.txt maker_ctl/0/maker_opts.ctl
	mpiexec -mca btl ^openib -n 96 maker -base pdam maker_ctl/0/maker_opts.ctl maker_ctl/0/maker_bopts.ctl maker_ctl/0/maker_exe.ctl -fix_nucleotides
	cd pdam.maker.output && gff3_merge -d pdam_master_datastore_index.log && \
	mv pdam.all.gff pdam0.all.gff
	
# Train SNAP gene predictor based on initial MAKER run output
snap/pdam.hmm: pdam.maker.output/pdam0.all.gff
	rm -rf snap
	mkdir snap
	cd snap && maker2zff ../pdam.maker.output/pdam0.all.gff && \
	fathom -categorize 1000 genome.ann genome.dna && \
	fathom -export 1000 -plus uni.ann uni.dna && \
	forge export.ann export.dna && \
	hmm-assembler.pl pdam . > pdam.hmm
	
# Re-run MAKER using SNAP HMM file, collect results
pdam.maker.output/pdam.all.gff: snap/pdam.hmm
	mpiexec -mca btl ^openib -n 96 maker -base pdam maker_ctl/1/maker_opts.ctl maker_ctl/1/maker_bopts.ctl maker_ctl/1/maker_exe.ctl -fix_nucleotides
	cd pdam.maker.output && gff3_merge -d pdam_master_datastore_index.log && fasta_merge -d pdam_master_datastore_index.log

# Run InterProScan on MAKER proteins
interproscan/pdam_ips.tsv: pdam.maker.output/pdam.all.maker.proteins.fasta
	interproscan.sh -i pdam.maker.output/pdam.all.maker.proteins.fasta -b interproscan/pdam_ips --goterms

# BLAST maker proteins against uniprot-sprot
pdam.maker.output/blastp.output: pdam.maker.output/pdam.all.gff
	cd data/ref && makeblastdb -in uniprot_sprot.fasta -dbtype prot -out uniprot_sprot.db
	blastp -db data/ref/uniprot_sprot.db -query pdam.maker.output/pdam.all.maker.proteins.fasta \
	-evalue 1e-5 -outfmt 6 -num_threads 96 -num_alignments 1 \
	-out pdam.maker.output/blastp.output
	
# BLAST maker proteins against nr database
pdam.maker.output/blastp.nr.output:
	blastp -db nr -remote -query pdam.maker.output/pdam.all.maker.proteins.fasta \
	-evalue 1e-5 -outfmt 6 -num_alignments 1 \
	-out pdam.maker.output/blastp.nr.output
	
# Rename genes in output
pdam.maker.output/blastp.output.renamed: pdam.maker.output/blastp.output
	maker_map_ids --prefix pdam_ --justify 8 pdam.maker.output/pdam.all.gff > pdam.maker.output/pdam.all.id.map
	cp pdam.maker.output/pdam.all.gff pdam.maker.output/pdam.all.renamed.gff
	cp pdam.maker.output/pdam.all.maker.proteins.fasta pdam.maker.output/pdam.all.maker.proteins.renamed.fasta
	cp pdam.maker.output/pdam.all.maker.transcripts.fasta pdam.maker.output/pdam.all.maker.transcripts.renamed.fasta
	cp pdam.maker.output/blastp.output pdam.maker.output/blastp.output.renamed
	cp interproscan/pdam_ips.tsv interproscan/pdam_ips.renamed.tsv
	map_data_ids pdam.maker.output/pdam.all.id.map interproscan/pdam_ips.renamed.tsv
	map_gff_ids pdam.maker.output/pdam.all.id.map pdam.maker.output/pdam.all.renamed.gff
	map_fasta_ids pdam.maker.output/pdam.all.id.map pdam.maker.output/pdam.all.maker.proteins.renamed.fasta
	map_fasta_ids pdam.maker.output/pdam.all.id.map pdam.maker.output/pdam.all.maker.transcripts.renamed.fasta
	map_data_ids pdam.maker.output/pdam.all.id.map pdam.maker.output/blastp.output.renamed

# Add putative gene function annotations
pdam.maker.output/pdam.all.renamed.function.gff: pdam.maker.output/blastp.output.renamed
	maker_functional_gff data/ref/uniprot_sprot.fasta pdam.maker.output/blastp.output.renamed pdam.maker.output/pdam.all.renamed.gff > pdam.maker.output/pdam.all.renamed.function.gff
	maker_functional_fasta data/ref/uniprot_sprot.fasta pdam.maker.output/blastp.output.renamed pdam.maker.output/pdam.all.maker.proteins.renamed.fasta > pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta
	maker_functional_fasta data/ref/uniprot_sprot.fasta pdam.maker.output/blastp.output.renamed pdam.maker.output/pdam.all.maker.transcripts.renamed.fasta > pdam.maker.output/pdam.all.maker.transcripts.renamed.function.fasta

# Add protein domain information to final annotation
pdam.all.renamed.function.domain.gff: pdam.maker.output/pdam.all.renamed.function.gff
	ipr_update_gff pdam.maker.output/pdam.all.renamed.function.gff interproscan/pdam_ips.renamed.tsv > pdam.all.renamed.function.domain.gff

# Convert annotation to NCBI format
sqn/pdam.sqn:
	python ~/software/gag/gag.py --fasta ../data/filter/pdam.fasta --gff pdam.all.renamed.function.domain.gff --out pdam_annot.tbl
	cp pdam_annot.tbl/genome.tbl sqn/pdam.tbl
	cp ../data/filter/pdam.fasta sqn/pdam.fsa
	cd sqn && ~/tbl2asn -t template.sbt -p ./ -M n -Z discrep -a r10k -l paired-ends 
	
# Filter out genes only from gff
genes.gff: 
	awk '($$3 == "gene") {print $$0}' pdam.all.renamed.function.domain.gff > $@

# Get GO terms for all genes
pdam_genes_GO.txt: genes.gff
	sed -n 's/.*ID=\([^;]*\).*Ontology_term=\(.*\)/\1\t\2/p' $< | sed 's/,/, /g' | sed 's/;//g' > $@

# Generate annotation statistics using GAG
gag_out/genome.stats: pdam.all.renamed.function.domain.gff
	python ~/local/GAG/gag.py --fasta ../data/filter/pdam.fasta --gff pdam.all.renamed.function.domain.gff --fix_start_stop --out gag_out




