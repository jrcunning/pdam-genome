all: blast_results/blast_summary_all.txt

blast_results/blast_summary_all.txt: blast_results/1e-1_summary.txt blast_results/1e-2_summary.txt blast_results/1e-3_summary.txt blast_results/1e-4_summary.txt blast_results/1e-5_summary.txt blast_results/1e-10_summary.txt
	awk 'FNR==1 && NR!=1 { while (/^e-value/) getline; } 1 {print}' blast_results/*_summary.txt | awk 'NR == 1; NR > 1 {print $0 | "sort -gr"}' > blast_results/summary.txt

blast_results/1e-1_summary.txt: Shell/filter_coral_seqs.sh ref/coral_blastdb.nsq ref/sym_blastdb.nsq
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-1
blast_results/1e-2_summary.txt: Shell/filter_coral_seqs.sh ref/coral_blastdb.nsq ref/sym_blastdb.nsq
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-2
blast_results/1e-3_summary.txt: Shell/filter_coral_seqs.sh ref/coral_blastdb.nsq ref/sym_blastdb.nsq
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-3
blast_results/1e-4_summary.txt: Shell/filter_coral_seqs.sh ref/coral_blastdb.nsq ref/sym_blastdb.nsq
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-4
blast_results/1e-5_summary.txt: Shell/filter_coral_seqs.sh ref/coral_blastdb.nsq ref/sym_blastdb.nsq
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-5
blast_results/1e-10_summary.txt: Shell/filter_coral_seqs.sh ref/coral_blastdb.nsq ref/sym_blastdb.nsq
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-10

ref/coral_blastdb.nsq: ref/adi_v1.0.scaffold.fa
	makeblastdb -dbtype nucl -in $< -out ref/coral_blastdb

ref/sym_blastdb.nsq: ref/symbB.v1.0.genome.fa
	makeblastdb -dbtype nucl -in $< -out ref/sym_blastdb


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

