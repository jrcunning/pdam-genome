all: Development_Human_blastout.txt StressResponse_Human_blastout.txt Immunity_human_blastout.txt WoundHealing_Human_blastout.txt

Development_Human_blastout.txt: Development_Human_Fasta.txt cni.nal
	tblastn -db cni -query Development_Human_Fasta.txt -evalue 1 -out Development_Human_blastout -outfmt 11 -num_threads 15
	blast_formatter -archive Development_Human_blastout -outfmt 4 -num_descriptions 500 -num_alignments 0 > Development_Human_blastout.txt

StressResponse_Human_blastout.txt: StressResponse_Human_Fasta.txt cni.nal
	tblastn -db cni -query StressResponse_Human_Fasta.txt -evalue 1 -out StressResponse_Human_blastout -outfmt 11 -num_threads 15
	blast_formatter -archive StressResponse_Human_blastout -outfmt 4 -num_descriptions 500 -num_alignments 0 > StressResponse_Human_blastout.txt

Immunity_human_blastout.txt: Immunity_human_fasta.txt cni.nal
	tblastn -db cni -query Immunity_human_fasta.txt -evalue 1 -out Immunity_human_blastout -outfmt 11 -num_threads 15
	blast_formatter -archive Immunity_human_blastout -outfmt 4 -num_descriptions 500 -num_alignments 0 > Immunity_human_blastout.txt

WoundHealing_Human_blastout.txt: WoundHealing_Human_Fasta.txt cni.nal
	tblastn -db cni -query WoundHealing_Human_Fasta.txt -evalue 1 -out WoundHealing_Human_blastout -outfmt 11 -num_threads 15
	blast_formatter -archive WoundHealing_Human_blastout -outfmt 4 -num_descriptions 500 -num_alignments 0 > WoundHealing_Human_blastout.txt

cni.nal: make_cni_blastdb.sh
	./make_cni_blastdb.sh cni ~/ref/Discosoma/dspp.genome.renamed.fa ~/ref/Amplexidiscus/afen.genome.renamed.fa ~/ref/Orbicella/GCF_002042975.1_ofav_dov_v1_genomic.fna ~/ref/Nematostella/Nemve1.fasta ~/ref/Acropora/adi_v1.0.scaffold.fa ~/ref/Hydra/GCF_000004095.1_Hydra_RP_1.0_genomic.fna ~/ref/Aiptasia/GCA_001417965.1_Aiptasia_genome_1.1_genomic.fna ~/ref/Pocillopora/pdam.fasta
