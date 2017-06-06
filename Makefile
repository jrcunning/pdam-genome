all: gag_out/genome.stats

# Generate annotation statistics using GAG
gag_out/genome.stats: pdam.maker.output/pdam.all.renamed.function.gff
	python ~/local/GAG/gag.py --fasta data/filter/pdam.fasta --gff pdam.maker.output/pdam.all.gff --fix_start_stop --out gag_out

# Add putative gene function annotations
pdam.maker.output/pdam.all.renamed.function.gff: pdam.maker.output/blastp.output.renamed
	maker_functional_gff data/ref/uniprot_sprot.fasta pdam.maker.output/blastp.output.renamed pdam.maker.output/pdam.all.renamed.gff > pdam.maker.output/pdam.all.renamed.function.gff
	maker_functional_fasta data/ref/uniprot_sprot.fasta pdam.maker.output/blastp.output.renamed pdam.maker.output/pdam.all.maker.proteins.renamed.fasta > pdam.maker.output/pdam.all.maker.proteins.renamed.function.fasta
	maker_functional_fasta data/ref/uniprot_sprot.fasta pdam.maker.output/blastp.output.renamed pdam.maker.output/pdam.all.maker.transcripts.renamed.fasta > pdam.maker.output/pdam.all.maker.transcripts.renamed.function.fasta


# Rename genes in output
pdam.maker.output/blastp.output.renamed: pdam.maker.output/blastp.output
	maker_map_ids --prefix pdam_ --justify 8 pdam.maker.output/pdam.all.gff > pdam.maker.output/pdam.all.id.map
	cp pdam.maker.output/pdam.all.gff pdam.maker.output/pdam.all.renamed.gff
	cp pdam.maker.output/pdam.all.maker.proteins.fasta pdam.maker.output/pdam.all.maker.proteins.renamed.fasta
	cp pdam.maker.output/pdam.all.maker.transcripts.fasta pdam.maker.output/pdam.all.maker.transcripts.renamed.fasta
	cp pdam.maker.output/blastp.output pdam.maker.output/blastp.output.renamed
	map_gff_ids pdam.maker.output/pdam.all.id.map pdam.maker.output/pdam.all.renamed.gff
	map_fasta_ids pdam.maker.output/pdam.all.id.map pdam.maker.output/pdam.all.maker.proteins.renamed.fasta
	map_fasta_ids pdam.maker.output/pdam.all.id.map pdam.maker.output/pdam.all.maker.transcripts.renamed.fasta
	map_data_ids pdam.maker.output/pdam.all.id.map pdam.maker.output/blastp.output.renamed

# BLAST maker proteins against uniprot-sprot
pdam.maker.output/blastp.output: pdam.maker.output/pdam.all.gff
	cd data/ref && makeblastdb -in uniprot_sprot.fasta -dbtype prot -out uniprot_sprot.db
	blastp -db data/ref/uniprot_sprot.db -query pdam.maker.output/pdam.all.maker.proteins.fasta -outfmt 6 -num_threads 96 -out pdam.maker.output/blastp.output

# Run InterProScan on MAKER proteins
interproscan/pdam_ips.gff3: pdam.maker.output/pdam.all.maker.proteins.fasta
        interproscan.sh -i pdam.maker.output/pdam.all.maker.proteins.fasta -b interproscan/pdam_ips --goterms -f GFF3

# Re-run MAKER using SNAP HMM file, collect results
pdam.maker.output/pdam.all.gff: snap/pdam.hmm
	mpiexec -mca btl ^openib -n 96 maker -base pdam maker_ctl/1/maker_opts.ctl maker_ctl/1/maker_bopts.ctl maker_ctl/1/maker_exe.ctl -fix_nucleotides
	cd pdam.maker.output && gff3_merge -d pdam_master_datastore_index.log && fasta_merge -d pdam_master_datastore_index.log

# Train SNAP gene predictor based on initial MAKER run output
snap/pdam.hmm: pdam.maker.output/pdam0.all.gff
	rm -rf snap
	mkdir snap
	cd snap && maker2zff ../pdam.maker.output/pdam0.all.gff && \
	fathom -categorize 1000 genome.ann genome.dna && \
	fathom -export 1000 -plus uni.ann uni.dna && \
	forge export.ann export.dna && \
	hmm-assembler.pl pdam . > pdam.hmm

# Run initial MAKER annotation, collect results into pdam0.all.gff
pdam.maker.output/pdam0.all.gff: busco/run_pdam/short_summary_pdam.txt maker_ctl/0/maker_opts.ctl
	mpiexec -mca btl ^openib -n 96 maker -base pdam maker_ctl/0/maker_opts.ctl maker_ctl/0/maker_bopts.ctl maker_ctl/0/maker_exe.ctl -fix_nucleotides
	cd pdam.maker.output && gff3_merge -d pdam_master_datastore_index.log && \
	mv pdam.all.gff pdam0.all.gff


# Run BUSCO on filtered pdam assembly and train Augustus
busco/run_pdam/short_summary_pdam.txt: data/filter/pdam.fasta
	cd /scratch/projects/crf/pdam-genome/busco && \
	python ~/local/busco/BUSCO.py -f -c 96 --long -i ../data/filter/pdam.fasta -o pdam -l ~/local/busco/metazoa_odb9 -m geno

# Remove bacteria, virus, and Symbiodinium scaffolds from full assembly to generate filtered pdam assembly
data/filter/pdam.fasta:
	cd data && make
