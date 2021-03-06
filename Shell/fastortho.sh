#!/bin/bash

rm ../data/ref/all.pep
###Run FastOrtho
FastOrtho \
	$(printf "!!single_genome_fasta %s " ../data/ref/*.pep | tr "!" -) \
	--working_directory . --project_name version1 --blast_cpus 96

##Format output file	
sed -E "s/\s+\((\S+)\s+genes,(\S+)\s+taxa\)\:\s+/ \1 \2 /" version1.end | sed -E -e 's/ /\t/' -e 's/ /\t/' -e 's/ /\t/' > ortho.table
