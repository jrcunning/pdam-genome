#!/bin/bash

blastn -query $1 -db ref/coral_blastdb -outfmt 6 -max_target_seqs 1 -num_threads 4 \
  -evalue $2 \
  > blast_results/coral_blast_results_$2.txt

sort -u -k1,1 blast_results/coral_blast_results_$2.txt \
  > blast_results/coral_blast_results_$2_filtered.txt

blastn -query $1 -db ref/sym_blastdb -outfmt 6 -max_target_seqs 1 -num_threads 4 \
  -evalue $2 \
  > blast_results/sym_blast_results_$2.txt

sort -u -k1,1 blast_results/sym_blast_results_$2.txt \
  > blast_results/sym_blast_results_$2_filtered.txt

comm -12 <(cut -f1 blast_results/coral_blast_results_$2_filtered.txt) <(cut -f1 blast_results/sym_blast_results_$2_filtered.txt) \
  > blast_results/seqids_both_$2.txt

comm -23 <(cut -f1 blast_results/coral_blast_results_$2_filtered.txt) <(cut -f1 blast_results/sym_blast_results_$2_filtered.txt) \
  > blast_results/seqids_coral_only_$2.txt

comm -13 <(cut -f1 blast_results/coral_blast_results_$2_filtered.txt) <(cut -f1 blast_results/sym_blast_results_$2_filtered.txt) \
  > blast_results/seqids_sym_only_$2.txt

filter_fasta.py \
  -f data/weedy_coral_01Feb2017_zhEnG/weedy_coral_01Feb2017_zhEnG.fasta \
  -s blast_results/seqids_coral_only_$2.txt \
  -o data/coral_seqs_$2.fasta

coral_hits=`cat blast_results/coral_blast_results_$2_filtered.txt | wc -l`
sym_hits=`cat blast_results/sym_blast_results_$2_filtered.txt | wc -l`
both_hits=`cat blast_results/seqids_both_$2.txt | wc -l`
coral_only=`cat blast_results/seqids_coral_only_$2.txt | wc -l`
sym_only=`cat blast_results/seqids_sym_only_$2.txt | wc -l`

echo $2 $coral_hits $sym_hits $both_hits $coral_only $sym_only > blast_results/$2_summary.txt
