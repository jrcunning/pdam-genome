#!/bin/bash

blastn -query $1 -db ref/coral_blastdb -outfmt 6 -max_target_seqs 1 -num_threads 4 \
  -evalue $2 \
  > blast_results/$2_coral_blast_results.txt

sort -u -k1,1 blast_results/$2_coral_blast_results.txt \
  > blast_results/$2_coral_blast_results_filtered.txt

blastn -query $1 -db ref/sym_blastdb -outfmt 6 -max_target_seqs 1 -num_threads 4 \
  -evalue $2 \
  > blast_results/$2_sym_blast_results.txt

sort -u -k1,1 blast_results/$2_sym_blast_results.txt \
  > blast_results/$2_sym_blast_results_filtered.txt

comm -12 <(cut -f1 blast_results/$2_coral_blast_results_filtered.txt) <(cut -f1 blast_results/$2_sym_blast_results_filtered.txt) \
  > blast_results/$2_both_seqids.txt

comm -23 <(cut -f1 blast_results/$2_coral_blast_results_filtered.txt) <(cut -f1 blast_results/$2_sym_blast_results_filtered.txt) \
  > blast_results/$2_coral_only_seqids.txt

comm -13 <(cut -f1 blast_results/$2_coral_blast_results_filtered.txt) <(cut -f1 blast_results/$2_sym_blast_results_filtered.txt) \
  > blast_results/$2_sym_only_seqids.txt

coral_hits=`cat blast_results/$2_coral_blast_results_filtered.txt | wc -l`
sym_hits=`cat blast_results/$2_sym_blast_results_filtered.txt | wc -l`
both_hits=`cat blast_results/$2_both_seqids.txt | wc -l`
coral_only=`cat blast_results/$2_coral_only_seqids.txt | wc -l`
sym_only=`cat blast_results/$2_sym_only_seqids.txt | wc -l`

echo -e "e-value\tcoral_hits\tsym_hits\tboth_hits\tcoral_only\tsym_only\n$2\t$coral_hits\t$sym_hits\t$both_hits\t$coral_only\t$sym_only" > blast_results/$2_summary.txt
