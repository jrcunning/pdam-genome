all: blast_results/blast_summary_all.txt

blast_results/blast_summary_all.txt: data/coral_seqs_1e-1.fasta data/coral_seqs_1e-2.fasta data/coral_seqs_1e-3.fasta data/coral_seqs_1e-4.fasta data/coral_seqs_1e-5.fasta data/coral_seqs_1e-10.fasta
	cat blast_results/*_summary.txt > blast_results/blast_summary_all.txt

data/coral_seqs_1e-1.fasta: Shell/filter_coral_seqs.sh ref/coral_blastdb.nsq ref/sym_blastdb.nsq
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-1
data/coral_seqs_1e-2.fasta: Shell/filter_coral_seqs.sh ref/coral_blastdb.nsq ref/sym_blastdb.nsq
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-2
data/coral_seqs_1e-3.fasta: Shell/filter_coral_seqs.sh ref/coral_blastdb.nsq ref/sym_blastdb.nsq
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-3
data/coral_seqs_1e-4.fasta: Shell/filter_coral_seqs.sh ref/coral_blastdb.nsq ref/sym_blastdb.nsq
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-4
data/coral_seqs_1e-5.fasta: Shell/filter_coral_seqs.sh ref/coral_blastdb.nsq ref/sym_blastdb.nsq
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-5
data/coral_seqs_1e-10.fasta: Shell/filter_coral_seqs.sh ref/coral_blastdb.nsq ref/sym_blastdb.nsq
	bash Shell/filter_coral_seqs.sh \
	data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
	1e-10

ref/coral_blastdb.nsq: ref/adi_v1.0.scaffold.fa
	makeblastdb -dbtype nucl -in $< -out ref/coral_blastdb

ref/sym_blastdb.nsq: ref/symbB.v1.0.genome.fa
	makeblastdb -dbtype nucl -in $< -out ref/sym_blastdb







#python ~/psytrans/psytrans3.py -v \
#  -p 8 \
#  -H ref/adi_v1.0.scaffold.fa \
#  -S ref/symbB.v1.0.genome.fa \
#  -o psytrans_output \
#  data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta

