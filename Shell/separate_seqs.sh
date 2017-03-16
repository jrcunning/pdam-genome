#!/bin/bash

# arguments: 1: e-value choice

# Get the coral only sequences
filter_fasta.py -s blast_results/$1_cni_only_seqids.txt -f data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta -o filtered_seqs/$1_coral_only.fasta

# Get the symbiont only sequences
filter_fasta.py -s blast_results/$1_sym_only_seqids.txt -f data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta -o filtered_seqs/$1_sym_only.fasta

# Get the sequences that had no hits
cat blast_results/$1_cni_blast_results_filtered.txt blast_results/$1_sym_blast_results_filtered.txt > blast_results/$1_all_hits.txt
filter_fasta.py -n \
-s blast_results/$1_all_hits.txt \
-f data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
-o filtered_seqs/$1_no_hits.fasta

# count sequences and get mean length for each set
count_seqs.py -i filtered_seqs/$1_coral_only.fasta,filtered_seqs/$1_sym_only.fasta,filtered_seqs/$1_no_hits.fasta -o filtered_seqs/count_seqs_output.txt
