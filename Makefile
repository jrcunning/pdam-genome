all: blast_results/summary.txt

blast_results/summary.txt: blast_results/1e-1_summary.txt blast_results/1e-2_summary.txt blast_results/1e-3_summary.txt blast_results/1e-4_summary.txt blast_results/1e-5_summary.txt blast_results/1e-10_summary.txt
	awk 'FNR==1 && NR!=1 { while (/^e-value/) getline; } 1 {print}' blast_results/*_summary.txt | awk 'NR == 1; NR > 1 {print $0 | "sort -gr"}' > blast_results/summary.txt

blast_results/1e-1_summary.txt: Shell/filter_coral_seqs.sh ref/cni_blastdb.nal ref/sym_blastdb.nal
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-1
blast_results/1e-2_summary.txt: Shell/filter_coral_seqs.sh ref/cni_blastdb.nal ref/sym_blastdb.nal
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-2
blast_results/1e-3_summary.txt: Shell/filter_coral_seqs.sh ref/cni_blastdb.nal ref/sym_blastdb.nal
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-3
blast_results/1e-4_summary.txt: Shell/filter_coral_seqs.sh ref/cni_blastdb.nal ref/sym_blastdb.nal
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-4
blast_results/1e-5_summary.txt: Shell/filter_coral_seqs.sh ref/cni_blastdb.nal ref/sym_blastdb.nal
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-5
blast_results/1e-10_summary.txt: Shell/filter_coral_seqs.sh ref/cni_blastdb.nal ref/sym_blastdb.nal
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-10

ref/cni_blastdb.nal: ref/adi_v1.0.scaffold.fa ref/Nemve1.fasta ref/GCA_001417965.1_Aiptasia_genome_1.1_genomic.fna
	bash Shell/make_blastdb.sh ref/cni_blastdb $^

ref/sym_blastdb.nal: ref/symbB.v1.0.genome.fa ref/Smic.genome.scaffold.final.fa
	bash Shell/make_blastdb.sh ref/sym_blastdb $^


#filter_fasta.py \
#  -f data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
#  -s blast_results/$2_coral_only_seqids.txt \
#  -o data/coral_seqs_$2.fasta




#python ~/psytrans/psytrans3.py -v \
#  -p 8 \
#  -H ref/adi_v1.0.scaffold.fa \
#  -S ref/symbB.v1.0.genome.fa \
#  -o psytrans_output \
#  data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta

